/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.controller;

import static com.gpms.controller.MemberAvatarUpdate.decodeImage;
import com.gpms.pojo.Candidate;
import com.gpms.pojo.DashboardModel;
import com.gpms.pojo.Member;
import com.gpms.pojo.User;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.format.DateTimeFormatter;
import java.time.LocalDate;
import java.text.SimpleDateFormat;

/**
 *
 * @author Developer
 */
@WebServlet(name = "MemberRegistrationServlet", urlPatterns = {"/Registration"})
public class MemberRegistrationServlet extends HttpServlet {

    String image_in_file;                      // to get string from index.html page's request
    private static final long serialVersionUID = 2L; // uid for servlet
    // static path to the folder
    String name = null;   // to store file name
    String fileType = null;     // to store file type
    String fileTypeandURL = null;  //to store file type and the base64 string
    String extension = null;    // to store extension of image
    String datetime = null;    //  to store date and time in miliseconds
    String image = null;      // to store actual encoded base64 string

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            RequestDispatcher rr = null;
            DashboardModel dbmm = new DashboardModel();
            String mid = request.getParameter("member_id");
            String eid = request.getParameter("eid");
            String seatid = request.getParameter("list");
            String candidateid = "";
            String resvalue = "";
            String resp = "";
            String respo = "";
            String res = "";
            String manifesto = request.getParameter("manifesto");
            Candidate candidate = new Candidate(mid, seatid, manifesto);
            candidate.setElectionid(eid);
            if(mid != null){
            candidateid = dbmm.CreateCandidateRecord(candidate);
            }
            image_in_file = request.getParameter("image_file");
            System.out.println("please copy this url: " + image_in_file);
            Member newUser = new Member();
            DashboardModel dashboard = new DashboardModel();
            String lastMemberId = dashboard.fetchLastInsertedMemberId();
            String variable = lastMemberId;
            int num = Integer.parseInt(variable) + 1;
            String padded = String.format("%04d", num);
            String newMemberId = padded;

            newUser.setMemberId(newMemberId);
            String fullname = request.getParameter("fullname");
            if(fullname != null){
            newUser.setFullName(fullname);
            String alias = request.getParameter("alias");
            newUser.setAlias(alias);
            String dob = request.getParameter("dob");
            DateTimeFormatter f = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate dateOfBirth = LocalDate.parse(dob, f);

            newUser.setDob(dateOfBirth.toString());
            String gender = request.getParameter("gender");

            newUser.setGender(gender);
            String maritalstatus = request.getParameter("maritalstatus");

            newUser.setMaritalStatus(maritalstatus);
            String phone = request.getParameter("phone");

            newUser.setMobile(phone);
            String altphone = request.getParameter("altphone");

            newUser.setAltphone(altphone);
            String email = request.getParameter("email");

            newUser.setEmail(email);
            String kids = request.getParameter("kids");
            if(kids.equals("") || kids == null){
            kids = "0";
            }
            newUser.setKids(Integer.parseInt(kids));
            String occupation = request.getParameter("occupation");

            newUser.setOccupation(occupation);
            String address = request.getParameter("address");
            newUser.setAddress(address);
            String aboutme = request.getParameter("aboutme");
            newUser.setAboutMe(aboutme);
            res = dashboard.CreateNewMemberRecord(newUser, "Admin");
            if ("Insert Operation Successful".equals(res)) {
                res = "a";
            } else {
                res = "b";
            }
            }
            if (image_in_file != null) {
                int i = image_in_file.indexOf(":");
                System.out.println("index of ':' :" + i);

                if (i > 0) {
                    fileTypeandURL = image_in_file.substring(i + 1);
                    System.out.println("fileType and image url" + fileTypeandURL);
                }

                //to get index of ; in encoded string
                int j = fileTypeandURL.indexOf(";");
                System.out.println("index of ';' :" + j);

                if (j > 0) {
                    fileType = fileTypeandURL.substring(0, j);
                    System.out.println("fileType: " + fileType);

                }

                // to get index of , in encoded string and get the image's substring from it
                int k = image_in_file.indexOf(",");
                System.out.println("index of ',' :" + k);

                if (k > 0) {
                    image = image_in_file.substring(k + 1);
                    System.out.println("image : " + image);

                }

                //checks file type and stores into extension
                if (fileType.equalsIgnoreCase("image/jpeg")) {
                    extension = "jpg";
                }
                if (fileType.equalsIgnoreCase("image/png")) {
                    extension = "png";
                }
                if (fileType.equalsIgnoreCase("image/gif")) {
                    extension = "gif";
                }

                // to decode the base64 image to byte array
                byte[] imageByteArray = decodeImage(image);

                // to get time into milliseconds
                Calendar calendar = Calendar.getInstance();
                long milis = calendar.getTimeInMillis();
                datetime = Long.toString(milis);
                name = datetime;

                // Write image byte array into file system
                String path = getServletContext().getRealPath("/");
                String url = path + "assets/img/profilepic/";
                FileOutputStream imageOutFile = new FileOutputStream(url + name + "." + extension);
                imageOutFile.write(imageByteArray);

                //file object close
                imageOutFile.close();

                //store image string to session so it can be displayed on CroppedImage JSP page
                // redirects on CroppedImage.jsp page.
                if (res != null) {

                    String imageurl = name + "." + extension;
                    DashboardModel dbm = new DashboardModel();
                    System.out.println("Member imageurl record in db about to be updated");
                    if(fullname != null){
                    resp = dbm.updateMemberImageurl(newMemberId, imageurl);
                    }
                    if(mid != null){
                    respo = dbmm.updateCandidatemageurl(Integer.parseInt(candidateid), imageurl);
                    }
                     if ("Update Successful".equals(respo)) {
                                    resvalue = "a";

                                } else {
                                    resvalue = "b";
                                }
//                            ImageIO.write(resized, formatName, output);
                    if ("Update Successful".equals(res)) {
                        System.out.println("record updated successfully");
                        System.out.println("image uploaded successfully");
                    }
                }
                if(fullname != null){
                rr = request.getRequestDispatcher(response.encodeURL("board.jsp?resp=" + res));
                rr.forward(request, response);
                }
               if(mid != null){
                rr = request.getRequestDispatcher(response.encodeURL("board.jsp?respo=" + resvalue));
                rr.forward(request, response);
                }

            }
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
        } catch (SQLException ex) {
            Logger.getLogger(MemberRegistrationServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(MemberRegistrationServlet.class.getName()).log(Level.SEVERE, null, ex);
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
