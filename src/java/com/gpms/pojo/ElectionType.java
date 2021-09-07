/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.pojo;

import java.util.Date;

/**
 *
 * @author Developer
 */
public class ElectionType {
    private int id;
    private String electionName;
    private String electionStartDate;
    private String electionEndDate;
    private String formOpeningDate;
     private String formClosingDate;
     private String tokenBroadcastDate; 

    public ElectionType() {
    }

    public ElectionType(int id, String electionName) {
        this.id = id;
        this.electionName = electionName;
    }

    public ElectionType(int id) {
        this.id = id;
    }
    

    public ElectionType(int id, String electionName, String electionStartDate, String electionEndDate) {
        this.id = id;
        this.electionName = electionName;
        this.electionStartDate = electionStartDate;
        this.electionEndDate = electionEndDate;
    }
     public ElectionType(int id, String electionName, String electionStartDate, String electionEndDate, String formOpeningDate, String formClosingDate) {
        this.id = id;
        this.electionName = electionName;
        this.electionStartDate = electionStartDate;
        this.electionEndDate = electionEndDate;
        this.formOpeningDate = formOpeningDate;
        this.formClosingDate = formClosingDate;
    }

    public ElectionType(String electionName, String electionStartDate, String electionEndDate) {
        this.electionName = electionName;
        this.electionStartDate = electionStartDate;
         this.electionEndDate = electionEndDate;
    }

    public ElectionType(String electionName, String electionStartDate, String electionEndDate, String formOpeningDate, String formClosingDate, String tokenBroadcastDate) {
        this.electionName = electionName;
        this.electionStartDate = electionStartDate;
         this.electionEndDate = electionEndDate;
        this.formOpeningDate = formOpeningDate;
        this.formClosingDate = formClosingDate;
        this.tokenBroadcastDate = tokenBroadcastDate;
    }

    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getElectionName() {
        return electionName;
    }

    public void setElectionName(String electionName) {
        this.electionName = electionName;
    }

    public String getElectionStartDate() {
        return electionStartDate;
    }

    public void setElectionStartDate(String electionStartDate) {
        this.electionStartDate = electionStartDate;
    }

    public String getElectionEndDate() {
        return electionEndDate;
    }

    public void setElectionEndDate(String electionEndDate) {
        this.electionEndDate = electionEndDate;
    }

   
    public String getFormOpeningDate() {
        return formOpeningDate;
    }

    public void setFormOpeningDate(String formOpeningDate) {
        this.formOpeningDate = formOpeningDate;
    }

    public String getFormClosingDate() {
        return formClosingDate;
    }

    public void setFormClosingDate(String formClosingDate) {
        this.formClosingDate = formClosingDate;
    }

    public String getTokenBroadcastDate() {
        return tokenBroadcastDate;
    }

    public void setTokenBroadcastDate(String tokenBroadcastDate) {
        this.tokenBroadcastDate = tokenBroadcastDate;
    }

    @Override
    public String toString() {
        return "ElectionType{" + "id=" + id + ", electionName=" + electionName + ", electionStartDate=" + electionStartDate + ", electionEndDate=" + electionEndDate + ", formOpeningDate=" + formOpeningDate + ", formClosingDate=" + formClosingDate + ", tokenBroadcastDate=" + tokenBroadcastDate + '}';
    }

   
}
