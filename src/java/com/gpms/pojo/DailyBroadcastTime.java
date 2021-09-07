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
public class DailyBroadcastTime {
    private String send_hour;
    private String send_minute;

    public DailyBroadcastTime() {
    }

    public DailyBroadcastTime(String send_hour, String send_minute) {
        this.send_hour = send_hour;
        this.send_minute = send_minute;
    }

    public String getSend_hour() {
        return send_hour;
    }

    public void setSend_hour(String send_hour) {
        this.send_hour = send_hour;
    }

    public String getSend_minute() {
        return send_minute;
    }

    public void setSend_minute(String send_minute) {
        this.send_minute = send_minute;
    }

    @Override
    public String toString() {
        return "DailyBroadcastTime{" + "send_hour=" + send_hour + ", send_minute=" + send_minute + '}';
    }
    
    
}
