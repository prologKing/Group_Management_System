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
public class Candidate {

private int id;
private String memberid;
private String membername;
private String seatid;
private String electionid;
private String seatname;
private String manifesto;
private String campaignpic;

    public Candidate() {
    }

    public Candidate(String memberid, String seatid, String manifesto) {
        this.memberid = memberid;
        this.seatid = seatid;
        this.manifesto = manifesto;
    }

    public Candidate(int id, String memberid, String seatid, String manifesto, String campaignpic) {
        this.id = id;
        this.memberid = memberid;
        this.seatid = seatid;
        this.manifesto = manifesto;
        this.campaignpic = campaignpic;
    }

    public Candidate(String memberid, String membername, String seatid, String seatname, String manifesto, String campaignpic) {
        this.memberid = memberid;
        this.membername = membername;
        this.seatid = seatid;
        this.seatname = seatname;
        this.manifesto = manifesto;
        this.campaignpic = campaignpic;
    }
    public Candidate(int id, String memberid, String membername, String seatid, String seatname, String manifesto, String campaignpic) {
        this.id = id;
        this.memberid = memberid;
        this.membername = membername;
        this.seatid = seatid;
        this.seatname = seatname;
        this.manifesto = manifesto;
        this.campaignpic = campaignpic;
    }

    public Candidate(String membername, String seatid, String seatname, String manifesto, String campaignpic) {
        this.membername = membername;
        this.seatid = seatid;
        this.seatname = seatname;
        this.manifesto = manifesto;
        this.campaignpic = campaignpic;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMemberid() {
        return memberid;
    }

    public void setMemberid(String memberid) {
        this.memberid = memberid;
    }

    public String getSeatid() {
        return seatid;
    }

    public void setSeatid(String seatid) {
        this.seatid = seatid;
    }

    public String getManifesto() {
        return manifesto;
    }

    public void setManifesto(String manifesto) {
        this.manifesto = manifesto;
    }

    public String getMembername() {
        return membername;
    }

    public void setMembername(String membername) {
        this.membername = membername;
    }

    public String getSeatname() {
        return seatname;
    }

    public void setSeatname(String seatname) {
        this.seatname = seatname;
    }

    public String getCampaignpic() {
        return campaignpic;
    }

    public void setCampaignpic(String campaignpic) {
        this.campaignpic = campaignpic;
    }

    public String getElectionid() {
        return electionid;
    }

    public void setElectionid(String electionid) {
        this.electionid = electionid;
    }

    @Override
    public String toString() {
        return "Candidate{" + "id=" + id + ", memberid=" + memberid + ", seatid=" + seatid + ", manifesto=" + manifesto + ", campaignpic=" + campaignpic + '}';
    }


}
