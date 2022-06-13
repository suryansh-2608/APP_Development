package com.example.notes

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class NotesViewModel(application: Application) : AndroidViewModel(application) {
    val repository : NotesRepository
    val allNotes: LiveData<List<Notes>>
    init {
        val dao = NotesRoomDatabase.getDatabase(application).getNoteDAO()
        repository = NotesRepository(dao)
        allNotes = repository.allNotes
    }
    fun deleteNode(note: Notes) = viewModelScope.launch (Dispatchers.IO){
        repository.delete(note)
    }

    fun insertNode(note: Notes) = viewModelScope.launch (Dispatchers.IO){
        repository.insert(note)
    }
}