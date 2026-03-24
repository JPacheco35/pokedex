"""
Fetch Pokémon data from PokéAPI and store in PostgreSQL database.

This script demonstrates:
1. How to fetch data from an external API (PokéAPI)
2. How to parse JSON responses
3. How to handle relationships when creating database records
4. Error handling and data validation

PokéAPI Documentation: https://pokeapi.co/docs/v2
"""



import requests
import time
from database import sessionLocal, init_db
from models import Pokemon, Type, Move, Ability

# Initialize database tables
init_db()

# Create a database session
db = sessionLocal()

# Configuration
POKEAPI_BASE_URL = "https://pokeapi.co/api/v2"
POKEMON_LIMIT = 3  # Quick test with 3 Pokemon
API_TIME_DELAY = 0.1

def fetch_pokemon_list(limit=POKEMON_LIMIT):
    print(f"Fetching {limit} Pokemon from PokéAPI...")
    url = f"{POKEAPI_BASE_URL}/pokemon?limit={limit}&offset=0"
    response = requests.get(url)
    response.raise_for_status()  # Raise error if request fails
    
    data = response.json()
    return data['results']


def fetch_pokemon_details(pokemon_name):
    url = f"{POKEAPI_BASE_URL}/pokemon/{pokemon_name.lower()}"
    response = requests.get(url)
    response.raise_for_status()
    return response.json()


def fetch_type_details(type_name):
    url = f"{POKEAPI_BASE_URL}/type/{type_name.lower()}"
    time.sleep(API_TIME_DELAY)
    response = requests.get(url)
    response.raise_for_status()
    return response.json()


def get_or_create_type(type_name):
    # Check if type already exists
    existing_type = db.query(Type).filter_by(name=type_name).first()
    
    if existing_type:
        return existing_type  # Skip if already exists
    
    # Create new type if it doesn't exist
    print(f"  Creating new Type: {type_name}")
    try:
        type_data = fetch_type_details(type_name)
        
        # Extract damage relations - convert from list of dicts to list of names
        damage_relations = type_data.get('damage_relations', {})
        
        double_damage_to = [t['name'] for t in damage_relations.get('double_damage_to', [])]
        double_damage_from = [t['name'] for t in damage_relations.get('double_damage_from', [])]
        half_damage_to = [t['name'] for t in damage_relations.get('half_damage_to', [])]
        half_damage_from = [t['name'] for t in damage_relations.get('half_damage_from', [])]
        no_damage_to = [t['name'] for t in damage_relations.get('no_damage_to', [])]
        no_damage_from = [t['name'] for t in damage_relations.get('no_damage_from', [])]
        
        new_type = Type(
            name=type_name,
            double_damage_to=double_damage_to,
            double_damage_from=double_damage_from,
            half_damage_to=half_damage_to,
            half_damage_from=half_damage_from,
            no_damage_to=no_damage_to,
            no_damage_from=no_damage_from
        )
        db.add(new_type)
        # Don't commit here - let the caller handle commits
        return new_type
    except Exception as e:
        print(f"    ⚠️  Error creating type {type_name}: {e}")
        db.rollback()
        return None


def get_or_create_move(move_name):
    existing_move = db.query(Move).filter_by(name=move_name).first()
    
    if existing_move:
        return existing_move  # Skip if already exists
    
    print(f"  Creating new Move: {move_name}")
    try:
        url = f"{POKEAPI_BASE_URL}/move/{move_name.lower()}"
        time.sleep(API_TIME_DELAY)
        response = requests.get(url)
        response.raise_for_status()
        move_data = response.json()
        
        # Find English description by searching through effect_entries
        description = 'No description'
        effect_entries = move_data.get('effect_entries', [])
        for entry in effect_entries[:5]:
            if entry.get('language', {}).get('name') == 'en':
                description = entry.get('effect', 'No description')
                break
        
        new_move = Move(
            name=move_name,
            description=description,
            type=move_data.get('type', {}).get('name', 'unknown'),
            power=move_data.get('power'),
            accuracy=move_data.get('accuracy'),
            damage_class=move_data.get('damage_class', {}).get('name', 'unknown')
        )
        db.add(new_move)
        # Don't commit here - let the caller handle commits
        return new_move
    except Exception as e:
        print(f"    ⚠️  Error creating move {move_name}: {e}")
        db.rollback()
        return None


