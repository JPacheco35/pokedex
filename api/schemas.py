from pydantic import BaseModel, ConfigDict
from typing import Optional, List

class TypeResponse(BaseModel):
    id: int
    name: str
    weaknesses: Optional[List[str]] = None
    strengths: Optional[List[str]] = None

    model_config = ConfigDict(from_attributes=True)


class MoveResponse(BaseModel):
    id: int
    name: str
    description: Optional[str] = None

    type: str
    power: Optional[int] = None
    accuracy: Optional[int] = None
    damage_class: str

    model_config = ConfigDict(from_attributes=True)


class AbilityResponse(BaseModel):
    id: int
    name: str
    description: Optional[str] = None

    model_config = ConfigDict(from_attributes=True)


class PokemonListResponse(BaseModel):
    id: int
    name: str
    generation: int
    sprites: Optional[List[str]] = None

    model_config = ConfigDict(from_attributes=True)


class PokemonDetailResponse(BaseModel):
    id: int
    name: str
    species_name: str
    generation: int

    height: Optional[float] = None
    weight: Optional[float] = None
    base_experience: Optional[int] = None

    hp: int
    attack: int
    defense: int
    sp_attack: int
    sp_defense: int
    speed: int

    cries: Optional[List[str]] = None
    sprites: Optional[List[str]] = None

    types: List[TypeResponse]
    moves: List[MoveResponse]
    abilities: List[AbilityResponse]

    model_config = ConfigDict(from_attributes=True)