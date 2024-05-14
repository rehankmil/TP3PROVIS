from fastapi.middleware.cors import CORSMiddleware
from typing import Optional
from fastapi import FastAPI
from pydantic import BaseModel
from fastapi import HTTPException

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Note(BaseModel):
    id: Optional[int] = None
    title: str
    content: str

notes = []

@app.post("/note/create")
async def create_note(note: Note):
    note.id = len(notes)  # Menambahkan id ke catatan
    notes.append(note)
    return {"id": note.id, "title": note.title, "content": note.content}


@app.get("/note/")
async def read_notes():
    return notes


@app.delete("/note/{note_id}")
async def delete_note(note_id: int):
    if note_id >= len(notes):
        raise HTTPException(status_code=404, detail="Note not found")
    note = notes[note_id]
    del notes[note_id]
    return {"status": 200, "message": "Note deleted successfully"}

    

    
