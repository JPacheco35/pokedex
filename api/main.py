from fastapi import FastAPI, Depends, Query
from sqlalchemy.orm import Session
from typing import List, Optional

from database import get_db, init_db
from models import Pokemon as PokemonModel, Type
from schemas import PokemonListResponse

app = FastAPI(title='Pokedex API')

@app.on_event("startup")
def startup():
    init_db()

# get pokemon, can filter by type and pagination
@app.get("/pokemon", response_model=List[PokemonListResponse])
def list_pokemon(
        skip: int = Query(0, ge=0),
        limit: int = Query(20, ge=1, le=200),
        type_name: Optional[str] = Query(None, alias="type"),
        db: Session = Depends(get_db)
):
    q = db.query(PokemonModel)

    if type_name:
        # recommended: uses WHERE EXISTS, avoids duplicate rows
        q = q.filter(PokemonModel.types.any(Type.name == type_name))

    q = q.order_by(PokemonModel.id)
    q = q.offset(skip).limit(limit)
    return q.all()
