/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.pojo;

import com.gpms.dbconnection.DBConnection;
import static com.sun.faces.facelets.util.Path.context;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.ws.rs.core.Response;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;
import javax.xml.bind.ValidationEvent;
import javax.xml.bind.ValidationEventHandler;

import org.xml.sax.InputSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import static org.apache.openejb.client.Client.request;
import org.quartz.CronScheduleBuilder;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import static org.quartz.TriggerBuilder.newTrigger;
import org.quartz.impl.StdSchedulerFactory;
import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 *
 * @author Developer
 */
public class DashboardModel {

    private static Connection con = null;
    private static final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    static {
        try {

            con = DBConnection.getConnection();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public double fetchWelfareTotalContribution() throws SQLException {

        double contribution = 0.0;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select sum(amount) as amount from contribution;");

            rs = ps.executeQuery();

            while (rs.next()) {
                contribution = rs.getDouble("amount");

            }

        } catch (Exception e) {

        }

        return contribution;
    }

    public String fetchYourTotalContribution(String memberid) throws SQLException {

        String contribution = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select sum(amount) as amount from contribution where MemberID = '" + memberid + "';");

            rs = ps.executeQuery();

            while (rs.next()) {
                contribution = rs.getString("amount");

            }

        } catch (Exception e) {

        }

        return contribution;
    }

    public String getMessage(String id) throws SQLException {

        String message = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select message from message where id = '" + id + "';");

            rs = ps.executeQuery();

            while (rs.next()) {
                message = rs.getString(1);

            }

        } catch (Exception e) {

        }

