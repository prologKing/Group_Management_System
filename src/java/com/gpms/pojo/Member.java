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
public class Member {
    private String memberId;
    private String fullName;
    private String alias;
    private String dob;
    private String gender;
    private String maritalStatus;
    private String mobile;
    private String altphone;
    private String email;
    private String occupation;
    private String address;
    private int kids;
     private String aboutMe;
     private String imageurl;
     private String position;
   
     private double totalContribution;

    public Member() {
    }

    public Member(String fullName, String gender, String mobile) {
        this.fullName = fullName;
        this.gender = gender;
        this.mobile = mobile;
       
    }

    public Member(String memberId, String fullName, String mobile, String email) {
        this.memberId = memberId;
        this.fullName = fullName;
        this.mobile = mobile;
        this.email = email;
    }

    public Member(String memberId, String fullName, String alias, String dob, String gender, String maritalStatus, String mobile, String email, String occupation, String address, int kids, String aboutMe, String imageurl, String position, double totalContribution) {
        this.memberId = memberId;
        this.fullName = fullName;
        this.alias = alias;
        this.dob = dob;
        this.gender = gender;
        this.maritalStatus = maritalStatus;
        this.mobile = mobile;
        this.email = email;
        this.occupation = occupation;
        this.address = address;
        this.kids = kids;
       
        this.aboutMe = aboutMe;
        this.imageurl = imageurl;
        this.position = position;
        this.totalContribution = totalContribution;
    }
    

   
    public Member(String memberId, String fullName, String dob, String gender, String maritalStatus, String mobile, String email, String occupation, String address, int kids, String aboutMe) {
        this.memberId = memberId;
        this.fullName = fullName;
        this.dob = dob;
        this.gender = gender;
        this.maritalStatus = maritalStatus;
        this.mobile = mobile;
        this.email = email;
        this.occupation = occupation;
        this.address = address;
        this.kids = kids;
        
        this.aboutMe = aboutMe;
    }

    public Member(String memberId, String fullName, String alias, String mobile, String address, double totalContribution) {
        this.memberId = memberId;
        this.fullName = fullName;
        this.alias = alias;
        this.mobile = mobile;
        this.address = address;
        this.totalContribution = totalContribution;
    }

    
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public double getTotalContribution() {
        return totalContribution;
    }

    public void setTotalContribution(double totalContribution) {
        this.totalContribution = totalContribution;
    }

    public String getImageurl() {
        return imageurl;
    }

    public void setImageurl(String imageurl) {
        this.imageurl = imageurl;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAboutMe() {
        return aboutMe;
    }

    public void setAboutMe(String aboutMe) {
        this.aboutMe = aboutMe;
    }    

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        
        this.dob = dob;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAltphone() {
        return altphone;
    }

    public void setAltphone(String altphone) {
        this.altphone = altphone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public int getKids() {
        return kids;
    }

    public void setKids(int kids) {
        this.kids = kids;
    }

    @Override
    public String toString() {
        return "Member{" + "memberId=" + memberId + ", fullName=" + fullName + ", alias=" + alias + ", dob=" + dob + ", gender=" + gender + ", maritalStatus=" + maritalStatus + ", mobile=" + mobile + ", email=" + email + ", occupation=" + occupation + ", address=" + address + ", kids=" + kids + ", aboutMe=" + aboutMe + ", imageurl=" + imageurl + ", position=" + position + ", totalContribution=" + totalContribution + '}';
    }

   
   
    
   
}
