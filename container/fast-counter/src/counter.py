from fastapi import FastAPI, HTTPException

app = FastAPI()
counter = 0

@app.get("/")
def read_root():
    return {"counter": counter}

@app.post("/")
def increment_counter():
    global counter
    counter += 1
    return {"message": "Counter incremented"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)