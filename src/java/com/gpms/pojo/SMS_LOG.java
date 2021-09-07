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
public class SMS_LOG {
    private String name;
    private String number;
    private String message;
    private String status;
    private String smsType;
    private String createdon;

    public SMS_LOG() {
    }

    public SMS_LOG(String name, String number, String message, String status) {
        this.name = name;
        this.number = number;
        this.message = message;
        this.status = status;
    }

    public SMS_LOG(String name, String number, String message, String status, String createdon, String smsType) {
        this.name = name;
        this.number = number;
        this.message = message;
        this.status = status;
        this.createdon = createdon;
        this.smsType = smsType;
    }
    
    

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSmsType() {
        return smsType;
    }

    public void setSmsType(String smsType) {
        this.smsType = smsType;
    }
    

    public String getCreatedon() {
        return createdon;
    }

    public void setCreatedon(String createdon) {
        this.createdon = createdon;
    }

    @Override
    public String toString() {
        return "SMS_LOG{" + "name=" + name + ", number=" + number + ", message=" + message + ", status=" + status + ", smsType=" + smsType + ", createdon=" + createdon + '}';
    }
    

   
    
}
