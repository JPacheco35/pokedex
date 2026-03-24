from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello from FastAPI in WebStorm!"}

@app.get("/health")
def health():
    return {
        "status": "healthy",
        "version": "1.0.0",
        "uptime": "a while in computer time",
    }

@app.get("/items/{item_id}")
def read_item(item_id: int):
    return {"item_id": item_id}
