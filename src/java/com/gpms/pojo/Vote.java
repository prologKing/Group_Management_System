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
public class Vote {
    private int voteId;
    private String memberId;
    private String seatId;
    private String token;

    public Vote() {
    }

    public Vote(String memberId, String seatId, String token) {
        this.memberId = memberId;
        this.seatId = seatId;
        this.token = token;
    }

    public int getVoteId() {
        return voteId;
    }

    public void setVoteId(int voteId) {
        this.voteId = voteId;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getSeatId() {
        return seatId;
    }

    public void setSeatId(String seatId) {
        this.seatId = seatId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    @Override
    public String toString() {
        return "Vote{" + "voteId=" + voteId + ", memberId=" + memberId + ", seatId=" + seatId + ", token=" + token + '}';
    }
    
    
    
}
