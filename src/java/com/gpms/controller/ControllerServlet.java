/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.controller;

import com.gpms.pojo.DashboardModel;
import com.gpms.pojo.EventModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import com.gpms.pojo.LoginModel;
import com.gpms.pojo.User;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Developer
 */
public class ControllerServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, IllegalStateException, NullPointerException, SQLException {
        //response.setContentType("text/html;charset=UTF-8");
        String res = request.getParameter("v");
        String eidd = request.getParameter("elect_id");
        String elid = request.getParameter("elid");
        String token = request.getParameter("token");
        RequestDispatcher rr = null;
        String resp = request.getParameter("resp");
        String eid = request.getParameter("eid");
        String svalue = request.getParameter("svalue");
        String opt = request.getParameter("opt");
        String sinput = request.getParameter("sinput");
        if (svalue != null && opt != null) {
                String condition = "";
                if (opt.equals("M")) {
                    condition = "WHERE MemberID ='" + svalue + "'";
                }
                if (opt.equals("P")) {
                    condition = "WHERE Mobile ='" + svalue + "'";
                }
                if (opt.equals("A")) {
                    condition = "WHERE alias ='" + svalue + "'";
                }
                LoginModel lmodel = new LoginModel();
                String reply = lmodel.MemberFullNameFetcher(condition);
                PrintWriter out = response.getWriter();
                out.print(reply);

            }
          else if ("election_portal".equals(res)) {
            rr = request.getRequestDispatcher(response.encodeURL("polling.jsp"));
            rr.forward(request, response);
        } //System.out.println("");   
           else if ("election_result".equals(res) && eid == null) {
            rr = request.getRequestDispatcher(response.encodeURL("electionresults.jsp"));
            rr.forward(request, response);
        } //System.out.println("");   
           else if ("election_result".equals(res) && eid != null) {
            rr = request.getRequestDispatcher(response.encodeURL("electionresult.jsp"));
            rr.forward(request, response);
        } //System.out.println("");   
        else if (token != null && elid != null) {
                LoginModel lmodel = new LoginModel();
                String reply = lmodel.tokenFetcher(token, elid);
                PrintWriter out = response.getWriter();
                out.print(reply);

            }
        else if (eid != null) {
                LoginModel lmodel = new LoginModel();
                String reply = lmodel.getSeatsAvailableUnderElectionType(eid);
                PrintWriter out = response.getWriter();
                out.print(reply);

            }
        else if (sinput != null && opt != null) {
                String condition = "";
                if (opt.equals("M")) {
                    condition = "WHERE MemberID ='" + sinput + "'";
                }
                if (opt.equals("P")) {
                    condition = "WHERE Mobile ='" + sinput + "'";
                }
                if (opt.equals("A")) {
                    condition = "WHERE alias ='" + sinput + "'";
                }
                LoginModel lmodel = new LoginModel();
                String reply = lmodel.MemberIDFetcher(condition);
                PrintWriter out = response.getWriter();
                out.print(reply);

            }
       
        else if ("register".equals(res)) {
            rr = request.getRequestDispatcher(response.encodeURL("register.jsp"));
            rr.forward(request, response);
        }
        else if ("candidate_form".equals(res)) {
            rr = request.getRequestDispatcher(response.encodeURL("candidateform.jsp"));
            rr.forward(request, response);
        } //System.out.println("");    
         else if ("polling_station".equals(res)) {
            rr = request.getRequestDispatcher(response.encodeURL("pollingstation.jsp?eid="+eidd));
            rr.forward(request, response);
        } //System.out.println("");    
       
