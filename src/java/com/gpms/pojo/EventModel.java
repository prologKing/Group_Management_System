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
public class EventModel {
    private int eventid;
    private String eventdescription;

    public EventModel() {
    }

    public EventModel(int eventid, String eventdescription) {
        this.eventid = eventid;
        this.eventdescription = eventdescription;
    }

    public int getEventid() {
        return eventid;
    }

    public void setEventid(int eventid) {
        this.eventid = eventid;
    }

    public String getEventdescription() {
        return eventdescription;
    }

    public void setEventdescription(String eventdescription) {
        this.eventdescription = eventdescription;
    }

    @Override
    public String toString() {
        return "EventModel{" + "eventid=" + eventid + ", eventdescription=" + eventdescription + '}';
    }
    
}
