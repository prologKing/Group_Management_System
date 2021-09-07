/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.pojo;

//import java.time.String;

/**
 *
 * @author Developer
 */
public class Event {
     private int eid;
    private String name;
    private String description;
    private String startDate;
    private String endDate;
    private double total;

    public Event() {
    }

    public Event(int eid, String name, String description, String startDate, String endDate) {
        this.eid = eid;
        this.name = name;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public Event(String name, String description, double total) {
        this.name = name;
        this.description = description;
        this.total = total;
    }
    
    

    public int getEid() {
        return eid;
    }

    public void setEid(int eid) {
        this.eid = eid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
    

    @Override
    public String toString() {
        return "Event{" + "eid=" + eid + ", name=" + name + ", description=" + description + ", startDate=" + startDate + ", endDate=" + endDate + '}';
    }

   
    
    
}
