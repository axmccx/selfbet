package com.example.alexm.selfbet.fragments;

import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.example.alexm.selfbet.MainActivity;
import com.example.alexm.selfbet.R;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MoneyFragment extends Fragment {
    @BindView(R.id.btn_faucet) Button faucetButton;
    private View view;

    public static MoneyFragment newInstance() {
        MoneyFragment fragment = new MoneyFragment();
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getActivity().setTitle(R.string.title_money);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.fragment_money, container, false);
        ButterKnife.bind(this, view);

        faucetButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ((MainActivity) getActivity()).openFaucet();
            }
        });
        return view;
    }
}

