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
public class PositionModel {
    private String positionid;
    private String positionname;

    public PositionModel() {
    }

    public PositionModel(String positionid, String positionname) {
        this.positionid = positionid;
        this.positionname = positionname;
    }

    public String getPositionid() {
        return positionid;
    }

    public void setPositionid(String positionid) {
        this.positionid = positionid;
    }

    public String getPositionname() {
        return positionname;
    }

    public void setPositionname(String positionname) {
        this.positionname = positionname;
    }

    @Override
    public String toString() {
        return "PositionModel{" + "positionid=" + positionid + ", positionname=" + positionname + '}';
    }
    
    
}
