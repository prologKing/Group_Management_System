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
public class Organization {
    private String name;
     private String address;
      private String email;
       private String about_org;
        private String phone_no1;
        private String phone_no2;
        private String phone_no3;
        private String logo;
         private String shortname;
         private String smtpConfigID;
         private String smsApiID;

    public Organization() {
    }

    public Organization(String name, String address, String email, String about_org, String phone_no1, String phone_no2, String phone_no3, String logo, String shortname) {
        this.name = name;
        this.address = address;
        this.email = email;
        this.about_org = about_org;
        this.phone_no1 = phone_no1;
        this.phone_no2 = phone_no2;
        this.phone_no3 = phone_no3;
        this.logo = logo;
        this.shortname = shortname;
    }

   
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAbout_org() {
        return about_org;
    }

    public void setAbout_org(String about_org) {
        this.about_org = about_org;
    }

    public String getPhone_no1() {
        return phone_no1;
    }

    public void setPhone_no1(String phone_no1) {
        this.phone_no1 = phone_no1;
    }

    public String getPhone_no2() {
        return phone_no2;
    }

    public void setPhone_no2(String phone_no2) {
        this.phone_no2 = phone_no2;
    }

    public String getPhone_no3() {
        return phone_no3;
    }

    public void setPhone_no3(String phone_no3) {
        this.phone_no3 = phone_no3;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getShortname() {
        return shortname;
    }

    public void setShortname(String shortname) {
        this.shortname = shortname;
    }

    public String getSmtpConfigID() {
        return smtpConfigID;
    }

    public void setSmtpConfigID(String smtpConfigID) {
        this.smtpConfigID = smtpConfigID;
    }

    public String getSmsApiID() {
        return smsApiID;
    }

    public void setSmsApiID(String smsApiID) {
        this.smsApiID = smsApiID;
    }

    @Override
    public String toString() {
        return "Organization{" + "name=" + name + ", address=" + address + ", email=" + email + ", about_org=" + about_org + ", phone_no1=" + phone_no1 + ", phone_no2=" + phone_no2 + ", phone_no3=" + phone_no3 + ", logo=" + logo + ", shortname=" + shortname + ", smtpConfigID=" + smtpConfigID + ", smsApiID=" + smsApiID + '}';
    }

   
}
