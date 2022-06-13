package com.example.notes

import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity(), INotesRVAdapter {

    lateinit var viewModel: NotesViewModel



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)


        recyclerView.layoutManager = LinearLayoutManager(this)
        val adapter = NotesRVAdapter(this, this)
        recyclerView.adapter = adapter


        viewModel = ViewModelProvider(this, ViewModelProvider.AndroidViewModelFactory.getInstance(application)).get(NotesViewModel::class.java)
        viewModel.allNotes.observe(this, Observer {list ->
            list?.let {
                adapter.updateList(it) }

        })


    }

    override fun onItemClicked(note: Notes) {
        viewModel.deleteNode(note)
        Toast.makeText(this, "${note.text} Deleted", Toast.LENGTH_LONG).show()
    }

    fun SubmitData(view: View) {
        val noteText = input.text.toString()
        if(noteText.isNotEmpty()){
            viewModel.insertNode(Notes(noteText))
            Toast.makeText(this, "$noteText inserted", Toast.LENGTH_LONG).show()
        }
    }
}