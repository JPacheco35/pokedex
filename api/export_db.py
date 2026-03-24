"""
Export database contents to JSON files.

This script exports all Pokemon data to JSON format, which can be:
1. Committed to Git for version control
2. Used to reimport data into other databases
3. Shared with other developers

Run with: python export_db.py
"""

import json
from database import sessionLocal
from models import Pokemon, Type, Move, Ability


def serialize_pokemon(pokemon):
    """Convert a Pokemon object to a dictionary"""
    return {
        'id': pokemon.id,
        'name': pokemon.name,
        'generation': pokemon.generation,
        'height': pokemon.height,
        'weight': pokemon.weight,
        'base_experience': pokemon.base_experience,
        'stats': {
            'hp': pokemon.hp,
            'attack': pokemon.attack,
            'defense': pokemon.defense,
            'special_attack': pokemon.special_attack,
            'special_defense': pokemon.special_defense,
            'speed': pokemon.speed,
        },
        'sprites': pokemon.sprites,
        'cries': pokemon.cries,
        'types': [t.name for t in pokemon.types],
        'moves': [m.name for m in pokemon.moves],
        'abilities': [a.name for a in pokemon.abilities],
    }


def serialize_type(type_obj):
    """Convert a Type object to a dictionary"""
    return {
        'id': type_obj.id,
        'name': type_obj.name,
        'double_damage_to': type_obj.double_damage_to,
        'double_damage_from': type_obj.double_damage_from,
        'half_damage_to': type_obj.half_damage_to,
        'half_damage_from': type_obj.half_damage_from,
        'no_damage_to': type_obj.no_damage_to,
        'no_damage_from': type_obj.no_damage_from,
    }


def serialize_move(move):
    """Convert a Move object to a dictionary"""
    return {
        'id': move.id,
        'name': move.name,
        'description': move.description,
        'type': move.type,
        'power': move.power,
        'accuracy': move.accuracy,
        'damage_class': move.damage_class,
    }


def serialize_ability(ability):
    """Convert an Ability object to a dictionary"""
    return {
        'id': ability.id,
        'name': ability.name,
        'description': ability.description,
    }


def export_database():
    """Export all database contents to JSON files"""
    db = sessionLocal()
    
    try:
        # Fetch all data
        pokemon_list = db.query(Pokemon).all()
        type_list = db.query(Type).all()
        move_list = db.query(Move).all()
        ability_list = db.query(Ability).all()
        
        # Serialize to dictionaries
        pokemon_data = [serialize_pokemon(p) for p in pokemon_list]
        type_data = [serialize_type(t) for t in type_list]
        move_data = [serialize_move(m) for m in move_list]
        ability_data = [serialize_ability(a) for a in ability_list]
        
        # Create export object
        export = {
            'metadata': {
                'total_pokemon': len(pokemon_data),
                'total_types': len(type_data),
                'total_moves': len(move_data),
                'total_abilities': len(ability_data),
            },
            'pokemon': pokemon_data,
            'types': type_data,
            'moves': move_data,
            'abilities': ability_data,
        }
        
        # Write to file
        with open('pokedex_export.json', 'w') as f:
            json.dump(export, f, indent=2)
        
        print(f"✅ Database exported to pokedex_export.json")
        print(f"   📊 {len(pokemon_data)} Pokemon")
        print(f"   🎯 {len(type_data)} Types")
        print(f"   🎮 {len(move_data)} Moves")
        print(f"   ⚡ {len(ability_data)} Abilities")
        
    finally:
        db.close()


if __name__ == "__main__":
    export_database()

