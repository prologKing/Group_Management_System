/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.pojo;

/**
 *
 * @author Developer
 */
public class VoteResult {
    private String name;
    private String seatid;
    private String seatname;
    private int numOfVotes;
    private int numOfVoters;
    private int numOfEligibleVoters;

    public VoteResult(String name, String seatid, String seatname, int numOfVotes) {
        this.name = name;
        this.seatid = seatid;
        this.seatname = seatname;
        this.numOfVotes = numOfVotes;
    }

    public VoteResult(int numOfVoters, int numOfEligibleVoters) {
        this.numOfVoters = numOfVoters;
        this.numOfEligibleVoters = numOfEligibleVoters;
    }
    

    public String getSeatid() {
        return seatid;
    }

    public void setSeatid(String seatid) {
        this.seatid = seatid;
    }

    public String getSeatname() {
        return seatname;
    }

    public void setSeatname(String seatname) {
        this.seatname = seatname;
    }

   

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getNumOfVotes() {
        return numOfVotes;
    }

    public void setNumOfVotes(int numOfVotes) {
        this.numOfVotes = numOfVotes;
    }

    public int getNumOfVoters() {
        return numOfVoters;
    }

    public void setNumOfVoters(int numOfVoters) {
        this.numOfVoters = numOfVoters;
    }

    public int getNumOfEligibleVoters() {
        return numOfEligibleVoters;
    }

    public void setNumOfEligibleVoters(int numOfEligibleVoters) {
        this.numOfEligibleVoters = numOfEligibleVoters;
    }

    @Override
    public String toString() {
        return "VoteResult{" + "name=" + name + ", seatid=" + seatid + ", seatname=" + seatname + ", numOfVotes=" + numOfVotes + ", numOfVoters=" + numOfVoters + ", numOfEligibleVoters=" + numOfEligibleVoters + '}';
    }
    

   
    
    
    
}
