from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from dotenv import load_dotenv
import os

# load .env file & variables
load_dotenv()
DATABASE_URL = os.getenv("DATABASE_URL")

# create engine
engine = create_engine(DATABASE_URL, echo=True)

# create session
sessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# base database model class
Base = declarative_base()

def get_db():
    db = sessionLocal()
    try:
        yield db
    finally:
        db.close()