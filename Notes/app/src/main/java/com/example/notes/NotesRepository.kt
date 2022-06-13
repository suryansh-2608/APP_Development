package com.example.notes

import androidx.lifecycle.LiveData

class NotesRepository(private val notesDAO: NotesDAO) {

    val allNotes: LiveData<List<Notes>> = notesDAO.getAllNotes()

    suspend fun insert(notes: Notes){
        notesDAO.insert(notes)
    }

    suspend fun delete(notes: Notes){
        notesDAO.delete(notes)
    }

}