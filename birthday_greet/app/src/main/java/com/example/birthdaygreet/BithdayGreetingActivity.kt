package com.example.birthdaygreet

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_bithday_greeting.*

class BithdayGreetingActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_bithday_greeting)

        val name = intent.getStringExtra("name")
        birthdayGreeting.text = "Happy Birthday!!!\n$name"
    }
}