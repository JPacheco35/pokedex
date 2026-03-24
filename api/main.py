from fastapi import FastAPI, Depends, HTTPException
from contextlib import asynccontextmanager
from sqlalchemy.orm import Session
from typing import List

from database import get_db, init_db
from models import Pokemon as PokemonModel
from schemas import PokemonDetailResponse, PokemonListResponse

# Lifespan event handler
@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup: Initialize database
    init_db()
    print("✅ Database initialized on startup")
    yield
    # Shutdown: Cleanup (if needed in future)
    print("Application shutting down")

app = FastAPI(title="Pokédex API", version="1.0.0", lifespan=lifespan)

# Health check endpoint
@app.get("/health")
def health():
    return {
        "status": "healthy",
        "version": "1.0.0",
    }

# Get all Pokemon (with optional filters)
@app.get("/pokemon", response_model=List[PokemonListResponse])
def get_all_pokemon(
    skip: int = 0,
    limit: int = 20,
    db: Session = Depends(get_db)
):
    """Get a list of all Pokemon with pagination"""
    pokemon = db.query(PokemonModel).offset(skip).limit(limit).all()
    return pokemon

# Get single Pokemon by ID
@app.get("/pokemon/{pokemon_id}", response_model=PokemonDetailResponse)
def get_pokemon(pokemon_id: int, db: Session = Depends(get_db)):
    """Get detailed information about a specific Pokemon"""
    pokemon = db.query(PokemonModel).filter(PokemonModel.id == pokemon_id).first()
    if not pokemon:
        raise HTTPException(status_code=404, detail="Pokemon not found")
    return pokemon

# Search Pokemon by name
@app.get("/pokemon/search/{name}", response_model=List[PokemonListResponse])
def search_pokemon(name: str, db: Session = Depends(get_db)):
    """Search Pokemon by name (case-insensitive)"""
    pokemon = db.query(PokemonModel).filter(
        PokemonModel.name.ilike(f"%{name}%")
    ).all()
    if not pokemon:
        raise HTTPException(status_code=404, detail="No Pokemon found")
    return pokemon
