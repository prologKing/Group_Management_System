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
public class Email_Log {
   private String name;
    private String email;
    private String message;
    private String status;  
    private String emailType;
    private String createdon;
   

    public Email_Log() {
    }

    public Email_Log(String name, String email, String message, String status) {
        this.name = name;
        this.email = email;
        this.message = message;
        this.status = status;
    }

    public Email_Log(String name, String email, String message, String status, String createdon, String emailType) {
        this.name = name;
        this.email = email;
        this.message = message;
        this.status = status;
        this.emailType = emailType;
        this.createdon = createdon;
    }
    
    

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public String getEmailType() {
        return emailType;
    }

    public void setEmailType(String emailType) {
        this.emailType = emailType;
    }

    public String getCreatedon() {
        return createdon;
    }

    public void setCreatedon(String createdon) {
        this.createdon = createdon;
    }

    @Override
    public String toString() {
        return "Email_Log{" + "name=" + name + ", email=" + email + ", message=" + message + ", status=" + status + ", smsType=" + emailType + ", createdon=" + createdon + '}';
    }
    

   
    
}
