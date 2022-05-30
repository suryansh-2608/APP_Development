package com.example.birthdaygreet

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

    }

    fun CreateBirthdayCard(view: View) {
        val intent = Intent(this, BithdayGreetingActivity::class.java)
        val name = editTextTextPersonName.editableText.toString()
        intent.putExtra("name", name)

        startActivity(intent)
    }
}