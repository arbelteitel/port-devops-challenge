from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Hello from Port DevOps Challenge!"}

@app.get("/health")
def health():
    return {"status": "healthy"}