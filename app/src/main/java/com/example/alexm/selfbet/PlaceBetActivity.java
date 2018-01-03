package com.example.alexm.selfbet;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;

import butterknife.BindView;
import butterknife.ButterKnife;

public class PlaceBetActivity extends AppCompatActivity {

    @BindView(R.id.input_bet_amount) EditText betAmount;
    @BindView(R.id.btn_bet_submit) Button submit;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_place_bet);
        ButterKnife.bind(this);
    }
}