def get_or_create_ability(ability_name):
    existing_ability = db.query(Ability).filter_by(name=ability_name).first()
    
    if existing_ability:
        return existing_ability  # Skip if already exists
    
    print(f"  Creating new Ability: {ability_name}")
    try:
        url = f"{POKEAPI_BASE_URL}/ability/{ability_name.lower()}"
        time.sleep(API_TIME_DELAY)
        response = requests.get(url)
        response.raise_for_status()
        ability_data = response.json()
        
        # Find English description by searching through effect_entries
        description = 'No description'
        effect_entries = ability_data.get('effect_entries', [])
        for entry in effect_entries:
            if entry.get('language', {}).get('name') == 'en':
                description = entry.get('effect', 'No description')
                break
        
        new_ability = Ability(
            name=ability_name,
            description=description
        )
        db.add(new_ability)
        # Don't commit here - let the caller handle commits
        return new_ability
    except Exception as e:
        print(f"    ⚠️  Error creating ability {ability_name}: {e}")
        db.rollback()
        return None


def extract_generation_sprites(pokemon_data):
    """
    Extract sprites from all generations (1-9) and HOME.
    Returns a dictionary with generation as keys and {default, shiny} URLs.
    
    Structure:
    {
        "gen-1": {"default": "url", "shiny": "url"},
        "gen-2": {"default": "url", "shiny": "url"},
        ...
        "home": {"default": "url", "shiny": "url"}
    }
    """
    sprites_data = pokemon_data.get('sprites', {})
    versions = sprites_data.get('versions', {})
    
    # Map generation names to friendly names
    gen_mapping = {
        'generation-i': 'gen-1',
        'generation-ii': 'gen-2',
        'generation-iii': 'gen-3',
        'generation-iv': 'gen-4',
        'generation-v': 'gen-5',
        'generation-vi': 'gen-6',
        'generation-vii': 'gen-7',
        'generation-viii': 'gen-8',
        'generation-ix': 'gen-9',
    }
    
    # Preferred game versions for each generation
    # If the preferred version doesn't exist, fall back to first available
    preferred_versions = {
        'generation-vii': 'ultra-sun-ultra-moon',  # Prefer Ultra Sun/Ultra Moon for gen-7
    }
    
    extracted_sprites = {}
    
    # Extract sprites from each generation
    for api_gen_name, friendly_name in gen_mapping.items():
        if api_gen_name in versions:
            gen_data = versions[api_gen_name]
            
            # Check if we have a preferred game version for this generation
            preferred = preferred_versions.get(api_gen_name)
            
            # Try to get preferred version first
            game_data = None
            if preferred and preferred in gen_data:
                game_data = gen_data[preferred]
            else:
                # Fall back to first available game version
                for game_version, data in gen_data.items():
                    if isinstance(data, dict):
                        game_data = data
                        break
            
            if game_data and isinstance(game_data, dict):
                default_sprite = game_data.get('front_default')
                shiny_sprite = game_data.get('front_shiny')
                
                if default_sprite or shiny_sprite:
                    extracted_sprites[friendly_name] = {
                        'default': default_sprite,
                        'shiny': shiny_sprite
                    }
    
    # Extract HOME sprites
    if 'other' in sprites_data:
        home_data = sprites_data['other'].get('home', {})
        if home_data:
            extracted_sprites['home'] = {
                'default': home_data.get('front_default'),
                'shiny': home_data.get('front_shiny')
            }
    
    return extracted_sprites