        else if ("InSession".equals((String) request.getSession().getAttribute("session"))) {

            /* TODO output your page here. You may use following sample code. */
            String area = request.getParameter("area");
            String id = request.getParameter("id");
            String uname = request.getParameter("uname");
            String username = request.getParameter("username");
            String msg = request.getParameter("msg");
            String msgtime = request.getParameter("msgtime");
            String mssgtime = request.getParameter("mssgtime");
            String memberid = request.getParameter("memberid");
            String mid = request.getParameter("mid");
            String middd = request.getParameter("middd");
            
            String searchvalue = request.getParameter("searchvalue");
            String options = request.getParameter("options");
            String searchinput = request.getParameter("searchinput");
            String option = request.getParameter("option");
            User u = (User) request.getSession().getAttribute("myProfile");

            if (uname != null) {
                LoginModel lmodel = new LoginModel();
                String reply = lmodel.usernameValidation(uname);
                PrintWriter out = response.getWriter();
                out.print(reply);

            }
            if (mid != null) {
                LoginModel lmodel = new LoginModel();
                String reply = lmodel.getUnsubscribedEvents(mid);
                PrintWriter out = response.getWriter();
                out.print(reply);

            }
            
            if(middd != null){
            LoginModel lmodel = new LoginModel();
                String reply = lmodel.getUnBenefittedEvents(middd);
                PrintWriter out = response.getWriter();
                out.print(reply);
            }
             
            if (memberid != null) {
                LoginModel lmodel = new LoginModel();
                String reply = lmodel.MemberFullNameFetch(memberid);
                PrintWriter out = response.getWriter();
                out.print(reply);

            }
            if (msg != null) {
                LoginModel lmodel = new LoginModel();
                String reply = lmodel.MessageFetch(msg);
                PrintWriter out = response.getWriter();
                out.print(reply);

            }
            if (searchvalue != null && options != null) {
                String condition = "";
                if (options.equals("M")) {
                    condition = "WHERE MemberID ='" + searchvalue + "'";
                }
                if (options.equals("P")) {
                    condition = "WHERE Mobile ='" + searchvalue + "'";
                }
                if (options.equals("A")) {
                    condition = "WHERE alias ='" + searchvalue + "'";
                }
                LoginModel lmodel = new LoginModel();
                String reply = lmodel.MemberFullNameFetcher(condition);
                PrintWriter out = response.getWriter();
                out.print(reply);

            }
            if (searchinput != null && option != null) {
                String condition = "";
                if (option.equals("M")) {
                    condition = "WHERE MemberID ='" + searchinput + "'";
                }
                if (option.equals("P")) {
                    condition = "WHERE Mobile ='" + searchinput + "'";
                }
                if (option.equals("A")) {
                    condition = "WHERE alias ='" + searchinput + "'";
                }
                LoginModel lmodel = new LoginModel();
                String reply = lmodel.MemberIDFetcher(condition);
                PrintWriter out = response.getWriter();
                out.print(reply);

            }
            if (msgtime != null) {
                LoginModel lmodel = new LoginModel();
                String reply = lmodel.MessageTimeFetch(msgtime);
                PrintWriter out = response.getWriter();
                out.print(reply);

            }
            if (mssgtime != null) {
                LoginModel lmodel = new LoginModel();
                String reply = lmodel.MessageTimeFetch(mssgtime);
                PrintWriter out = response.getWriter();
                out.print(reply);

            }
            if (area != null) {
                if ("dashboard".equals(area)) {
                    rr = request.getRequestDispatcher(response.encodeURL("index.jsp"));
                }
                if ("member-details".equals(area)) {

                    rr = request.getRequestDispatcher(response.encodeURL("memberdetails.jsp?id=" + id));

                }
                if ("election-details".equals(area)) {

                    rr = request.getRequestDispatcher(response.encodeURL("electiondetails.jsp?id=" + id));

                }

                if ("user-details".equals(area)) {

                    rr = request.getRequestDispatcher(response.encodeURL("user.jsp?username=" + username));

                }
                if ("user-profile".equals(area)) {
//                if(u.getRole().equals("3")){
//                rr = request.getRequestDispatcher(response.encodeURL("usertable.jsp"));
//                }else{
                    rr = request.getRequestDispatcher(response.encodeURL("userList.jsp"));

                }
                if ("member-management".equals(area)) {
//                 if(u.getRole().equals("3")){
//                rr = request.getRequestDispatcher(response.encodeURL("member.jsp"));
//                }else{
                    rr = request.getRequestDispatcher(response.encodeURL("tables.jsp"));

                }
                if ("election".equals(area)) {
//                 if(u.getRole().equals("3")){
//                rr = request.getRequestDispatcher(response.encodeURL("member.jsp"));
//                }else{
                    rr = request.getRequestDispatcher(response.encodeURL("election.jsp"));

                }
                if ("org-profile".equals(area)) {
//                 if(u.getRole().equals("3")){
//                rr = request.getRequestDispatcher(response.encodeURL("orgprofile.jsp"));
//                }else{
                    rr = request.getRequestDispatcher(response.encodeURL("typography.jsp"));
//                 }

                }

                if ("events".equals(area)) {
//                 if(u.getRole().equals("3")){
//                 rr = request.getRequestDispatcher(response.encodeURL("event.jsp"));
//                }else{
                    rr = request.getRequestDispatcher(response.encodeURL("icons.jsp"));

                }
                if ("contributions".equals(area)) {
//                 if(u.getRole().equals("3")){
//                 rr = request.getRequestDispatcher(response.encodeURL("event.jsp"));
//                }else{
                    rr = request.getRequestDispatcher(response.encodeURL("contribution.jsp"));

                }
                if ("beneficiary".equals(area)) {
//                 if(u.getRole().equals("3")){
//                 rr = request.getRequestDispatcher(response.encodeURL("event.jsp"));
//                }else{
                    rr = request.getRequestDispatcher(response.encodeURL("beneficiary.jsp"));

                }
                if ("contributionreport".equals(area)) {

                    rr = request.getRequestDispatcher(response.encodeURL("contributionreport.jsp"));

                }
                if ("eventreport".equals(area)) {
//                 if(u.getRole().equals("3")){
//                 rr = request.getRequestDispatcher(response.encodeURL("event.jsp"));
//                }else{
                    rr = request.getRequestDispatcher(response.encodeURL("eventreport.jsp"));

                }
                if ("beneficiaryreport".equals(area)) {
//                 if(u.getRole().equals("3")){
//                 rr = request.getRequestDispatcher(response.encodeURL("event.jsp"));
//                }else{
                    rr = request.getRequestDispatcher(response.encodeURL("beneficiaryreport.jsp"));

                }
                if ("emailreport".equals(area)) {
//                 if(u.getRole().equals("3")){
//                 rr = request.getRequestDispatcher(response.encodeURL("event.jsp"));
//                }else{
                    rr = request.getRequestDispatcher(response.encodeURL("emailreport.jsp"));

                }
                if ("memberlisting".equals(area)) {

                    rr = request.getRequestDispatcher(response.encodeURL("memberlistingreport.jsp"));

                }
                if ("membersummary".equals(area)) {

                    rr = request.getRequestDispatcher(response.encodeURL("membersummaryreport.jsp"));

                }
                if ("bulksms".equals(area)) {
                    rr = request.getRequestDispatcher(response.encodeURL("bulkSMS.jsp"));

                }
                if ("logout".equals(area)) {
                    rr = request.getRequestDispatcher(response.encodeURL("map.jsp"));

                }
                if ("config".equals(area)) {
//                 if(!u.getRole().equals("3")){
                    rr = request.getRequestDispatcher(response.encodeURL("configuration.jsp"));

                }

                rr.forward(request, response);
            }
        } else {
            response.addHeader("message", "You have been logged out!");
            response.sendRedirect("./");

        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (IllegalStateException ex) {
            Logger.getLogger(ControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NullPointerException ex) {
            Logger.getLogger(ControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (IllegalStateException ex) {
            Logger.getLogger(ControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NullPointerException ex) {
            Logger.getLogger(ControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
