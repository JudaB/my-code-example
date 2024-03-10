from fastapi import FastAPI
from typing import Dict

app = FastAPI()

counter = 0

@app.get("/")
async def get_counter() -> Dict[str, int]:
    global counter
    counter += 1
    return {"counter": counter}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
