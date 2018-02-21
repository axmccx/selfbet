package com.example.alexm.selfbet;

import java.io.Serializable;

public class SingleBet implements Serializable {
    private String type;
    private String amount;
    private String group;

    public SingleBet() { }  // Needed for Firebase

    public SingleBet(String type, String amount, String group) {
        this.type = type;
        this.amount = amount;
        this.group = group;
    }

    // all getters and setters must be public or app will crash when viewing bets
    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getAmount() {
        return this.amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getGroup() {
        return this.group;
    }

    public void setGroup(String group) {
        this.group = group;
    }
}