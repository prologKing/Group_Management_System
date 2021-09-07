/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.controller;

import com.gpms.pojo.DashboardModel;
import com.gpms.pojo.ImageResizer;
import com.gpms.pojo.Member;
import com.gpms.pojo.User;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.File;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.servlet.ServletRequestContext;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

/**
 *
 * @author Developer
 */
@MultipartConfig
@WebServlet(name = "ProfileUpdateServlet", urlPatterns = {"/update"})
public class ProfileUpdateServlet extends HttpServlet {

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
            if ("InSession".equals((String)request.getSession().getAttribute("session"))) {
                 String username = request.getParameter("username");
            /* TODO output your page here. You may use following sample code. */
            String file_name = null;
           
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
                        }
                    } else {
                        response.setHeader("msg", "");

                        if (fileitem.getSize() > 0) {

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
                            Thumbnails.of(newFilePath)
                                    .size(400, 400)
                                    .toFile(newFilePath);
                            User u = (User)request.getSession().getAttribute("userprofile");
                            u.setImageurl(filename + "." + formatName);
                            DashboardModel dbm = new DashboardModel();
                          
                            String res = dbm.updateUserImageurl(u);
//                            ImageIO.write(resized, formatName, output);
                        if( "Update Successful".equals(res)){
                           request.getSession().setAttribute("userprofile", u);
                           
                        }
                            break;
                        }
                    }
                } else {

                    response.setHeader("msg", "Please upload a valid image!");
                    break;
                }

            }
            RequestDispatcher rr = request.getRequestDispatcher(response.encodeURL("user.jsp?username="+username));
            rr.forward(request, response);
} else {
  response.addHeader("message", "You have been logged out!");
  response.sendRedirect("./");   
          

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
        } catch (FileUploadException ex) {
            Logger.getLogger(ProfileUpdateServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(ProfileUpdateServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ProfileUpdateServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(ProfileUpdateServlet.class.getName()).log(Level.SEVERE, null, ex);
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
