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
public class Contribution {
     private int eventid;
    private int contrubtionid;
    private String memberid;
    private String name;
    private String beneficiaryId;
    private double contribution;
    private String event;
    private String contributionDate;

    public Contribution() {
    }

    public Contribution(int eventid, int contrubtionid, String memberid, String name, double contribution, String event, String contributionDate, String beneficiaryId) {
        this.eventid = eventid;
        this.contrubtionid = contrubtionid;
        this.memberid = memberid;
        this.name = name;
        this.contribution = contribution;
        this.event = event;
        this.contributionDate = contributionDate;
        this.beneficiaryId = beneficiaryId;
    }

    public Contribution(int eventid, int contrubtionid, String memberid, String name, double contribution, String event, String contributionDate) {
        this.eventid = eventid;
        this.contrubtionid = contrubtionid;
        this.memberid = memberid;
        this.name = name;
        this.contribution = contribution;
        this.event = event;
        this.contributionDate = contributionDate;
    }
   

    public int getEventid() {
        return eventid;
    }

    public void setEventid(int eventid) {
        this.eventid = eventid;
    }

    public int getContrubtionid() {
        return contrubtionid;
    }

    public void setContrubtionid(int contrubtionid) {
        this.contrubtionid = contrubtionid;
    }

    public String getMemberid() {
        return memberid;
    }

    public void setMemberid(String memberid) {
        this.memberid = memberid;
    }

  

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getContribution() {
        return contribution;
    }

    public void setContribution(double contribution) {
        this.contribution = contribution;
    }

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }

    public String getContributionDate() {
        return contributionDate;
    }

    public void setContributionDate(String contributionDate) {
        this.contributionDate = contributionDate;
    }

    public String getBeneficiaryId() {
        return beneficiaryId;
    }

    public void setBeneficiaryId(String beneficiaryId) {
        this.beneficiaryId = beneficiaryId;
    }

    @Override
    public String toString() {
        return "Contribution{" + "eventid=" + eventid + ", contrubtionid=" + contrubtionid + ", memberid=" + memberid + ", name=" + name + ", contribution=" + contribution + ", event=" + event + ", contributionDate=" + contributionDate + '}';
    }

   
  
}
