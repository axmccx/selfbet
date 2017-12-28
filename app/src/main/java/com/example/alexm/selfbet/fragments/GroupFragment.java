package com.example.alexm.selfbet.fragments;

import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.example.alexm.selfbet.R;
import com.getbase.floatingactionbutton.FloatingActionButton;
import com.getbase.floatingactionbutton.FloatingActionsMenu;

import butterknife.BindView;
import butterknife.ButterKnife;

public class GroupFragment extends Fragment {

    @BindView(R.id.groups_act_menu) FloatingActionsMenu menuMultipleActions;
    @BindView(R.id.create_group_act) FloatingActionButton createGroup;
    @BindView(R.id.join_group_act) FloatingActionButton joinGroup;

    private View view;

    public static GroupFragment newInstance() {
        GroupFragment fragment = new GroupFragment();
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getActivity().setTitle(R.string.title_group);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.fragment_group, container, false);
        ButterKnife.bind(this, view);

        createGroup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                createGroup.setTitle("Button clicked");
            }
        });

        joinGroup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                joinGroup.setTitle("Button clicked");
            }
        });

        return view;
    }
}