def seed_database():
    try:
        # Fetch list of Pokemon
        pokemon_list = fetch_pokemon_list(POKEMON_LIMIT)
        
        print(f"\nProcessing {len(pokemon_list)} Pokemon...\n")
        
        for i, poke_summary in enumerate(pokemon_list, 1):
            pokemon_name = poke_summary['name']
            print(f"{i}. Fetching {pokemon_name}...")
            
            try:
                # Fetch detailed data for this Pokemon
                pokemon_data = fetch_pokemon_details(pokemon_name)
                
                # Check if already in database
                # existing = db.query(Pokemon).filter_by(name=pokemon_name).first()
                # if existing:
                #     print(f"   ⏭️  {pokemon_name} already exists, skipping...")
                #     continue
                
                # Extract basic stats
                stats = {stat['stat']['name']: stat['base_stat'] for stat in pokemon_data['stats']}
                
                # Extract sprites from all generations
                generation_sprites = extract_generation_sprites(pokemon_data)
                
                # Create Pokemon record
                new_pokemon = Pokemon(
                    name=pokemon_name,
                    generation=1,  # Default for now
                    height=pokemon_data.get('height', 0),
                    weight=pokemon_data.get('weight', 0),
                    base_experience=pokemon_data.get('base_experience', 0),
                    hp=stats.get('hp', 0),
                    attack=stats.get('attack', 0),
                    defense=stats.get('defense', 0),
                    special_attack=stats.get('special-attack', 0),
                    special_defense=stats.get('special-defense', 0),
                    speed=stats.get('speed', 0),
                    cries=[pokemon_data.get('cries', {}).get('latest', '')],
                    sprites=generation_sprites
                )
                
                # Add Types
                for type_obj in pokemon_data.get('types', []):
                    type_name = type_obj['type']['name']
                    type_record = get_or_create_type(type_name)
                    if type_record:
                        new_pokemon.types.append(type_record)
                
                # Add Moves (limit to 5 recent moves to avoid overwhelming DB)
                moves_added = 0
                for move_obj in pokemon_data.get('moves', []):
                    move_name = move_obj['move']['name']
                    move_record = get_or_create_move(move_name)
                    if move_record:
                        new_pokemon.moves.append(move_record)
                        moves_added += 1
                
                # Add Abilities
                for ability_obj in pokemon_data.get('abilities', []):
                    ability_name = ability_obj['ability']['name']
                    ability_record = get_or_create_ability(ability_name)
                    if ability_record:
                        new_pokemon.abilities.append(ability_record)
                
                # Save Pokemon to database
                db.add(new_pokemon)
                db.commit()
                print(f"   ✅ {pokemon_name} saved! ({len(new_pokemon.types)} types, {moves_added} moves, {len(new_pokemon.abilities)} abilities)")
                
            except Exception as e:
                print(f"   ❌ Error processing {pokemon_name}: {e}")
                db.rollback()
                continue
        
        print("\n" + "="*60)
        print("SEEDING COMPLETE - Verifying Data")
        print("="*60)
        
        # Verify what was saved
        pokemon_count = db.query(Pokemon).count()
        type_count = db.query(Type).count()
        move_count = db.query(Move).count()
        ability_count = db.query(Ability).count()
        
        print(f"\n✅ Total Pokemon: {pokemon_count}")
        print(f"✅ Total Types: {type_count}")
        print(f"✅ Total Moves: {move_count}")
        print(f"✅ Total Abilities: {ability_count}")
        
        # Show sample data
        print("\nSample Pokemon:")
        for poke in db.query(Pokemon).limit(3).all():
            print(f"  - {poke.name.upper()}")
            print(f"    Stats: HP={poke.hp}, ATK={poke.attack}, DEF={poke.defense}")
            print(f"    Types: {', '.join([t.name for t in poke.types])}")
            print(f"    Abilities: {', '.join([a.name for a in poke.abilities])}")
        
    except Exception as e:
        print(f"Fatal error: {e}")
        db.rollback()
    finally:
        db.close()


if __name__ == "__main__":
    seed_database()

