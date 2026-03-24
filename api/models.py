from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Table, Boolean, Float, JSON
from datetime import datetime
from sqlalchemy.orm import relationship
from database import Base

pokemon_type = Table(
    'pokemon_type',
    Base.metadata,
    Column('pokemon_id', Integer, ForeignKey('pokemon.id')),
          Column('type_id', Integer, ForeignKey('type.id'))
)

pokemon_move = Table(
    'pokemon_move',
    Base.metadata,
    Column('pokemon_id', Integer, ForeignKey('pokemon.id')),
    Column('move_id', Integer, ForeignKey('move.id'))
)

pokemon_ability = Table(
    'pokemon_ability',
    Base.metadata,
    Column('pokemon_id', Integer, ForeignKey('pokemon.id')),
    Column('ability_id', Integer, ForeignKey('ability.id'))
)


# pokemon model
class Pokemon(Base):
    __tablename__ = 'pokemon'

    # basic info
    id = Column(Integer, primary_key=True)
    name = Column(String, unique=True, index=True)
    generation = Column(Integer, index=True)

    # physical properties
    height = Column(Float, index=True)
    weight = Column(Float, index=True)
    base_experience = Column(Integer)

    # base stats
    hp = Column(Integer, index=True)
    attack = Column(Integer, index=True)
    defense = Column(Integer, index=True)
    special_attack = Column(Integer, index=True)
    special_defense = Column(Integer, index=True)
    speed = Column(Integer, index=True)

    # assets
    cries = Column(JSON)
    sprites = Column(JSON)

    # relationships
    types = relationship('Type', secondary=pokemon_type, backref='pokemon')
    moves = relationship('Move', secondary=pokemon_move, backref='pokemon')
    abilities = relationship('Ability', secondary=pokemon_ability, backref='pokemon')

    # metadata
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)



class Type(Base):
    __tablename__ = 'type'

    # basic info
    id = Column(Integer, primary_key=True)
    name = Column(String, unique=True, index=True)

    # type matchups - damage relationships
    double_damage_to = Column(JSON)          # Types this does 2x damage to
    double_damage_from = Column(JSON)        # Types that do 2x damage to this
    half_damage_to = Column(JSON)            # Types this does 0.5x damage to
    half_damage_from = Column(JSON)          # Types that do 0.5x damage to this
    no_damage_to = Column(JSON)              # Types immune to this type's moves
    no_damage_from = Column(JSON)            # Types immune to attacks of this type


# pokemon move model
class Move(Base):
    __tablename__ = 'move'

    # move info
    id = Column(Integer, primary_key=True)
    name = Column(String, unique=True, index=True)
    description = Column(String)

    # move data
    type = Column(String)
    power = Column(Integer, nullable=True)
    accuracy = Column(Integer, nullable=True)
    damage_class = Column(String) # ie. physical, special, status


# pokemon ability model
class Ability(Base):
    __tablename__ = 'ability'

    id = Column(Integer, primary_key=True)
    name = Column(String, unique=True, index=True)
    description = Column(String)