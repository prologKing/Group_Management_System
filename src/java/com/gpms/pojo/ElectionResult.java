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
public class ElectionResult {
    private String fullname;
    private String imageurl;
    private String seatname;
    private int numOfVotes;
    private int numOfVotesReceived;

    public ElectionResult(String fullname, String imageurl, String seatname, int numOfVotes) {
        this.fullname = fullname;
        this.imageurl = imageurl;
        this.seatname = seatname;
        this.numOfVotes = numOfVotes;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getImageurl() {
        return imageurl;
    }

    public void setImageurl(String imageurl) {
        this.imageurl = imageurl;
    }

    public String getSeatname() {
        return seatname;
    }

    public void setSeatname(String seatname) {
        this.seatname = seatname;
    }

    public int getNumOfVotes() {
        return numOfVotes;
    }

    public void setNumOfVotes(int numOfVotes) {
        this.numOfVotes = numOfVotes;
    }

    public int getNumOfVotesReceived() {
        return numOfVotesReceived;
    }

    public void setNumOfVotesReceived(int numOfVotesReceived) {
        this.numOfVotesReceived = numOfVotesReceived;
    }

    @Override
    public String toString() {
        return "ElectionResult{" + "fullname=" + fullname + ", imageurl=" + imageurl + ", seatname=" + seatname + ", numOfVotes=" + numOfVotes + ", numOfVotesReceived=" + numOfVotesReceived + '}';
    }
}
