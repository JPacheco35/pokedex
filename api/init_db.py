"""
Initialize the database by creating all tables.

This script:
1. Imports the database engine
2. Imports all SQLAlchemy models
3. Creates all tables in PostgreSQL
"""

from database import Base, engine
from models import Pokemon, Type, Move, Ability

# Create all tables defined in models
Base.metadata.create_all(bind=engine)

print("✅ Database tables created successfully!")
print("Tables created:")
print("  - pokemon")
print("  - type")
print("  - move")
print("  - ability")
print("  - pokemon_type (association)")
print("  - pokemon_move (association)")
print("  - pokemon_ability (association)")