        return message;
    }

    public String sendBulkSMS(String id, String msg) throws SQLException {

        String message = "";
        String watchman1 = "";
        String watchman2 = "";
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;
            if (id.equals("1")) {
                ps = con.prepareStatement("select * from member;");
            }
            if (id.equals("2")) {
                ps = con.prepareStatement("select * from member Where position < 6 ;");
            }
            if (id.equals("3")) {
                ps = con.prepareStatement("select * from member Where Gender='M' AND Kids > 0 ;");
            }
            if (id.equals("4")) {
                ps = con.prepareStatement("select * from member Where Gender='F' AND Kids > 0 ;");
            }
            if (id.equals("5")) {
                ps = con.prepareStatement("select * from member Where Gender='M';");
            }
            if (id.equals("6")) {
                ps = con.prepareStatement("select * from member Where Gender='F';");
            }
            rs = ps.executeQuery();
            DashboardModel db = new DashboardModel();
            LoginModel log = new LoginModel();
            while (rs.next()) {

                message = db.rawMessageFormatter(msg, log.fetchIndividualMember(rs.getString("MemberID")).get(0));
                if (!message.equals("") || message != null) {
                    String resp = send(rs.getString("Mobile"), message);
                    if (!resp.equals("MSG_NOT_SENT_GK")) {
                        watchman1 = "ACT";
                        db.NewSMSLog(new SMS_LOG(rs.getString("FullName"), rs.getString("Mobile"), message, "SUCCESS"));
                    } else {
                        watchman2 = "Failed";
                        db.NewSMSLog(new SMS_LOG(rs.getString("FullName"), rs.getString("Mobile"), message, "FAILED"));
                    }
                }

            }

        } catch (Exception e) {

        }

        message = watchman1.equals("ACT") && watchman2.equals("Failed") ? watchman2 : watchman1;
        return message;
    }

    public String fetchLastInsertedMemberId() throws SQLException {

        String lastmemberid = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select Max(MemberID) as MemberID  from member;");

            rs = ps.executeQuery();

            while (rs.next()) {
                lastmemberid = rs.getString("MemberID");

            }
            if (lastmemberid == null) {
                lastmemberid = "0000";
            }

        } catch (Exception e) {

        }

        return lastmemberid;
    }

    public String fetchPositionName(int positionid) throws SQLException {

        String res = "";
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select rolename from position where roleId=" + positionid + ";");

            rs = ps.executeQuery();

            while (rs.next()) {
                res = rs.getString("rolename");

            }

        } catch (Exception e) {

        }

        return res;
    }

    public String sendIndividualSMS(String mobile, String sms, String memberid) throws SQLException {

        DashboardModel db = new DashboardModel();
        LoginModel log = new LoginModel();
        String alias = log.fetchIndividualMember(memberid).get(0).getAlias();
        String res = "";
        try {
            sms = sms.replaceAll("#alias#", alias == null ? "" : alias);
            if (!sms.equals("") || sms != null) {
                String resp = send(mobile, sms);
                if (!resp.equals("MSG_NOT_SENT_GK")) {
                    res = "ACT";
                    db.NewSMSLog(new SMS_LOG(log.fetchIndividualMember(memberid).get(0).getFullName(), mobile, sms, "SUCCESS"));
                } else {
                    res = "Failed";
                    db.NewSMSLog(new SMS_LOG(log.fetchIndividualMember(memberid).get(0).getFullName(), mobile, sms, "FAILED"));
                }
            }

        } catch (Exception e) {

        }

        return res;
    }

    public String sendIndividualEmail(String subject, String to, String sms, String memberid) throws SQLException {

        DashboardModel db = new DashboardModel();
        LoginModel log = new LoginModel();
        String alias = log.fetchIndividualMember(memberid).get(0).getAlias();
        String resp = "";
        try {
            sms = sms.replaceAll("#alias#", alias == null ? "" : alias);
            if (!sms.equals("") || sms != null) {
                resp = Email("Welcome to " + log.fetchOrganizationDetails().get(0).getName(), to, sms);
                if (!resp.equals("Problem sending email contact support")) {
                    db.NewEmailLog(new Email_Log(log.fetchIndividualMember(memberid).get(0).getFullName(), log.fetchIndividualMember(memberid).get(0).getEmail(), sms, "SUCCESS"));
                } else {
                    db.NewEmailLog(new Email_Log(log.fetchIndividualMember(memberid).get(0).getFullName(), log.fetchIndividualMember(memberid).get(0).getEmail(), sms, "FAILED"));
                }
            }

        } catch (Exception e) {

        }

        return resp;
    }

    public String updateMemberRecord(Member user) throws SQLException {

        String contribution = null;
        try {

            String SQL = "UPDATE member SET FullName = ?, DoB = ?, "
                    + "gender = ?, "
                    + "MaritalStatus = ?, "
                    + "Mobile = ?, "
                    + "Email = ?, "
                    + "Occupation = ?, "
                    + "kids = ?, "
                    + "position = ?, "
                    + "address = ?, "
                    + "about_me = ? "
                    + "Where MemberID=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, user.getFullName().trim());
            pst.setObject(2, user.getDob());
            pst.setString(3, user.getGender());
            pst.setString(4, user.getMaritalStatus());
            pst.setString(5, user.getMobile());
            pst.setString(6, user.getEmail());
            pst.setString(7, user.getOccupation());
            pst.setInt(8, user.getKids());
            pst.setString(9, user.getPosition());
            pst.setString(10, user.getAddress());
            pst.setString(11, user.getAboutMe());
            pst.setString(12, user.getMemberId());
            pst.execute();
            contribution = "Update Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contribution;
    }

    public String updateUserRecord(User user) throws SQLException {

        String contribution = null;
        try {

            String SQL = "UPDATE user SET fname = ?, lname = ?, "
                    + "username = ?, "
                    + "password = ?, "
                    + "email = ?, "
                    + "gender = ?, "
                    + "mobile = ?, "
                    + "role = ? "
                    + "Where username=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, user.getFname());
            pst.setObject(2, user.getLname());
            pst.setString(3, user.getUsername());
            pst.setString(4, user.getPassword());
            pst.setString(5, user.getEmail());
            pst.setString(6, user.getGender());
            pst.setString(7, user.getMobile());
            pst.setString(8, user.getRole());
            pst.setString(9, user.getUsername());
            pst.execute();
            contribution = "Update Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contribution;
    }

    public String updateOrganizationRecord(Organization org) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE organization SET organization_name = ?, address = ?, "
                    + "phone1 = ?, "
                    + "phone2 = ?, "
                    + "phone3 = ?, "
                    + "email = ?, "
                    + "about_org = ?, "
                    + "shortname = ? ";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, org.getName());
            pst.setObject(2, org.getAddress());
            pst.setString(3, org.getPhone_no1());
            pst.setString(4, org.getPhone_no2());
            pst.setString(5, org.getPhone_no3());
            pst.setString(6, org.getEmail());
            pst.setString(7, org.getAbout_org());
            pst.setString(8, org.getShortname());

            pst.execute();
            response = "Update Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String updateRole(Role role) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE role SET privilege = ? Where rolename=? ";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, role.getPrivilege());
            pst.setObject(2, role.getRolename());

            pst.execute();
            response = "Update Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String CreateNewMemberRecord(Member user, String currentuser) throws SQLException {
        String message = "";
        String emessage = "";
        String contribution = null;
        try {

            String SQL = "INSERT INTO member (MemberID, FullName, alias, DoB, "
                    + "gender, "
                    + "MaritalStatus, "
                    + "Mobile, "
                    + "altphone, "
                    + "Email, "
                    + "Occupation, "
                    + "kids, "
                    + "address, about_me, position, imageurl) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, user.getMemberId());
            pst.setString(2, user.getFullName().trim());
            pst.setString(3, user.getAlias());
            pst.setObject(4, user.getDob());
            pst.setString(5, user.getGender());
            pst.setString(6, user.getMaritalStatus());
            pst.setString(7, user.getMobile());
            pst.setString(8, user.getAltphone());
            pst.setString(9, user.getEmail());
            pst.setString(10, user.getOccupation());
            pst.setInt(11, user.getKids());
            pst.setString(12, user.getAddress());
            pst.setString(13, user.getAboutMe());
            pst.setInt(14, 6);
            pst.setString(15, "a18cdb71-eb7c-4dc0-87d1-dfd65d299a0c.png");

            pst.executeUpdate();
            SQL = "INSERT INTO contribution (MemberID ,amount, createdby) VALUES"
                    + "(?,?,?)";
            pst = con.prepareStatement(SQL);
            pst.setString(1, user.getMemberId());
            pst.setDouble(2, 0.00);
            pst.setString(3, currentuser);
            pst.executeUpdate();
            contribution = "Insert Operation Successful";
            DashboardModel db = new DashboardModel();
            LoginModel lg = new LoginModel();
            message = db.messageFormatter(db.getMessage("1"), user);
            String msg = message;
            if (!message.equals("") || message != null) {

                String resp = send(user.getMobile(), msg);
                if (!resp.equals("MSG_NOT_SENT_GK")) {
                    db.NewSMSLog(new SMS_LOG(user.getFullName(), user.getMobile(), msg, "SUCCESS", "", "1"));
                } else {
                    db.NewSMSLog(new SMS_LOG(user.getFullName(), user.getMobile(), msg, "FAILED", "", "1"));
                }
            }
            emessage = db.messageFormatter(db.getMessage("3"), user);
            emessage += db.memberDetailsinHTMLFormat(user);
            if (!emessage.equals("") || emessage != null) {
                String resp = Email("Welcome to " + lg.fetchOrganizationDetails().get(0).getName(), user.getEmail(), emessage);
                if (!resp.equals("Problem sending email contact support")) {
                    db.NewEmailLog(new Email_Log(user.getFullName(), user.getEmail(), emessage, "SUCCESS", "", "3"));
                } else {
                    db.NewEmailLog(new Email_Log(user.getFullName(), user.getEmail(), emessage, "FAILED", "", "3"));
                }
            }
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contribution;
    }

    public String randomAlphaNumeric(int count) {

        StringBuilder builder = new StringBuilder();

        while (count-- != 0) {

            int character = (int) (Math.random() * ALPHA_NUMERIC_STRING.length());

            builder.append(ALPHA_NUMERIC_STRING.charAt(character));

        }

        return builder.toString();

    }

    public String SendTokenToMember(List<Member> memberlist, String electionid) throws SQLException {
        String message = "";
        String emessage = "";
        String contribution = null;
        try {
            DashboardModel dbm = new DashboardModel();
            String SQL = "Delete from token "
                    + "Where election_id=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, electionid);

            pst.execute();
            String response = "Delete Successful";
            if (response.equals("Delete Successful")) {
                int h = 0;
                while (h < dbm.CountMembers()) {
                    Member user = memberlist.get(h);
                    String token = dbm.randomAlphaNumeric(9);

                    SQL = "INSERT INTO token (token, election_id, is_used, memberid ) VALUES(?,?,?,?)";

                    pst = con.prepareStatement(SQL);
                    pst.setString(1, token);
                    pst.setString(2, electionid);
                    pst.setInt(3, 0);
                    pst.setString(4, user.getMemberId());
                    pst.executeUpdate();

                    contribution = "Insert Operation Successful";

                    DashboardModel db = new DashboardModel();
                    LoginModel lg = new LoginModel();
                    message = db.electionMessageFormatter(db.getMessage("10"), user, token);
                    String msg = message;
                    if (!message.equals("") || message != null) {

                        String resp = send(user.getMobile(), msg);
                        if (!resp.equals("MSG_NOT_SENT_GK")) {
                            db.NewSMSLog(new SMS_LOG(user.getFullName(), user.getMobile(), msg, "SUCCESS", "", "10"));
                        } else {
                            db.NewSMSLog(new SMS_LOG(user.getFullName(), user.getMobile(), msg, "FAILED", "", "10"));
                        }
                    }
                    emessage = db.electionMessageFormatter(db.getMessage("11"), user, token);
                    if (!emessage.equals("") || emessage != null) {
                        String resp = Email("Your Election Token!", user.getEmail(), emessage);
                        if (!resp.equals("Problem sending email contact support")) {
                            db.NewEmailLog(new Email_Log(user.getFullName(), user.getEmail(), emessage, "SUCCESS", "", "11"));
                        } else {
                            db.NewEmailLog(new Email_Log(user.getFullName(), user.getEmail(), emessage, "FAILED", "", "11"));
                        }
                    }
                    pst.close();

                    h++;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contribution;
    }

    public String CreateElectionSeatsRecord(ElectionSeat eSeat) throws SQLException {

        String contribution = "";
        try {

            String SQL = "INSERT INTO electionseat (seatname, election_id) VALUES(?,?)";

            PreparedStatement pst = con.prepareStatement(SQL);
            ResultSet rs = null;
            pst.setString(1, eSeat.getSeatName());
            pst.setInt(2, eSeat.getElectionid());
            pst.executeUpdate();
            contribution = "Insert Operation Successful";

            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contribution;
    }

    public String CreateCandidateRecord(Candidate candidate) throws SQLException {

        String contribution = "";
        try {
            String SQL = "Delete from candidate "
                    + "Where memberId = '" + candidate.getMemberid() + "' and seat_id in (select seat_id from electionseat where election_id ='" + candidate.getElectionid() + "' )";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.execute();
            String response = "Delete Successful";

            if (response.equals("Delete Successful")) {

                SQL = "INSERT INTO candidate (memberId, seat_id, manifesto) VALUES(?,?,?)";

                pst = con.prepareStatement(SQL);

                ResultSet rs = null;
                pst.setString(1, candidate.getMemberid());
                pst.setString(2, candidate.getSeatid());
                pst.setString(3, candidate.getManifesto());
                pst.executeUpdate();
                pst = con.prepareStatement("select candidate_id from candidate where memberId = '" + candidate.getMemberid() + "' AND seat_id = '" + candidate.getSeatid() + "' And manifesto='" + candidate.getManifesto() + "';");

                rs = pst.executeQuery();

                while (rs.next()) {
                    contribution = String.valueOf(rs.getInt("candidate_id"));

                }

                pst.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contribution;
    }

    public String CreateElectionRecord(ElectionType etype, String curentuser) throws SQLException {
        String contribution = "";
        try {

            String SQL = "INSERT INTO electiontype (election_name, election_startdate, election_enddate, createdby, formopeningdate, formclosingdate, tokenbroadcastdate) VALUES(?,?,?, ?, ?,?, ?)";

            PreparedStatement pst = con.prepareStatement(SQL);
            ResultSet rs = null;
            pst.setString(1, etype.getElectionName());
            pst.setObject(2, etype.getElectionStartDate());
            pst.setObject(3, etype.getElectionEndDate());
            pst.setString(4, curentuser);
            pst.setObject(5, etype.getFormOpeningDate());
            pst.setObject(6, etype.getFormClosingDate());
            pst.setObject(7, etype.getTokenBroadcastDate());

            pst.executeUpdate();
            pst = con.prepareStatement("select election_id from electiontype where election_name = '" + etype.getElectionName() + "';");

            rs = pst.executeQuery();

            while (rs.next()) {
                contribution = String.valueOf(rs.getInt("election_id"));

            }
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contribution;
    }

    public String memberDetailsinHTMLFormat(Member member) {
        String msg = "<p>Your registration details are as follows:<p>";
        msg += "<p><b>Full Name: </b>" + member.getFullName() + "</p>";
        msg += "<p><b>Alias: </b>" + member.getAlias() + "</p>";
        msg += "<p><b>Email Address: </b>" + member.getEmail() + "</p>";
        msg += "<p><b>Date of Birth: </b>" + member.getDob() + "</p>";
        msg += "<p><b>Gender: </b>" + member.getGender() + "</p>";
        msg += "<p><b>Phone #: </b>" + member.getMobile() + "</p>";
        msg += "<p><b>Alternative Phone #: </b>" + member.getAltphone() + "</p>";
        msg += "<p><b>Occupation: </b>" + member.getOccupation() + "</p>";
        msg += "<p><b>Residential Address: </b>" + member.getAddress() + "</p>";
        msg += "<p><b>Short Profile: </b>" + member.getAboutMe() + "</p>";
        return msg;
    }

    public String messageFormatter(String cmessage, Member user) throws SQLException {
        try {
            LoginModel lg = new LoginModel();
            cmessage = cmessage.replaceAll("#lastname#", "");
            cmessage = cmessage.replaceAll("#firstname#", "");
            cmessage = cmessage.replaceAll("#username#", "");
            cmessage = cmessage.replaceAll("#password#", "");
            cmessage = cmessage.replaceAll("#fullname#", user.getFullName() == null ? "" : user.getFullName());
            cmessage = cmessage.replaceAll("#alias#", user.getAlias() == null ? "" : user.getAlias());
            cmessage = cmessage.replaceAll("#organizationName#", lg.fetchOrganizationDetails().get(0).getName() == null ? "" : lg.fetchOrganizationDetails().get(0).getName());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cmessage;

    }

    public String electionMessageFormatter(String cmessage, Member user, String token) throws SQLException {
        try {
            LoginModel lg = new LoginModel();
            cmessage = cmessage.replaceAll("#lastname#", "");
            cmessage = cmessage.replaceAll("#firstname#", "");
            cmessage = cmessage.replaceAll("#username#", "");
            cmessage = cmessage.replaceAll("#password#", "");
            cmessage = cmessage.replaceAll("#fullname#", user.getFullName() == null ? "" : user.getFullName());
            cmessage = cmessage.replaceAll("#alias#", user.getAlias() == null ? "" : user.getAlias());
            cmessage = cmessage.replaceAll("#electiontoken#", token);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cmessage;

    }

    public String ContributionMessageFormatter(String cmessage, Member user) throws SQLException {
        try {
            LoginModel lg = new LoginModel();
            cmessage = cmessage.replaceAll("#lastname#", "");
            cmessage = cmessage.replaceAll("#firstname#", "");
            cmessage = cmessage.replaceAll("#username#", "");
            cmessage = cmessage.replaceAll("#password#", "");
            cmessage = cmessage.replaceAll("#fullname#", user.getFullName() == null ? "" : user.getFullName());
            cmessage = cmessage.replaceAll("#alias#", user.getAlias() == null ? "" : user.getAlias());
            cmessage = cmessage.replaceAll("#organizationName#", lg.fetchOrganizationDetails().get(0).getName() == null ? "" : lg.fetchOrganizationDetails().get(0).getName());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cmessage;

    }

    public String rawMessageFormatter(String cmessage, Member user) throws SQLException {
        try {
            LoginModel lg = new LoginModel();
            cmessage = cmessage.replaceAll("#lastname#", "");
            cmessage = cmessage.replaceAll("#firstname#", "");
            cmessage = cmessage.replaceAll("#username#", "");
            cmessage = cmessage.replaceAll("#password#", "");
            cmessage = cmessage.replaceAll("#fullname#", user.getFullName() == null ? "" : user.getFullName());
            cmessage = cmessage.replaceAll("#alias#", user.getAlias() == null ? "" : user.getAlias());
            cmessage = cmessage.replaceAll("#organizationName#", lg.fetchOrganizationDetails().get(0).getName() == null ? "" : lg.fetchOrganizationDetails().get(0).getName());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cmessage;

    }

    public String birthdayMessageFormatter(String cmessage, BirthdayInfoModel user) throws SQLException {
        try {
            LoginModel lg = new LoginModel();
            cmessage = cmessage.replaceAll("#firstname#", "");
            cmessage = cmessage.replaceAll("#lastname#", "");
            cmessage = cmessage.replaceAll("#fullname#", user.getFullname() == null ? "" : user.getFullname());
            cmessage = cmessage.replaceAll("#organizationName#", lg.fetchOrganizationDetails().get(0).getName() == null ? "" : lg.fetchOrganizationDetails().get(0).getName());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cmessage;

    }

    public String birthdayMessageAlerttoAdminFormatter(String cmessage, BirthdayInfoModel user) throws SQLException {
        try {
            LoginModel lg = new LoginModel();
            cmessage = cmessage.replaceAll("#firstname#", "");
            cmessage = cmessage.replaceAll("#lastname#", "");
            cmessage = cmessage.replaceAll("#memberid#", user.getMemberId() == null ? "" : user.getMemberId());
            cmessage = cmessage.replaceAll("#fullname#", user.getFullname() == null ? "" : user.getFullname());
            cmessage = cmessage.replaceAll("#alias#", user.getAlias() == null ? "" : user.getAlias());
            cmessage = cmessage.replaceAll("#organizationName#", lg.fetchOrganizationDetails().get(0).getName() == null ? "" : lg.fetchOrganizationDetails().get(0).getName());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cmessage;

    }

    public String messageFormat(String cmessage, User user) throws SQLException {
        try {
            LoginModel lg = new LoginModel();
            cmessage = cmessage.replaceAll("#lastname#", user.getLname() == null ? "" : user.getLname());
            cmessage = cmessage.replaceAll("#firstname#", user.getFname() == null ? "" : user.getFname());
            cmessage = cmessage.replaceAll("#lastname#", user.getLname() == null ? "" : user.getLname());
            cmessage = cmessage.replaceAll("#username#", user.getUsername() == null ? "" : user.getUsername());
            cmessage = cmessage.replaceAll("#password#", user.getPassword() == null ? "" : user.getPassword());
            cmessage = cmessage.replaceAll("#organizationName#", lg.fetchOrganizationDetails().get(0).getName() == null ? "" : lg.fetchOrganizationDetails().get(0).getName());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cmessage;

    }

    public String CreateNewUserRecord(User user, String currentuser) throws SQLException {
        String message = "";
        String emessage = "";
        String contribution = null;
        try {

            String SQL = "INSERT INTO user (fname, lname, username, "
                    + "password, "
                    + "email, "
                    + "gender, "
                    + "mobile, "
                    + "role, "
                    + "imageurl) VALUES(?,?,?,?,?,?,?,?, ?)";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, user.getFname());
            pst.setString(2, user.getLname());
            pst.setString(3, user.getUsername());
            pst.setString(4, user.getPassword());
            pst.setString(5, user.getEmail());
            pst.setString(6, user.getGender());
            pst.setString(7, user.getMobile());
            pst.setInt(8, 3);
            pst.setString(9, "a18cdb71-eb7c-4dc0-87d1-dfd65d299a0c.png");

            pst.executeUpdate();

            contribution = "Insert Operation Successful";
            DashboardModel db = new DashboardModel();
            LoginModel lg = new LoginModel();
            message = db.messageFormat(db.getMessage("2"), user);
            if (!message.equals("") || message != null) {
                String resp = send(user.getMobile(), message);
                if (!resp.equals("MSG_NOT_SENT_GK")) {
                    db.NewSMSLog(new SMS_LOG(user.getFname() + " " + user.getLname(), user.getMobile(), message, "SUCCESS", "", "2"));
                } else {
                    db.NewSMSLog(new SMS_LOG(user.getFname() + " " + user.getLname(), user.getMobile(), message, "FAILED", "", "2"));
                }
            }
            emessage = db.messageFormat(db.getMessage("4"), user);
            if (!emessage.equals("") || emessage != null) {
                String resp = Email("Welcome to " + lg.fetchOrganizationDetails().get(0).getName() + " Platform", user.getEmail(), emessage);
                if (!resp.equals("Problem sending email contact support")) {
                    db.NewEmailLog(new Email_Log(user.getFname() + " " + user.getLname(), user.getEmail(), emessage, "SUCCESS", "", "4"));
                } else {
                    db.NewEmailLog(new Email_Log(user.getFname() + " " + user.getLname(), user.getEmail(), emessage, "FAILED", "", "4"));
                }
            }
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contribution;
    }

    public String CreateNewUserRecord(User user) throws SQLException {

        String contribution = null;
        try {

            String SQL = "INSERT INTO user (fname, lname, username, "
                    + "password, "
                    + "email, "
                    + "gender, "
                    + "Mobile) VALUES(?,?,?,?,?,?,?)";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, user.getFname());
            pst.setString(2, user.getLname());
            pst.setString(3, user.getUsername());
            pst.setString(4, user.getPassword());
            pst.setString(5, user.getEmail());
            pst.setString(6, user.getGender());
            pst.setString(7, user.getMobile());
            pst.executeUpdate();
            contribution = "Insert Operation Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contribution;
    }

    public String CreateNewEventRecord(Event ev, String currentuser) throws SQLException {

        String contribution = null;
        try {

            String SQL = "INSERT INTO event (ename, edescription, startdate, "
                    + "enddate, createdby) VALUES(?,?,?,?, ?)";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, ev.getName());
            pst.setString(2, ev.getDescription());
            pst.setObject(3, ev.getStartDate());
            pst.setObject(4, ev.getEndDate());
            pst.setString(5, currentuser);
            pst.executeUpdate();
            contribution = "Insert Operation Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contribution;
    }

    public String CreateNewContribution(Contribution ev, String currentuser) throws SQLException {
        String message = "";
        String emessage = "";
        String contribution = null;
        try {

            String SQL = "INSERT INTO contribution (MemberId, amount, eventid, createdby "
                    + ") VALUES(?,?,?,?)";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, ev.getMemberid());
            pst.setDouble(2, ev.getContribution());
            pst.setString(3, ev.getEvent());
            pst.setString(4, currentuser);
            pst.executeUpdate();
            contribution = "Insert Operation Successful";
            DashboardModel db = new DashboardModel();
            LoginModel lmodel = new LoginModel();
            Member user = lmodel.fetchIndividualMember(ev.getMemberid()).get(0);
            message = db.ContributionMessageFormatter(db.getMessage("8"), user);
            Event emodel = db.fetchEventsById(Integer.parseInt(ev.getEvent())).get(0);
            message = message.replaceAll("#contribution#", String.valueOf(ev.getContribution()) == null ? "" : String.valueOf(ev.getContribution()));
            message = message.replaceAll("#event#", emodel.getDescription() == null ? "" : emodel.getDescription());
            message = message.replaceAll("#startdate#", emodel.getStartDate() == null ? "" : emodel.getStartDate());
            message = message.replaceAll("#enddate#", emodel.getEndDate() == null ? "" : emodel.getEndDate());

            if (!message.equals("") || message != null) {
                String resp = send(user.getMobile(), message);
                if (!resp.equals("MSG_NOT_SENT_GK")) {
                    db.NewSMSLog(new SMS_LOG(user.getFullName(), user.getMobile(), message, "SUCCESS"));
                } else {
                    db.NewSMSLog(new SMS_LOG(user.getFullName(), user.getMobile(), message, "FAILED"));
                }
            }
            emessage = db.ContributionMessageFormatter(db.getMessage("9"), user);
            emessage = emessage.replaceAll("#contribution#", String.valueOf(ev.getContribution()) == null ? "" : String.valueOf(ev.getContribution()));
            emessage = emessage.replaceAll("#event#", emodel.getDescription() == null ? "" : emodel.getDescription());
            emessage = emessage.replaceAll("#startdate#", emodel.getStartDate() == null ? "" : emodel.getStartDate());
            emessage = emessage.replaceAll("#enddate#", emodel.getEndDate() == null ? "" : emodel.getEndDate());
            if (!emessage.equals("") || emessage != null) {
                String resp = Email("We Have Recieved Your Contribution!", user.getEmail(), emessage);
                if (!resp.equals("Problem sending email contact support")) {
                    db.NewEmailLog(new Email_Log(user.getFullName(), user.getEmail(), emessage, "SUCCESS"));
                } else {
                    db.NewEmailLog(new Email_Log(user.getFullName(), user.getEmail(), emessage, "FAILED"));
                }
            }
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contribution;
    }

    public String CreateNewBeneficiary(Contribution ev, String currentuser) throws SQLException {
        String message = "";
        String emessage = "";
        String contribution = null;
        try {
            PreparedStatement ps = null;
            ResultSet rs = null;
            double amount = 0.0;
            String memberid = "";

            ps = con.prepareStatement("select * from beneficiary where member_id = '"+ ev.getMemberid()+"' AND event_id = '"+ev.getEvent()+"' ");

            rs = ps.executeQuery();

            while (rs.next()) {
                amount = rs.getDouble("amount");
                memberid = rs.getString("member_id");
            }
            if(!"".equals(memberid)){
            amount += ev.getContribution();    
            String SQL = "UPDATE beneficiary SET amount = ?, modifiedby=? "
                    + "Where member_id=? and event_id =?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setDouble(1, amount);
            pst.setString(2, currentuser);
            pst.setString(3, ev.getMemberid());
            pst.setString(4, ev.getEvent());

            pst.execute();
            contribution = "Update Successful";
            pst.close();
            
            }else{
            String SQL = "INSERT INTO beneficiary (member_id, amount, event_id, createdby "
                    + ") VALUES(?,?,?,?)";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, ev.getMemberid());
            pst.setDouble(2, ev.getContribution());
            pst.setString(3, ev.getEvent());
            pst.setString(4, currentuser);
            pst.executeUpdate();
            contribution = "Insert Operation Successful";
            DashboardModel db = new DashboardModel();
            LoginModel lmodel = new LoginModel();
            Member user = lmodel.fetchIndividualMember(ev.getMemberid()).get(0);
            message = db.ContributionMessageFormatter(db.getMessage("13"), user);
            Event emodel = db.fetchEventsById(Integer.parseInt(ev.getEvent())).get(0);
            message = message.replaceAll("#beneficiaryAmount#", String.valueOf(ev.getContribution()) == null ? "" : String.valueOf(ev.getContribution()));
            message = message.replaceAll("#event#", emodel.getDescription() == null ? "" : emodel.getDescription());
            message = message.replaceAll("#eventdate#", emodel.getStartDate() == null ? "" : emodel.getStartDate());
            message = message.replaceAll("#enddate#", emodel.getEndDate() == null ? "" : emodel.getEndDate());

            if (!message.equals("") || message != null) {
                String resp = send(user.getMobile(), message);
                if (!resp.equals("MSG_NOT_SENT_GK")) {
                    db.NewSMSLog(new SMS_LOG(user.getFullName(), user.getMobile(), message, "SUCCESS"));
                } else {
                    db.NewSMSLog(new SMS_LOG(user.getFullName(), user.getMobile(), message, "FAILED"));
                }
            }
            emessage = db.ContributionMessageFormatter(db.getMessage("14"), user);
            emessage = emessage.replaceAll("#beneficiaryAmount#", String.valueOf(ev.getContribution()) == null ? "" : String.valueOf(ev.getContribution()));
            emessage = emessage.replaceAll("#event#", emodel.getDescription() == null ? "" : emodel.getDescription());
            emessage = emessage.replaceAll("#eventdate#", emodel.getStartDate() == null ? "" : emodel.getStartDate());
            emessage = emessage.replaceAll("#enddate#", emodel.getEndDate() == null ? "" : emodel.getEndDate());
            if (!emessage.equals("") || emessage != null) {
                String resp = Email("Your Beneficiary Amount Has Been Sent!", user.getEmail(), emessage);
                if (!resp.equals("Problem sending email contact support")) {
                    db.NewEmailLog(new Email_Log(user.getFullName(), user.getEmail(), emessage, "SUCCESS"));
                } else {
                    db.NewEmailLog(new Email_Log(user.getFullName(), user.getEmail(), emessage, "FAILED"));
                }
            }
            pst.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return contribution;
    }

    public String UpdateEventRecord(Event ev, String currentuser) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE event SET ename = ?, edescription=?, startdate=?, enddate=?, modifiedby=?, modifiedon=? "
                    + "Where eid=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, ev.getName());
            pst.setString(2, ev.getDescription());
            pst.setString(3, ev.getStartDate());
            pst.setString(4, ev.getEndDate());
            pst.setString(5, currentuser);
            pst.setObject(6, new Date());
            pst.setInt(7, ev.getEid());

            pst.execute();
            response = "Update Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String UpdateContributionRecord(Contribution ev, String currentuser) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE contribution SET amount = ?, eventid=?, modifiedby=?, modifiedon=? "
                    + "Where id=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setDouble(1, ev.getContribution());
            pst.setInt(2, ev.getEventid());
            pst.setString(3, currentuser);
            pst.setObject(4, new Date());
            pst.setInt(5, ev.getContrubtionid());

            pst.execute();
            response = "Update Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }
    
    public String UpdateBeneficiaryRecord(Contribution ev, String currentuser) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE beneficiary SET amount = ?, modifiedby=? "
                    + "Where id=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setDouble(1, ev.getContribution());
            pst.setString(2, currentuser);
            pst.setInt(3, ev.getContrubtionid());

            pst.execute();
            response = "Update Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public List<VoteResult> fetchVoteSummary(String electionid) throws SQLException {

        List<VoteResult> voteresult = new ArrayList<>();
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select count(MemberID), (SELECT COUNT(DISTINCT token) from vote where token in (select token from token where election_id = '" + electionid + "')) from member ");

            rs = ps.executeQuery();

            while (rs.next()) {
                voteresult.add(new VoteResult(rs.getInt(2), rs.getInt(1)));
            }

        } catch (Exception e) {

        }

        return voteresult;
    }

    public List<VoteResult> fetchVoteAnalysis(String electionid) throws SQLException {

        List<VoteResult> voteresult = new ArrayList<>();
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select fullName,v.seat_id, (select seatname from electionseat where seat_id= v.seat_id) as seatname, count(v.memberid) as num_of_votes from member m join vote v on m.MemberID = v.memberid where v.seat_id in (select seat_id from electionseat where election_id ='" + electionid + "') Group by v.memberid;");

            rs = ps.executeQuery();

            while (rs.next()) {
                voteresult.add(new VoteResult(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4)));
            }

        } catch (Exception e) {

        }

        return voteresult;
    }

    public List<ElectionSeat> fetchElectionSeats(String eid) throws SQLException {
        List<ElectionSeat> positionlist = new ArrayList<>();
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select (select count(seat_id) from candidate where seat_id = e.seat_id group by e.seat_id), e.seatname, (select count(seat_id) from vote where seat_id = e.seat_id  group by e.seat_id) from electionseat e where e.election_id = '" + eid + "';");

            rs = ps.executeQuery();

            while (rs.next()) {
                positionlist.add(new ElectionSeat(rs.getInt(1), rs.getInt(3), rs.getString(2)));

            }

        } catch (Exception e) {

        }

        return positionlist;
    }

    public List<BirthdayInfoModel> fetchMembersWithTheirAlias() throws SQLException {
        List<BirthdayInfoModel> loginCred = new ArrayList<>();
        BirthdayInfoModel member = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;
            if (con != null) {
                ps = con.prepareStatement("SELECT MemberID, FullName, alias, mobile, email FROM member where EXTRACT(MONTH FROM dob)=EXTRACT(MONTH FROM current_date()) AND EXTRACT(DAY FROM dob)=EXTRACT(DAY FROM current_date());");

                rs = ps.executeQuery();

                while (rs.next()) {

                    member = new BirthdayInfoModel(rs.getString("MemberID"), rs.getString("FullName"), rs.getString("alias"), rs.getString("mobile"), rs.getString("email"));

                    loginCred.add(member);

                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());

        }
        return loginCred;
    }

    public String UpdateElectionRecord(ElectionType ev, String currentuser) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE electiontype SET election_name = ?, election_startdate=?, election_enddate=?, formopeningdate=?, formclosingdate=?, modifiedby=?, modifiedon=? "
                    + "Where election_id=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, ev.getElectionName());
            pst.setObject(2, ev.getElectionStartDate());
            pst.setObject(3, ev.getElectionEndDate());
            pst.setObject(4, ev.getFormOpeningDate());
            pst.setObject(5, ev.getFormClosingDate());
            pst.setString(6, currentuser);
            pst.setObject(7, new Date());
            pst.setInt(8, ev.getId());

            pst.execute();
            response = "Update Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String deleteEventRecord(int id) throws SQLException {

        String response = null;
        try {

            String SQL = "Delete from event "
                    + "Where eid=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setInt(1, id);

            pst.execute();
            response = "Delete Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String deleteContributionRecord(int id) throws SQLException {

        String response = null;
        try {

            String SQL = "Delete from contribution "
                    + "Where id=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setInt(1, id);

            pst.execute();
            response = "Delete Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }
    
    public String deleteBeneficiaryRecord(int id) throws SQLException {

        String response = null;
        try {

            String SQL = "Delete from beneficiary "
                    + "Where id=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setInt(1, id);

            pst.execute();
            response = "Delete Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String deleteElectionRecord(int id) throws SQLException {

        String response = null;
        try {
            String SQL = "Delete from token "
                    + "Where election_id=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setInt(1, id);

            pst.execute();
            SQL = "Delete from vote "
                    + "Where seat_id in (select seat_id from electionseat where election_id=?);";

            pst = con.prepareStatement(SQL);
            pst.setInt(1, id);

            pst.execute();
            SQL = "Delete from candidate "
                    + "Where seat_id in (select seat_id from electionseat where election_id=?);";

            pst = con.prepareStatement(SQL);
            pst.setInt(1, id);

            pst.execute();
            SQL = "Delete from electionseat "
                    + "Where election_id=?;";

            pst = con.prepareStatement(SQL);
            pst.setInt(1, id);

            pst.execute();
            SQL = "Delete from electiontype "
                    + "Where election_id=?;";

            pst = con.prepareStatement(SQL);
            pst.setInt(1, id);

            pst.execute();
            response = "Delete Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String deleteCandidateRecord(int id, int cid) throws SQLException {

        String response = null;
        try {
            String SQL = "Delete from candidate "
                    + "Where candidate_Id=? And seat_id in (select seat_id from electionseat where election_id=?);";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setInt(1, cid);
            pst.setInt(2, id);

            pst.execute();
            response = "Delete Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String updateUserImageurl(User user) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE user SET imageurl = ? "
                    + "Where username=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, user.getImageurl());
            pst.setObject(2, user.getUsername());
            pst.execute();
            response = "Update Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String updateCandidatemageurl(int cid, String url) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE candidate SET campaign_picture = ? "
                    + "Where candidate_id=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, url);
            pst.setInt(2, cid);
            pst.execute();
            response = "Update Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String updateMemberImageurl(Member user) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE member SET imageurl = ? "
                    + "Where MemberID=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, user.getImageurl());
            pst.setObject(2, user.getMemberId());
            pst.execute();
            response = "Update Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String updateMemberImageurl(String MemberID, String url) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE member SET imageurl = ? "
                    + "Where MemberID=?;";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, url);
            pst.setObject(2, MemberID);
            pst.execute();
            response = "Update Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String updateOrganizationlogo(Organization org) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE organization SET logo = ?; ";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, org.getLogo());
            pst.execute();
            response = "Update Successful";
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String updateSMTPServerId(String id) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE organization SET smtpconfigID = ?; ";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, id);
            pst.execute();
            response = "Update Successful";
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String updateMessage(String id, String message, String hour, String minute) throws SQLException {
        DashboardModel db = new DashboardModel();
        String response = null;
        try {

            String SQL = "UPDATE message SET message = ?, send_hour = ?, send_minute=? where id = ?; ";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, message);
            pst.setString(2, hour);
            pst.setString(3, minute);
            pst.setString(4, id);
            pst.execute();
            response = "Update Successful";
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String updateSMSAPIId(String id) throws SQLException {

        String response = null;
        try {

            String SQL = "UPDATE organization SET smsAPIID = ?; ";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, id);
            pst.execute();
            response = "Update Successful";
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }

    public String CreateNewSMTPServerRecord(Company comp) throws SQLException {

        String contribution = null;
        try {

            String SQL = "INSERT INTO server (host, port, username, "
                    + "password) VALUES(?,?,?,?)";

            PreparedStatement pst = con.prepareStatement(SQL);
            pst.setString(1, comp.getHost());
            pst.setString(2, comp.getPort());
            pst.setString(3, comp.getUsername());
            pst.setString(4, comp.getPassword());

            pst.executeUpdate();

            contribution = "Insert Operation Successful";
            pst.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contribution;
    }

    public Company fetchSMTPServerConfig(String memberid) throws SQLException {
        Company comp = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select * from server where id = '" + memberid + "';");

            rs = ps.executeQuery();

            while (rs.next()) {
                comp = new Company(rs.getString("id"), rs.getString("host"), rs.getString("port"), rs.getString("username"), rs.getString("password"), "true", "true");

            }

        } catch (Exception e) {

        }

        return comp;
    }

    public DailyBroadcastTime fetchMessageBroadcastTime(int id) throws SQLException {
        DailyBroadcastTime comp = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select send_hour, send_minute from message where id = " + id + ";");

            rs = ps.executeQuery();

            while (rs.next()) {
                comp = new DailyBroadcastTime(rs.getString("send_hour"), rs.getString("send_minute"));

            }

        } catch (Exception e) {

        }

        return comp;
    }

    public List<PositionModel> fetchMemberPosition() throws SQLException {
        List<PositionModel> positionlist = new ArrayList<>();
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select * from position where roleId not in(select position from member);");

            rs = ps.executeQuery();

            while (rs.next()) {
                positionlist.add(new PositionModel(rs.getString(1), rs.getString(2)));

            }

        } catch (Exception e) {

        }

        return positionlist;
    }

    public List<ElectionSeat> fetchElectionSeat(String eid) throws SQLException {
        List<ElectionSeat> positionlist = new ArrayList<>();
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select (select count(seat_id) from candidate where seat_id = e.seat_id group by e.seat_id), e.seatname from electionseat e where e.election_id = '" + eid + "';");

            rs = ps.executeQuery();

            while (rs.next()) {
                positionlist.add(new ElectionSeat(rs.getInt(1), rs.getString(2)));

            }

        } catch (Exception e) {

        }

        return positionlist;
    }

    public String fetchToken(String eid, String memid) throws SQLException {
        String token = "";
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select token from token where memberid='" + memid + "' and election_id = '" + eid + "';");

            rs = ps.executeQuery();

            while (rs.next()) {
                token = rs.getString("token");

            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return token;
    }

    public int CountMembers() throws SQLException {
        int count = 0;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select count(*) from member;");

            rs = ps.executeQuery();

            while (rs.next()) {
                count = rs.getInt(1);

            }

        } catch (Exception e) {

        }

        return count;
    }

    public List<Candidate> fetchCandidates(String eid) throws SQLException {
        List<Candidate> candidatelist = new ArrayList<>();
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select c.memberId, (select FullName from member where MemberID = c.memberId),c.seat_id,(select seatname from electionseat where seat_id = c.seat_id), c.manifesto, c.campaign_picture  from candidate c WHERE c.seat_id in (select seat_id from electionseat where election_id = '" + eid + "');");

            rs = ps.executeQuery();

            while (rs.next()) {
                candidatelist.add(new Candidate(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6)));

            }

        } catch (Exception e) {

        }

        return candidatelist;
    }

    public List<Candidate> fetchCandidates_Modified(String eid) throws SQLException {
        List<Candidate> candidatelist = new ArrayList<>();
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select c.candidate_id, c.memberId, (select FullName from member where MemberID = c.memberId),c.seat_id,(select seatname from electionseat where seat_id = c.seat_id), c.manifesto, c.campaign_picture  from candidate c WHERE c.seat_id in (select seat_id from electionseat where election_id = '" + eid + "');");

            rs = ps.executeQuery();

            while (rs.next()) {
                candidatelist.add(new Candidate(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7)));

            }

        } catch (Exception e) {

        }

        return candidatelist;
    }

    public int fetchHighestSeatId(String eid) throws SQLException {
        int max = 0;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select max(seat_id) from electionseat where election_id = '" + eid + "';");

            rs = ps.executeQuery();

            while (rs.next()) {
                max = rs.getInt(1);

            }

        } catch (Exception e) {

        }

        return max;
    }

    public List<EventModel> fetchEventsAndId() throws SQLException {
        List<EventModel> positionlist = new ArrayList<>();
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select * from event where startdate >= curdate() or enddate >=curdate();");

            rs = ps.executeQuery();

            while (rs.next()) {
                positionlist.add(new EventModel(rs.getInt(1), rs.getString(3)));

            }

        } catch (Exception e) {

        }

        return positionlist;
    }

    public List<SMS_LOG> fetchSMSRecords() throws SQLException {
        List<SMS_LOG> smsrecordlist = new ArrayList<>();
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select * from sms_log;");

            rs = ps.executeQuery();

            while (rs.next()) {
                smsrecordlist.add(new SMS_LOG(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6)));

            }

        } catch (Exception e) {

        }

        return smsrecordlist;
    }

    public List<Email_Log> fetchEmailRecords() throws SQLException {
        List<Email_Log> emailrecordlist = new ArrayList<>();
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select * from email_log;");

            rs = ps.executeQuery();

            while (rs.next()) {
                emailrecordlist.add(new Email_Log(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6)));

            }

        } catch (Exception e) {

        }

        return emailrecordlist;
    }

    public List<Event> fetchEventRecordsWithTotalContribution() throws SQLException {
        List<Event> eventrecordlist = new ArrayList<>();
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select e.ename, e.edescription, sum(c.amount) as contribution from event e join contribution c on e.eid=c.eventid Group by e.eid;");

            rs = ps.executeQuery();

            while (rs.next()) {
                eventrecordlist.add(new Event(rs.getString(1), rs.getString(2), rs.getDouble(3)));

            }

        } catch (Exception e) {

        }

        return eventrecordlist;
    }

    public List<Event> fetchEventsById(int id) throws SQLException {
        List<Event> positionlist = new ArrayList<>();
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select * from event where eid= " + id + ";");

            rs = ps.executeQuery();

            while (rs.next()) {
                positionlist.add(new Event(rs.getInt("eid"), rs.getString("ename"), rs.getString("edescription"), rs.getString("startdate"), rs.getString("enddate")));

            }

        } catch (Exception e) {

        }

        return positionlist;
    }

    public List<Company> fetchSMTPServerConfig() throws SQLException {
        List<Company> config = new ArrayList<>();
        Company comp = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select * from server;");

            rs = ps.executeQuery();

            while (rs.next()) {
                comp = new Company(rs.getString("id"), rs.getString("host"), rs.getString("port"), rs.getString("username"), rs.getString("password"), "true", "true");
                config.add(comp);
            }

        } catch (Exception e) {

        }

        return config;
    }

    public String NewSMSLog(SMS_LOG ev) throws SQLException {

        String resp = null;
        try {

            String SQL = "INSERT INTO sms_log (name, mobile, message, "
                    + "status, sms_type) VALUES(?,?,?,?,?)";
            if (con != null) {
                PreparedStatement pst = con.prepareStatement(SQL);
                pst.setString(1, ev.getName());
                pst.setString(2, ev.getNumber());
                pst.setObject(3, ev.getMessage());
                pst.setObject(4, ev.getStatus());
                pst.setString(5, ev.getSmsType());
                pst.executeUpdate();
                resp = "Insert Operation Successful";
                pst.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resp;
    }

    public String NewVote(Vote ev) throws SQLException {

        String resp = null;
        try {

            String SQL = "INSERT INTO vote (memberid, seat_id, token) VALUES(?,?,?)";
            if (con != null) {
                PreparedStatement pst = con.prepareStatement(SQL);
                pst.setString(1, ev.getMemberId());
                pst.setString(2, ev.getSeatId());
                pst.setString(3, ev.getToken());
                pst.executeUpdate();
                resp = "Insert Operation Successful";
                if (resp.equals("Insert Operation Successful")) {
                    SQL = "UPDATE token SET is_used = ? Where token = ?; ";

                    pst = con.prepareStatement(SQL);
                    pst.setInt(1, 1);
                    pst.setString(2, ev.getToken());
                    pst.execute();
                }
                pst.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resp;
    }

    public String NewEmailLog(Email_Log ev) throws SQLException {

        String resp = null;
        try {

            String SQL = "INSERT INTO email_log (name, email, message, "
                    + "status, email_type) VALUES(?,?,?,?,?)";
            if (con != null) {
                PreparedStatement pst = con.prepareStatement(SQL);
                pst.setString(1, ev.getName());
                pst.setString(2, ev.getEmail());
                pst.setObject(3, ev.getMessage());
                pst.setObject(4, ev.getStatus());
                pst.setString(5, ev.getEmailType());
                pst.executeUpdate();
                resp = "Insert Operation Successful";
                pst.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resp;
    }

    public List<BirthdayInfoModel> fetchMembers() throws SQLException {
        List<BirthdayInfoModel> loginCred = new ArrayList<>();
        BirthdayInfoModel member = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;
            if (con != null) {
                ps = con.prepareStatement("SELECT FullName, mobile, email FROM member where EXTRACT(MONTH FROM dob)=EXTRACT(MONTH FROM current_date()) AND EXTRACT(DAY FROM dob)=EXTRACT(DAY FROM current_date());");

                rs = ps.executeQuery();

                while (rs.next()) {

                    member = new BirthdayInfoModel(rs.getString("FullName"), rs.getString("mobile"), rs.getString("email"));

                    loginCred.add(member);

                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());

        }

        return loginCred;
    }

    public List<Member> fetchAllMembers() throws SQLException {
        List<Member> loginCred = new ArrayList<>();
        Member member = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;
            if (con != null) {
                ps = con.prepareStatement("SELECT MemberID, FullName, mobile, email FROM member;");

                rs = ps.executeQuery();

                while (rs.next()) {

                    member = new Member(rs.getString("MemberID"), rs.getString("FullName"), rs.getString("mobile"), rs.getString("email"));

                    loginCred.add(member);

                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());

        }

        return loginCred;
    }

    public List<ElectionType> fetchElectionByBroadcastDate() throws SQLException {
        List<ElectionType> loginCred = new ArrayList<>();
        ElectionType member = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;
            if (con != null) {
                ps = con.prepareStatement("SELECT election_id FROM electiontype where EXTRACT(MONTH FROM tokenbroadcastdate)=EXTRACT(MONTH FROM current_date()) AND EXTRACT(DAY FROM tokenbroadcastdate)=EXTRACT(DAY FROM current_date());");

                rs = ps.executeQuery();

                while (rs.next()) {

                    member = new ElectionType(rs.getInt("election_id"));

                    loginCred.add(member);

                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());

        }

        return loginCred;
    }

    public String fetchSMTPServerChoice() throws SQLException {
        String res = null;
        try {

            PreparedStatement ps = null;
            ResultSet rs = null;

            ps = con.prepareStatement("select smtpconfigID from organization;");

            rs = ps.executeQuery();

            while (rs.next()) {
                res = rs.getString(1);
            }

        } catch (Exception e) {

        }

        return res;
    }

    public static String Email(String subject, String to, String emailmessage) {
        String msg = "Problem sending email contact support";
        DashboardModel db = new DashboardModel();
        try {
            Company conf = db.fetchSMTPServerConfig(db.fetchSMTPServerChoice());

            //Get the session object
            Properties props = System.getProperties();
            props.put("mail.smtp.host", conf.getHost());
            props.put("mail.smtp.port", conf.getPort());
            props.put("mail.smtp.auth", conf.getAuth());
            props.put("mail.smtp.starttls.enable", conf.getStarttls());
            //props.put("mail.smtp.ssl.trust", conf.getHost());

            Session session = Session.getInstance(props,
                    new javax.mail.Authenticator() {
                        @Override
                        protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                            return new javax.mail.PasswordAuthentication(conf.getUsername(), conf.getPassword());
                        }
                    });

            //Compose the message
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(conf.getUsername()));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);
            message.setContent(emailmessage, "text/html");

            //send the message
            Transport.send(message);

            msg = "Email sent successfully...";

        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

        return msg;
    }

    public static String removeFirstChar(String s) {
        return s.substring(1);
    }

    public static String send(String to, String message)
            throws Exception {
        HttpClient httpclient = new DefaultHttpClient();
        String responseBody = "MSG_NOT_SENT_GK";
        LoginModel lg = new LoginModel();
        Organization org = lg.fetchOrganizationDetails().get(0);
        String apiid = org.getSmsApiID();

        String url = "";
        String m = removeFirstChar(to);
        to = m;
        String eMessage = message;
        String username = "insonet";
        String password = "Admin@SMS1";
        try {
            if (apiid.equals("1")) {

                url = "http://sms.phalconghana.com/send/api?username=" + URLEncoder.encode(username, "UTF-8") + "&password=" + URLEncoder.encode(password, "UTF-8") + "&phone=" + URLEncoder.encode(to, "UTF-8") + "&msg=" + URLEncoder.encode(eMessage, "UTF-8") + "&senderid=" + org.getShortname();
            } else if (apiid.equals("2")) {
                url = "https://api.wirepick.com/httpsms/send?client=" + URLEncoder.encode(username, "UTF-8") + "&password=" + URLEncoder.encode(password, "UTF-8") + "&affiliate=999&phone=" + URLEncoder.encode(to, "UTF-8") + "&text=" + URLEncoder.encode(eMessage, "UTF-8") + "&from=" + org.getShortname();
            } else if (apiid.equals("3")) {
                url = "https://api.smsgh.com/v3/messages/send?From=" + URLEncoder.encode(org.getShortname(), "UTF-8") + "&To=" + URLEncoder.encode("+" + to, "UTF-8") + "&Content=" + URLEncoder.encode(eMessage, "UTF-8") + "&ClientId=czrbvarg&ClientSecret=spxjdnnn&RegisteredDelivery=true";
            }
            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            int responseCode = con.getResponseCode();
            System.out.println("Response Code : " + responseCode);
            BufferedReader in = new BufferedReader(
                    new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
            //print in String
            // System.out.println(response.toString());
            Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder()
                    .parse(new InputSource(new StringReader(response.toString())));
            NodeList errNodes = doc.getElementsByTagName("messages");
            if (errNodes.getLength() > 0) {
                Element err = (Element) errNodes.item(0);
//                System.out.println("raw_offset -" + err.getElementsByTagName("raw_offset").item(0).getTextContent());
//                System.out.println("dst_offset -" + err.getElementsByTagName("dst_offset").item(0).getTextContent());
//                System.out.println("time_zone_id -" + err.getElementsByTagName("time_zone_id").item(0).getTextContent());
                responseBody = err.getElementsByTagName("status").item(0).getTextContent();
                if (!responseBody.equals("ACT")) {
                    if (apiid.equals("2")) {
                        url = "https://smscloud.wirepick.com/httpsms/send?client=" + URLEncoder.encode(username, "UTF-8") + "&password=" + URLEncoder.encode(password, "UTF-8") + "&affiliate=999&phone=" + URLEncoder.encode(to, "UTF-8") + "&text=" + URLEncoder.encode(eMessage, "UTF-8") + "&from=" + org.getShortname();

                        obj = new URL(url);
                        con = (HttpURLConnection) obj.openConnection();
                        responseCode = con.getResponseCode();
                        System.out.println("Response Code : " + responseCode);
                        in = new BufferedReader(
                                new InputStreamReader(con.getInputStream()));

                        response = new StringBuilder();
                        while ((inputLine = in.readLine()) != null) {
                            response.append(inputLine);
                        }
                        in.close();
                        //print in String
                        // System.out.println(response.toString());
                        doc = DocumentBuilderFactory.newInstance().newDocumentBuilder()
                                .parse(new InputSource(new StringReader(response.toString())));
                        errNodes = doc.getElementsByTagName("messages");
                        if (errNodes.getLength() > 0) {
                            err = (Element) errNodes.item(0);
//                System.out.println("raw_offset -" + err.getElementsByTagName("raw_offset").item(0).getTextContent());
//                System.out.println("dst_offset -" + err.getElementsByTagName("dst_offset").item(0).getTextContent());
//                System.out.println("time_zone_id -" + err.getElementsByTagName("time_zone_id").item(0).getTextContent());
                            responseBody = err.getElementsByTagName("status").item(0).getTextContent();

                        }
                    }
                }
            } else {
                // success
            }
        } catch (Exception e) {
            System.out.println(e);
        }
//        URLConnection yc = client.openConnection();
//        InputStream stream = yc.getInputStream();
//        InputStreamReader reader = new InputStreamReader(stream);
//        BufferedReader in = new BufferedReader(reader);
//        String inputLine;
//        while ((inputLine = in.readLine()) != null) {
//            responseBody = responseBody + inputLine;
//
//        }
//
//        httpclient.getConnectionManager().shutdown();

//    }
//    catch (IOException ex
//
//    
//        )
//    {
//      ex.printStackTrace();
//    }
        return responseBody;
    }

}
