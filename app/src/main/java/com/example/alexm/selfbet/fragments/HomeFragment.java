package com.example.alexm.selfbet.fragments;

import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.alexm.selfbet.FirebaseProvider;
import com.example.alexm.selfbet.R;

import java.util.Observable;
import java.util.Observer;

import butterknife.BindView;
import butterknife.ButterKnife;

public class HomeFragment extends Fragment implements Observer {
    @BindView(R.id.tv_balance) TextView balanceText;

    public static HomeFragment newInstance() {
        return new HomeFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getActivity().setTitle(R.string.title_home);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_home, container, false);
        ButterKnife.bind(this, view);
        setBalanceText(FirebaseProvider.getUserBalance());
        return view;
    }

    private void setBalanceText(String balance) {
        balanceText.setText("Balance: $" + balance + ".00");
    }

    @Override
    public void update(Observable observable, Object o) {
        setBalanceText(FirebaseProvider.getUserBalance());
    }
}