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
public class ElectionSeat {
    private String seatName;
    private int electionid;
    private int numberOfCandidatesPerSeat;
    private int numberOfVotesReceived;

    public ElectionSeat() {
    }

    public ElectionSeat(String seatName, int electionid) {
        this.seatName = seatName;
        this.electionid = electionid;
    }
     public ElectionSeat(int numberOfCandidatesPerSeat, String seatName) {
        this.seatName = seatName;
        this.numberOfCandidatesPerSeat = numberOfCandidatesPerSeat;
    }
     public ElectionSeat(int numberOfCandidatesPerSeat, int numberOfVotesReceived, String seatName) {
        this.seatName = seatName;
        this.numberOfCandidatesPerSeat = numberOfCandidatesPerSeat;
        this.numberOfVotesReceived = numberOfVotesReceived;
    }
     

    public int getNumberOfCandidatesPerSeat() {
        return numberOfCandidatesPerSeat;
    }

    public void setNumberOfCandidatesPerSeat(int numberOfCandidatesPerSeat) {
        this.numberOfCandidatesPerSeat = numberOfCandidatesPerSeat;
    }
     public int getNumberOfVotesReceived() {
        return numberOfVotesReceived;
    }

    public void setNumberOfVotesReceived(int numberOfVotesReceived) {
        this.numberOfVotesReceived = numberOfVotesReceived;
    }
    
      public ElectionSeat(String seatName) {
        this.seatName = seatName;
    }

    public String getSeatName() {
        return seatName;
    }

    public void setSeatName(String seatName) {
        this.seatName = seatName;
    }

    public int getElectionid() {
        return electionid;
    }

    public void setElectionid(int electionid) {
        this.electionid = electionid;
    }

  

    @Override
    public String toString() {
        return "ElectionSeat{" + "seatName=" + seatName + ", electionid=" + electionid + '}';
    }
    
    
    
    
}
