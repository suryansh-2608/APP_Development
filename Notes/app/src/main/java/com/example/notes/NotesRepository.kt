package com.example.notes

import androidx.lifecycle.LiveData

class NotesRepository(private val notesDAO: NotesDAO) {

    val allNotes: LiveData<List<Notes>> = notesDAO.getAllNotes()

    suspend fun insert(note: Notes){
        notesDAO.insert(note)
    }

    suspend fun delete(note: Notes){
        notesDAO.delete(note)
    }

}