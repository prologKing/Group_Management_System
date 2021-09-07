/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.pojo;

import com.gpms.dbconnection.DBConnection;
import static com.gpms.pojo.DashboardModel.Email;
import static com.gpms.pojo.DashboardModel.removeFirstChar;
import static com.gpms.pojo.DashboardModel.send;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 *
 * @author Developer
 */
public class BirthdayJob implements Job {

    public void execute(JobExecutionContext context)
            throws JobExecutionException {
        try {
            if (DBConnection.getConnection() != null) {

                BirthdayMessageSender();

            }
        } catch (SQLException ex) {
            Logger.getLogger(BirthdayJob.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(BirthdayJob.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public static void BirthdayMessageSender() {
        try {

            DashboardModel db = new DashboardModel();
            LoginModel lg = new LoginModel();
            String message = "";
            String emessage = "";
            BirthdayInfoModel bim = new BirthdayInfoModel();
            String minutes = db.fetchMessageBroadcastTime(5).getSend_minute();
            String hour = db.fetchMessageBroadcastTime(5).getSend_hour();

            Date date = new Date();   // given date
            Calendar calendar = GregorianCalendar.getInstance(); // creates a new calendar instance
            calendar.setTime(date);   // assigns calendar to given date 
            int ct_hour = calendar.get(Calendar.HOUR_OF_DAY);
            String current_hour = String.format("%02d", ct_hour);// gets hour in 24h format
            int ct_minutes = calendar.get(Calendar.MINUTE);
            String current_minutes = String.format("%02d", ct_minutes);
            Organization organ = (Organization) lg.fetchOrganizationDetails().get(0);
            List<String> mobileList = new ArrayList();
            mobileList.add(organ.getPhone_no1());
            mobileList.add(organ.getPhone_no2());
            mobileList.add(organ.getPhone_no3());

            //System.out.println(current_hour+":"+current_minutes);// gets hour in 12h format
            if (current_hour.equals(db.fetchMessageBroadcastTime(7).getSend_hour()) && current_minutes.equals(db.fetchMessageBroadcastTime(7).getSend_minute())) {

                List<BirthdayInfoModel> loginCred = db.fetchMembersWithTheirAlias();
                int j = 0;
                while (j < loginCred.size()) {

                    bim = (BirthdayInfoModel) loginCred.get(j);
                    message = db.birthdayMessageAlerttoAdminFormatter(db.getMessage("7"), bim);

                    if (!message.equals("") || message != null) {
                        int x = 0;
                        while(x < mobileList.size()){
                        String resp = send(mobileList.get(x), message);
                        

                        if (!resp.equals("MSG_NOT_SENT_GK")) {
                            db.NewSMSLog(new SMS_LOG("Admin", mobileList.get(x), message, "SUCCESS","", "7"));
                            
                        }else {
                            db.NewSMSLog(new SMS_LOG("Admin", mobileList.get(x), message, "FAILED","", "7"));
                        }
                        x++;
                    }
                    }

                    message = "";

                    j++;
                }
            }
            if (current_hour.equals(db.fetchMessageBroadcastTime(10).getSend_hour()) && current_minutes.equals(db.fetchMessageBroadcastTime(10).getSend_minute())) {

                List<Member> loginCred = db.fetchAllMembers();
                List<ElectionType> etype = db.fetchElectionByBroadcastDate();
                if (!etype.isEmpty()) {
                    int c = 0;
                    while (c < etype.size()) {
                        db.SendTokenToMember(loginCred, String.valueOf(etype.get(c).getId()));
                        c++;

                    }
                }
            }
            if (current_hour.equals(hour) && current_minutes.equals(minutes)) {
                List<BirthdayInfoModel> loginCred = db.fetchMembers();
                int j = 0;
                while (j < loginCred.size()) {
                    bim = (BirthdayInfoModel) loginCred.get(j);
                    message = db.birthdayMessageFormatter(db.getMessage("5"), bim);
                    if (!message.equals("") || message != null) {
                        String resp = send(bim.getMobile(), message);
                        if (!resp.equals("MSG_NOT_SENT_GK")) {
                            db.NewSMSLog(new SMS_LOG(bim.getFullname(), bim.getMobile(), message, "SUCCESS","", "5"));
                        } else {
                            db.NewSMSLog(new SMS_LOG(bim.getFullname(), bim.getMobile(), message, "FAILED","", "5"));
                        }

                    }
                    emessage = db.birthdayMessageFormatter(db.getMessage("6"), bim);
                    if (!emessage.equals("") || emessage != null) {
                        String resp = Email("Happy BirthDay " + bim.getFullname(), bim.getEmail(), emessage);
                        if (!resp.equals("Problem sending email contact support")) {
                            db.NewEmailLog(new Email_Log(bim.getFullname(), bim.getEmail(), message, "SUCCESS","", "6"));
                        } else {
                            db.NewEmailLog(new Email_Log(bim.getFullname(), bim.getEmail(), message, "FAILED", "", "6"));
                        }
                    }
                    message = "";
                    emessage = "";
                    j++;
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());

        }

    }

}
