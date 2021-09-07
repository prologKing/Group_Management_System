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
public class BirthdayInfoModel {
    private String memberId;
    private String fullname;
     private String alias;
    private String mobile;
    private String email;

    public BirthdayInfoModel() {
    }

    public BirthdayInfoModel(String memberId, String fullname, String alias, String mobile, String email) {
        this.memberId = memberId;
        this.fullname = fullname;
        this.alias = alias;
        this.mobile = mobile;
        this.email = email;
    }

    public BirthdayInfoModel(String fullname, String mobile, String email) {
        this.fullname = fullname;
        this.mobile = mobile;
        this.email = email;
    }

    public BirthdayInfoModel(String fullname, String alias, String mobile, String email) {
        this.fullname = fullname;
        this.alias = alias;
        this.mobile = mobile;
        this.email = email;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    @Override
    public String toString() {
        return "BirthdayInfoModel{" + "memberId=" + memberId + ", fullname=" + fullname + ", alias=" + alias + ", mobile=" + mobile + ", email=" + email + '}';
    }
    
}
