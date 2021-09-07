/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.pojo;

import com.gpms.dbconnection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Developer
 */
public class LoginModel {

    private static Connection con = null;

    static {
        try {
            con = DBConnection.getConnection();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public List<Member> fetchMembers() throws SQLException {
        List<Member> loginCred = new ArrayList<>();
        Member member = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("SELECT m.MemberID, m.FullName, m.alias, m.DoB, m.Gender, m.MaritalStatus, m.Mobile, m.Email, m.Occupation, m.Address, m.Kids, m.about_me, m.imageurl, p.rolename,sum(c.amount) as amount FROM member m join position p on p.roleId=m.position left join contribution c on m.MemberID=c.MemberId group by c.MemberId;");

            rs = ps.executeQuery();

            while (rs.next()) {

                member = new Member(rs.getString("MemberID"), rs.getString("FullName"), rs.getString("alias"), rs.getString("DoB"), rs.getString("Gender"), rs.getString("MaritalStatus"), rs.getString("Mobile"), rs.getString("Email"), rs.getString("Occupation"), rs.getString("Address"), rs.getInt("Kids"), rs.getString("about_me"), rs.getString("imageurl"), rs.getString("rolename"), rs.getDouble("amount"));

                loginCred.add(member);

            }

        } catch (Exception e) {
            System.out.println(e.getMessage());

        }

        return loginCred;
    }
    
//    public List<Member> fetchBeneficiary() throws SQLException {
//        List<Member> loginCred = new ArrayList<>();
//        Member member = null;
//        try {
//
//            PreparedStatement ps = null;
//            ResultSet rs = null;
//
//            ps = con.prepareStatement("SELECT b.beneficiaryId, m.FullName, m.alias, m.Mobile, e.ename , SUM(b.amount) as amount  FROM contribution b join member m on m.MemberID = b.beneficiaryId join event e on e.eid=b.eventid Group by b.eventid;");
//
//            rs = ps.executeQuery();
//
//            while (rs.next()) {
//
//                member = new Member(rs.getString("beneficiaryId"), rs.getString("FullName"), rs.getString("alias"),rs.getString("Mobile"),rs.getString("ename"), rs.getDouble("amount"));
//
//                loginCred.add(member);
//
//            }
//
//        } catch (Exception e) {
//            System.out.println(e.getMessage());
//
//        }
//
//        return loginCred;
//    }

    public List<User> fetchUsers() throws SQLException {
        List<User> loginCred = new ArrayList<>();
        User user = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("SELECT * FROM user u join role r on r.roleId=u.role;");

            rs = ps.executeQuery();

            while (rs.next()) {

                user = new User(rs.getInt("id"), rs.getString("fname"), rs.getString("lname"), rs.getString("username"), rs.getString("password"), rs.getString("email"), rs.getString("gender"), rs.getString("mobile"), rs.getString("role"), rs.getString("imageurl"));

                loginCred.add(user);

            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return loginCred;
    }

    public List<Event> fetchEvents() throws SQLException {
        List<Event> loginCred = new ArrayList<>();
        Event ev = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("SELECT * FROM event;");

            rs = ps.executeQuery();

            while (rs.next()) {

                ev = new Event(rs.getInt("eid"), rs.getString("ename"), rs.getString("edescription"), rs.getString("startdate"), rs.getString("enddate"));

                loginCred.add(ev);

            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return loginCred;
    }

    public List<Contribution> fetchContribution() throws SQLException {
        List<Contribution> loginCred = new ArrayList<>();
        Contribution ev = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("SELECT e.eid, c.id, m.MemberID, m.FullName, c.amount, e.edescription, c.createdon, c.modifiedon FROM contribution c join member m on m.MemberID=c.MemberId join event e on e.eid=c.eventid;");

            rs = ps.executeQuery();

            while (rs.next()) {
                if (rs.getString("modifiedon") == null) {
                    ev = new Contribution(rs.getInt("eid"), rs.getInt("id"), rs.getString("MemberID"), rs.getString("FullName"), rs.getDouble("amount"), rs.getString("edescription"), rs.getString("createdon"));
                } else {
                    ev = new Contribution(rs.getInt("eid"),rs.getInt("id"), rs.getString("MemberID"), rs.getString("FullName"), rs.getDouble("amount"), rs.getString("edescription"), rs.getString("modifiedon"));
                }
                loginCred.add(ev);

            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return loginCred;
    }
    
    public List<Contribution> fetchBeneficiary() throws SQLException {
        List<Contribution> loginCred = new ArrayList<>();
        Contribution ev = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("SELECT e.eid, c.id, m.MemberID, m.FullName, c.amount, e.edescription, c.createdon, c.modifiedon FROM beneficiary c join member m on m.MemberID=c.member_id join event e on e.eid=c.event_id;");

            rs = ps.executeQuery();

            while (rs.next()) {
                if (rs.getString("modifiedon") == null) {
                    ev = new Contribution(rs.getInt("eid"), rs.getInt("id"), rs.getString("MemberID"), rs.getString("FullName"), rs.getDouble("amount"), rs.getString("edescription"), rs.getString("createdon"));
                } else {
                    ev = new Contribution(rs.getInt("eid"),rs.getInt("id"), rs.getString("MemberID"), rs.getString("FullName"), rs.getDouble("amount"), rs.getString("edescription"), rs.getString("modifiedon"));
                }
                loginCred.add(ev);

            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return loginCred;
    }
    
public List<ElectionType> fetchElection() throws SQLException {
        List<ElectionType> loginCred = new ArrayList<>();
        ElectionType ev = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("SELECT election_id, election_name, election_startdate, election_enddate,formopeningdate, formclosingdate FROM electiontype");

            rs = ps.executeQuery();

            while (rs.next()) {
               
                    ev = new ElectionType(rs.getInt("election_id"), rs.getString("election_name"), rs.getString("election_startdate"), rs.getString("election_enddate"), rs.getString("formopeningdate"), rs.getString("formclosingdate"));
               
                loginCred.add(ev);

            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return loginCred;
    }
 public List<ElectionType> fetchElections() throws SQLException {
        List<ElectionType> loginCred = new ArrayList<>();
        ElectionType org = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("SELECT * FROM electiontype Where formclosingdate >= curdate()");

            rs = ps.executeQuery();

            while (rs.next()) {

                org = new ElectionType(rs.getInt("election_id"), rs.getString("election_name"));
                loginCred.add(org);

            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return loginCred.isEmpty()? null:loginCred;
    }
 
    public Role fetchRolePrivilege(int role) throws SQLException {
        Role loginCred = null;
        Event ev = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("SELECT * FROM role Where roleId=" + role + "");

            rs = ps.executeQuery();

            while (rs.next()) {

                loginCred = new Role(rs.getString("rolename"), rs.getString("privilege"));

            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return loginCred;
    }

    public List<Member> fetchIndividualMember(String memberId) throws SQLException {
        List<Member> loginCred = new ArrayList<>();
        Member user = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("SELECT * FROM member m join position p on p.roleId=m.position join contribution c on c.MemberId = m.MemberID where m.MemberID='" + memberId + "';");

            rs = ps.executeQuery();

            while (rs.next()) {

                user = new Member(rs.getString("MemberID"), rs.getString("FullName"), rs.getString("alias"), rs.getString("DoB"), rs.getString("Gender"), rs.getString("MaritalStatus"), rs.getString("Mobile"), rs.getString("Email"), rs.getString("Occupation"), rs.getString("Address"), rs.getInt("Kids"), rs.getString("about_me"), rs.getString("imageurl"), rs.getString("roleId"), rs.getDouble("amount"));

                loginCred.add(user);

            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return loginCred;
    }

    public List<User> fetchIndividualUser(String username) throws SQLException {
        List<User> loginCred = new ArrayList<>();
        User user = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("SELECT * FROM user m join role r on r.roleId=m.role where m.username='" + username + "';");

            rs = ps.executeQuery();

            while (rs.next()) {

                user = new User(rs.getInt("id"), rs.getString("fname"), rs.getString("lname"), rs.getString("username"), rs.getString("password"), rs.getString("email"), rs.getString("gender"), rs.getString("mobile"), rs.getString("role"), rs.getString("imageurl"));

                loginCred.add(user);

            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return loginCred;
    }

    public List<Organization> fetchOrganizationDetails() throws SQLException {
        List<Organization> loginCred = new ArrayList<>();
        Organization org = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("SELECT * FROM organization");

            rs = ps.executeQuery();

            while (rs.next()) {

                org = new Organization(rs.getString("organization_name"), rs.getString("address"), rs.getString("email"), rs.getString("about_org"), rs.getString("phone1"), rs.getString("phone2"), rs.getString("phone3"), rs.getString("logo"), rs.getString("shortname"));
                org.setSmsApiID(rs.getString("smsAPIID"));
                org.setSmtpConfigID(rs.getString("smtpconfigID"));
                loginCred.add(org);

            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return loginCred;
    }
    
    public List<ElectionResult> fetchCandidateResult(String electionid) throws SQLException {
       List<ElectionResult> loginCred = new ArrayList<>();
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;
            ps = con.prepareStatement("select fullName,(select campaign_picture from candidate where seat_id = v.seat_id and memberId=m.memberID), (select seatname from electionseat where seat_id= v.seat_id) as seatname, count(v.memberid) as num_of_votes from member m join vote v on m.MemberID = v.memberid where v.seat_id in (select seat_id from electionseat where election_id ='" + electionid + "') Group by v.memberid;");


            rs = ps.executeQuery();
            while (rs.next()) {
                loginCred.add(new ElectionResult(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4)));
            }
             ps = con.prepareStatement("select (select seatname from electionseat where seat_id= v.seat_id) as seatname, count(v.seat_id) as numOfVote from vote v  where v.seat_id in (select seat_id from electionseat where election_id ='" + electionid + "') group by v.seat_id;");
             rs = ps.executeQuery();
            
              if(loginCred.size() > 0) {
                   while (rs.next()) {
                       for(int i =0; i< loginCred.size(); i++){
                       if(loginCred.get(i).getSeatname().equals(rs.getString(1)))
                           loginCred.get(i).setNumOfVotesReceived(rs.getInt(2));
                       }
                
            }
               
            }
            
          
        } catch (Exception e) {
            System.out.println(e.getMessage());

        }

        return loginCred;
    }

    public String usernameValidation(String username) throws SQLException {
        String result = "";
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select username from user where username is not null and username=?");

            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.first()) {
                result = "User already exists";
            } else {
                result = "User name is valid";
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());

        }

        return result;
    }
     public String getUnsubscribedEvents(String memberid) throws SQLException {
        String result = "<items>";
        String value = "";
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;
             ps = con.prepareStatement("select MemberID from member where MemberID is not null and MemberID=?");

            ps.setString(1, memberid);
            rs = ps.executeQuery();
            if (rs.first()) {
                value = "Member exists";
            } else {
                value = "";
            }
            if(!value.equals("")){
            ps = con.prepareStatement("select * from event where eid not in( select eventid from contribution  where memberid=? and eventid > 0)");

            ps.setString(1, memberid);
            rs = ps.executeQuery();
            while (rs.next()) {
                result += "<item id='"+rs.getInt(1)+"'>" +rs.getString(3)+"</item>";
            }
            }
          result += "</items>";
        } catch (Exception e) {
            System.out.println(e.getMessage());

        }

        return result;
    }
     
     public String getUnBenefittedEvents(String memberid) throws SQLException {
        String result = "<items>";
        String value = "";
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;
             ps = con.prepareStatement("select MemberID from member where MemberID is not null and MemberID=?");

            ps.setString(1, memberid);
            rs = ps.executeQuery();
            if (rs.first()) {
                value = "Member exists";
            } else {
                value = "";
            }
            if(!value.equals("")){
            ps = con.prepareStatement("select * from event");

            rs = ps.executeQuery();
            while (rs.next()) {
                result += "<item id='"+rs.getInt(1)+"'>" +rs.getString(3)+"</item>";
            }
            }
          result += "</items>";
        } catch (Exception e) {
            System.out.println(e.getMessage());

        }

        return result;
    }
     
     public List<ElectionType> fetchCurrentElections() throws SQLException {
        List<ElectionType> loginCred = new ArrayList<>();
        ElectionType org = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("SELECT * FROM electiontype Where election_startdate <= now() and election_enddate >= now()");

            rs = ps.executeQuery();

            while (rs.next()) {

                org = new ElectionType(rs.getInt("election_id"), rs.getString("election_name"));
                loginCred.add(org);

            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return loginCred.isEmpty()? null:loginCred;
    }
     
     public List<ElectionType> fetchAllElections() throws SQLException {
        List<ElectionType> loginCred = new ArrayList<>();
        ElectionType org = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("SELECT * FROM electiontype");

            rs = ps.executeQuery();

            while (rs.next()) {

                org = new ElectionType(rs.getInt("election_id"), rs.getString("election_name"));
                loginCred.add(org);

            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return loginCred.isEmpty()? null:loginCred;
    }
 
     
      public String getSeatsAvailableUnderElectionType(String electionid) throws SQLException {
        String result = "<items>";
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;
           
            ps = con.prepareStatement("select * from electionseat where election_id = ?");

            ps.setString(1, electionid);
            rs = ps.executeQuery();
            while (rs.next()) {
                result += "<item id='"+rs.getInt(1)+"'>" +rs.getString(2)+"</item>";
            }
            
          result += "</items>";
        } catch (Exception e) {
            System.out.println(e.getMessage());

        }

        return result;
    }


    public String MemberFullNameFetch(String memberid) throws SQLException {
        String result = "";
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select FullName from member WHERE MemberID=?");

            ps.setString(1, memberid);
            rs = ps.executeQuery();
            while (rs.next()) {
                result = rs.getString("FullName");
            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return result;
    }

    public String MemberFullNameFetcher(String condition) throws SQLException {
        String result = "";
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select FullName from member "+ condition);

            rs = ps.executeQuery();
            while (rs.next()) {
                result = rs.getString("FullName");
            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return result;
    }
    
    public String tokenFetcher(String token, String electionid) throws SQLException {
        String result = "Your token is either incorrect or has been used. Contact support..";
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select memberid from token WHERE token='"+token+"' and election_id='"+electionid+"' and is_used=0");

            rs = ps.executeQuery();
            while (rs.next()) {
                result = rs.getString("memberid");
            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return result;
    }
    public String MemberIDFetcher(String condition) throws SQLException {
        String result = "";
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select MemberID from member "+ condition);

            rs = ps.executeQuery();
            while (rs.next()) {
                result = rs.getString("MemberID");
            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return result;
    }
    public String MessageFetch(String id) throws SQLException {
        String result = "";
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select message from message WHERE id=?");

            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                result = rs.getString("message");
            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return result;
    }

    public String MessageTimeFetch(String id) throws SQLException {
        String result = "";
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select concat(send_hour,':',send_minute) as msgtime from message WHERE id=?");

            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                result = rs.getString("msgtime");
            }

        } catch (Exception e) {

            System.out.println(e.getMessage());
        }

        return result;
    }

    public String updateUserRecord(String role, String username) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE user SET role = ? Where username = ?; ";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, role);
            pst.setString(2, username);
            pst.execute();
            response = "Update Successful";

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

}
