package com.example.alexm.selfbet;

public class SingleBet {
    private String type;
    private String amount;
    private String group;

    public SingleBet() { }  // Needed for Firebase

    public SingleBet(String type, String amount, String group) {
        this.type = type;
        this.amount = amount;
        this.group = group;
    }

    String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }

    String getAmount() {
        return this.amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    String getGroup() {
        return this.group;
    }

    public void setGroup(String group) {
        this.group = group;
    }
}