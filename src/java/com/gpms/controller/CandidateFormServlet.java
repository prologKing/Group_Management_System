/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.controller;

import com.gpms.dbconnection.DbUtils;
import com.gpms.pojo.Candidate;
import com.gpms.pojo.DashboardModel;
import com.gpms.pojo.Member;
import com.gpms.pojo.User;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author Developer
 */
@WebServlet(name = "CandidateFormServlet", urlPatterns = {"/CandidateFormServlet"})
public class CandidateFormServlet extends HttpServlet {

    String image_in_file;                      // to get string from index.html page's request
    private static final long serialVersionUID = 1L; // uid for servlet
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
     * @throws org.apache.commons.fileupload.FileUploadException
     * @throws org.apache.tomcat.util.http.fileupload.FileUploadException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, FileUploadException, Exception, IllegalStateException, NullPointerException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
           DashboardModel dbmm = new DashboardModel();
            String mid = request.getParameter("member_id");
            String seatid = request.getParameter("list");
            String resvalue = "";
            String manifesto = request.getParameter("manifesto");
            Candidate candidate = new Candidate(mid, seatid, manifesto);
            String candidateid = dbmm.CreateCandidateRecord(candidate);
                String id = request.getParameter("id");
                String username = request.getParameter("username");
                image_in_file = request.getParameter("image_file");
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
                    Member u = null;
                    User b = null;
                    if (id != null) {
                        u = (Member) request.getSession().getAttribute("memberprofile");

                        u.setImageurl(name + "." + extension);
                        DashboardModel dbm = new DashboardModel();
                        System.out.println("Member imageurl record in db about to be updated");
                        String res = dbm.updateMemberImageurl(u);
//                            ImageIO.write(resized, formatName, output);
                        if ("Update Successful".equals(res)) {
                            System.out.println("record updated successfully");
                            request.getSession().setAttribute("memberprofile", u);
                            System.out.println("image uploaded successfully");
                        }
                    }

                    if (username != null) {
                        b = (User) request.getSession().getAttribute("userprofile");

                        b.setImageurl(name + "." + extension);
                        DashboardModel dbm = new DashboardModel();
                        System.out.println("User imageurl record in db about to be updated");
                        String res = dbm.updateUserImageurl(b);
//                            ImageIO.write(resized, formatName, output);
                        if ("Update Successful".equals(res)) {
                            System.out.println("record updated successfully");
                            request.getSession().setAttribute("userprofile", b);
                            System.out.println("image uploaded successfully");
                        }

                    }
                    if (id != null) {
                        RequestDispatcher rr = request.getRequestDispatcher(response.encodeURL("memberdetails.jsp?area=member-details&id=" + id));
                        rr.forward(request, response);
                    }
                    if (username != null) {
                        RequestDispatcher rr = request.getRequestDispatcher(response.encodeURL("user.jsp?username=" + username));
                        rr.forward(request, response);
                    }
                } else {
                    String file_name = null;
                    System.out.println("Access to the image upload function successful");
                    if (ServletFileUpload.isMultipartContent(request)) {

                    }
                    FileItemFactory itemFactory = new DiskFileItemFactory();
                    ServletFileUpload upload = new ServletFileUpload(itemFactory);
                    List<FileItem> items = upload.parseRequest(request);
                    Iterator<FileItem> it = items.iterator();
                    if (!it.hasNext()) {
                        return;
                    }
                    while (it.hasNext()) {

                        FileItem fileitem = it.next();
                        boolean value = Arrays.asList("png", "gif", "jpg", "jpeg", "tif", "tiff", "bmp")
                                .contains(org.apache.commons.io.FilenameUtils.getExtension(fileitem.getName().toLowerCase()));

                        if (value) {
                            boolean isformfield = fileitem.isFormField();
                            if (isformfield) {
                                if (file_name == null) {
                                    if (fileitem.getName().equals(file_name)) {

                                        file_name = fileitem.getString();
                                    }
                                    System.out.println("File name not found");
                                }
                            } else {
                                response.setHeader("msg", "");

                                if (fileitem.getSize() > 0) {
                                    System.out.println("Image being process for upload operation");
                                    String path = getServletContext().getRealPath("/");

                                    String url = path + "assets/img/profilepic/" + fileitem.getName();

                                    String formatName = url.substring(url.lastIndexOf(".") + 1);

                                    File input = new File(url);
                                    fileitem.write(input);
                                    String filename = UUID.randomUUID().toString();
                                    String newFilePath = input.getAbsolutePath().replace(input.getName(), "") + filename + "." + formatName;
                                    File newFile = new File(newFilePath);
                                    FileUtils.moveFile(input, newFile);

//                             BufferedImage image = ImageIO.read(input);
                                    // BufferedImage resized = ImageResizer.resize(image, 400, 400);
                                    System.out.println("Image about to be cropped to a specific size");
                                    Thumbnails.of(newFilePath)
                                            .size(400, 400)
                                            .toFile(newFilePath);
                                    String res = dbmm.updateCandidatemageurl(Integer.parseInt(candidateid), filename + "." + formatName);

//                            ImageIO.write(resized, formatName, output);
                                if ("Update Successful".equals(res)) {
                                    resvalue = "a";

                                } else {
                                    resvalue = "b";
                                }
                                break;
                            }
                        }
                    } else {

                        response.setHeader("msg", "Please upload a valid image!");
                        break;
                    }

                }
                RequestDispatcher rr = request.getRequestDispatcher(response.encodeURL("board.jsp?resp=" + resvalue));
                rr.forward(request, response);
                }
           
        }
    }

    public static byte[] decodeImage(String imageDataString) {
        return Base64.decodeBase64(imageDataString);
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
        } catch (FileUploadException ex) {
            Logger.getLogger(CandidateFormServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(CandidateFormServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (FileUploadException ex) {
            Logger.getLogger(CandidateFormServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(CandidateFormServlet.class.getName()).log(Level.SEVERE, null, ex);
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
