package com.example.alexm.selfbet.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.alexm.selfbet.CreateGroupActivity;
import com.example.alexm.selfbet.FirebaseProvider;
import com.example.alexm.selfbet.JoinGroupActivity;
import com.example.alexm.selfbet.R;
import com.getbase.floatingactionbutton.FloatingActionButton;
import com.getbase.floatingactionbutton.FloatingActionsMenu;

import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;

import butterknife.BindView;
import butterknife.ButterKnife;

public class GroupFragment extends Fragment implements Observer {

    @BindView(R.id.groups_act_menu) FloatingActionsMenu menuMultipleActions;
    @BindView(R.id.create_group_act) FloatingActionButton createGroup;
    @BindView(R.id.join_group_act) FloatingActionButton joinGroup;
    @BindView(R.id.tv_groupMembership) TextView groupMembership;

    public static GroupFragment newInstance() {
        return new GroupFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getActivity().setTitle(R.string.title_group);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_group, container, false);
        ButterKnife.bind(this, view);

        createGroup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), CreateGroupActivity.class);
                startActivity(intent);
            }
        });

        joinGroup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), JoinGroupActivity.class);
                startActivity(intent);
            }
        });

        setGroupList(FirebaseProvider.getGroupList());
        return view;
    }

    private void setGroupList(ArrayList<String> groupList) {
        if (groupList != null) {
            groupMembership.setText("You are a member of the following groups: \n \n");
            for (String group: groupList) {
                groupMembership.append(group);
            }
        }
    }

    @Override
    public void update(Observable observable, Object o) {
        setGroupList(FirebaseProvider.getGroupList());
    }
}