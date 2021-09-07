<%-- 
    Document   : login
    Created on : Mar 11, 2019, 4:33:49 PM
    Author     : Developer
--%>

<%@page import = "com.gpms.pojo.*, java.util.*, java.text.SimpleDateFormat, org.apache.commons.lang3.StringUtils, java.time.LocalDate, java.time.format.DateTimeFormatter" contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Login V4</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->	
        <link rel="icon" type="image/png" href="assets/img/icons/favicon.ico"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="assets/vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="assets/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="assets/fonts/iconic/css/material-design-iconic-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="assets/vendor/animate/animate.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="assets/vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="assets/vendor/animsition/css/animsition.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="assets/vendor/select2/select2.min.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="assets/vendor/daterangepicker/daterangepicker.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="assets/css/util.css">
        <link rel="stylesheet" type="text/css" href="assets/css/main.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
        <!-- CSS Files -->
        <link href="assets/css/material-dashboard.css?v=2.1.1" rel="stylesheet" />
        <!-- CSS Just for demo purpose, don't include it in your project -->
        <link href="assets/demo/demo.css" rel="stylesheet" />
        <!--===============================================================================================-->
    </head>
    <body>
        <%
            String error = "";
            String username = "";
            String password = "";
            String organization_name = "";
            String res = "";
            
            if(request.getParameter("addmember") != null){
        Member newUser = new Member();
            DashboardModel dashboard = new DashboardModel();
            String lastMemberId = dashboard.fetchLastInsertedMemberId();
             String variable = lastMemberId;
             int num = Integer.parseInt(variable) + 1;
             String padded = String.format("%04d" , num);
             String newMemberId = padded;
            
           newUser.setMemberId(newMemberId);   
         String fullname = request.getParameter("fullname");
        
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
         newUser.setKids(Integer.parseInt(kids)); 
         String occupation = request.getParameter("occupation");
         
          newUser.setOccupation(occupation); 
         String address = request.getParameter("address");
         newUser.setAddress(address); 
          String aboutme = request.getParameter("aboutme");
         newUser.setAboutMe(aboutme); 
          res = dashboard.CreateNewMemberRecord( newUser, "Admin");
          if("Insert Operation Successful".equals(res)){
           res="Member Registration Successful...";   
          }
          if(!"".equals(res)){
        %>
        <script>
            window.onload = function () {
                alert("<%=res%>");
            };

        </script>
        <%}
         
  }
            
            
     Organization orgs = null;
     try{
         LoginModel loginCred = new LoginModel();
     
      orgs = (Organization)loginCred.fetchOrganizationDetails().get(0);
      organization_name = orgs.getName();
     }catch(Exception e){
  out.println(e);
 }
             
     if(response.getHeader("message") != null ){
        error = response.getHeader("message");
     }
           
            
     if(request.getParameter("login") != null){
     username = request.getParameter("username");
     //out.print(username);
     password = request.getParameter("pass");
           
          
            
 try{
        
  LoginModel loginCred = new LoginModel();
  User user = null;
  List userlist = loginCred.fetchUsers();
         
        
      
         int i = 0;
         while (i < userlist.size()) {
                 user = (User)userlist.get(i);
                 if(user.getUsername() != null && user.getPassword() != null){
                 if((user.getUsername().equals(username)) && (user.getPassword().equals(password))){
                     if (session.getAttribute("session") == null) {
                         session = request.getSession();
                         Role role = loginCred.fetchRolePrivilege(Integer.parseInt(user.getRole()));
                         session.setAttribute("privilege", role.getPrivilege());
                         session.setAttribute("myProfile", user);
                         session.setAttribute("OrgProfile", orgs);
                         session.setAttribute("OrgName", orgs.getName());
                         session.setAttribute("username", username);
                         session.setAttribute("session", "InSession");
                         response.sendRedirect("./Nav?area=dashboard");        
                          break;
                     }
                     else{
                         if(((String)session.getAttribute("username")).equals(username)){
                     error = "You have already been logged in! Click <a href='./Nav?area=dashboard'>here</a>";
                     break;
                         }else{
                         error = (String)session.getAttribute("username") +" is currectly logged in!";
                         break;
                         }
                     }
                            
                                
                           
                 }
                 else{
                        
                 if(i == userlist.size()-1){
                 error = "Invalid Credentials";
                 }
                 }
                       
                 }else{
                       
                 if(i == userlist.size() - 1){
                 error = "Invalid Credentials";
                 }
                 }
                 i++;
         }
       
       	
 }catch(Exception e){
  out.println(e);
 }
     }else{
            
      try{
     if((String)session.getAttribute("session") == "InSession"){
 response.sendRedirect("./Nav?area=dashboard");
      }
     }catch(Exception e){
  out.println(e);
 }
     }
        %>

        <div class="limiter">
            <div class="container-login100" style="background-image: url('assets/img/bg-01.jpg');">
                <div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
                    <form class="login100-form validate-form" action = "" method = "post">
                        <div class="login100-form-avatar">
                            <img src="assets/img/profilepic/<%=orgs.getLogo()%>" alt="AVATAR" />
                        </div>
                        <span class="login100-form-title p-b-40">
                            <%=organization_name%>
                        </span>

                        <div class="wrap-input100 validate-input m-b-23" data-validate = "Username is reauired">
                            <span class="label-input100">Username</span>
                            <input class="input100" type="text" name="username" placeholder="Type your username">
                            <span class="focus-input100" data-symbol="&#xf206;"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Password is required">
                            <span class="label-input100">Password</span>
                            <input class="input100" type="password" name="pass" placeholder="Type your password">
                            <span class="focus-input100" data-symbol="&#xf190;"></span>

                        </div>

                        <div class="text-right p-t-8 p-b-31">
                            <%=error%>
                        </div>

                        <div class="container-login100-form-btn">
                            <div class="wrap-login100-form-btn">
                                <div class="login100-form-bgbtn"></div>
                                <button class="login100-form-btn" name="login">
                                    Login
                                </button>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>


        <div id="dropDownSelect1"></div>

        <!--===============================================================================================-->
        <script src="assets/vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="assets/vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
        <script src="assets/vendor/bootstrap/js/popper.js"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="assets/vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="assets/vendor/daterangepicker/moment.min.js"></script>
        <script src="assets/vendor/daterangepicker/daterangepicker.js"></script>
        <!--===============================================================================================-->
        <script src="assets/vendor/countdowntime/countdowntime.js"></script>
        <!--===============================================================================================-->
        <!--   Core JS Files   -->
        <script src="assets/js/core/jquery.min.js"></script>
        <script src="assets/js/core/popper.min.js"></script>
        <script src="assets/js/core/bootstrap-material-design.min.js"></script>
        <script src="assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
        <!-- Plugin for the momentJs  -->
        <script src="assets/js/plugins/moment.min.js"></script>
        <!--  Plugin for Sweet Alert -->
        <script src="assets/js/plugins/sweetalert2.js"></script>
        <!-- Forms Validations Plugin -->
        <script src="assets/js/plugins/jquery.validate.min.js"></script>
        <!-- Plugin for the Wizard, full documentation here: https://github.com/VinceG/twitter-bootstrap-wizard -->
        <script src="assets/js/plugins/jquery.bootstrap-wizard.js"></script>
        <!--	Plugin for Select, full documentation here: http://silviomoreto.github.io/bootstrap-select -->
        <script src="assets/js/plugins/bootstrap-selectpicker.js"></script>
        <!--  Plugin for the DateTimePicker, full documentation here: https://eonasdan.github.io/bootstrap-datetimepicker/ -->
        <script src="assets/js/plugins/bootstrap-datetimepicker.min.js"></script>
        <!--  DataTables.net Plugin, full documentation here: https://datatables.net/  -->
        <script src="assets/js/plugins/jquery.dataTables.min.js"></script>
        <!--	Plugin for Tags, full documentation here: https://github.com/bootstrap-tagsinput/bootstrap-tagsinputs  -->
        <script src="assets/js/plugins/bootstrap-tagsinput.js"></script>
        <!-- Plugin for Fileupload, full documentation here: http://www.jasny.net/bootstrap/javascript/#fileinput -->
        <script src="assets/js/plugins/jasny-bootstrap.min.js"></script>
        <!--  Full Calendar Plugin, full documentation here: https://github.com/fullcalendar/fullcalendar    -->
        <script src="assets/js/plugins/fullcalendar.min.js"></script>
        <!-- Vector Map plugin, full documentation here: http://jvectormap.com/documentation/ -->
        <script src="assets/js/plugins/jquery-jvectormap.js"></script>
        <!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
        <script src="assets/js/plugins/nouislider.min.js"></script>
        <!-- Include a polyfill for ES6 Promises (optional) for IE11, UC Browser and Android browser support SweetAlert -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>
        <!-- Library for adding dinamically elements -->
        <script src="assets/js/plugins/arrive.min.js"></script>
        <!--  Google Maps Plugin    -->
        <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
        <!-- Chartist JS -->
        <script src="assets/js/plugins/chartist.min.js"></script>
        <!--  Notifications Plugin    -->
        <script src="assets/js/plugins/bootstrap-notify.js"></script>
        <!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
        <script src="assets/js/material-dashboard.js?v=2.1.1" type="text/javascript"></script>
        <!-- Material Dashboard DEMO methods, don't include it in your project! -->
        <script src="assets/demo/demo.js"></script>
        <script src="assets/js/main.js"></script>
        <div class="modal fade" id="register" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content" >
                    <form action="login.jsp" method="post" id="memberform">
                        <div class="modal-header">
                            <h4 class="modal-title">New Member Form</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>

                        </div>
                        <div class="modal-body">

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="bmd-label-floating">Full Name.</label>
                                    <input type="text" name ="fullname"  class="form-control" required>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="bmd-label-floating">Alias.</label>
                                            <input type="text" name ="alias"  class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="bmd-label-floating">Email.</label>
                                            <input type="email" name ="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,63}$" class="form-control" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Date Of Birth.</label>
                                    <input type="date" name ="dob"  placeholder="" class="form-control" required>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="bmd-label-floating">Gender</label>
                                            <select name ="gender"  class="form-control" required>
                                                <option  selected></option>
                                                <option value="M">Male</option>
                                                <option value="F">Female</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="bmd-label-floating">Marital Status</label>
                                            <select name ="maritalstatus"  class="form-control" required>
                                                <option  selected></option>
                                                <option value="Single">Single</option>
                                                <option value="Married">Married</option>
                                                <option value="Divorced">Divorced</option>
                                            </select>
                                        </div>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class ="col-md-4">
                                        <div class="form-group">
                                            <label class="bmd-label-floating"></label>
                                            <input type="hidden" id="country" name="country"/>
                                            <input  type="tel" pattern="\+[\d]+"  name ="phone" id="phone" placeholder="Phone. e.g. +2332..."  class="form-control" required />
                                        </div>

                                    </div>
                                    <div class ="col-md-4">
                                        <div class="form-group">
                                            <label class="bmd-label-floating">Alt. Phone No.</label>
                                            <input  type="tel"  name ="altphone" placeholder=""  class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="bmd-label-floating">Kids?</label>
                                            <input  type="number" min ="0" name ="kids" class="form-control" required />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="bmd-label-floating">Occupation.</label>
                                    <input type="text" name ="occupation"  class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Address.</label>
                                    <input type="text" name ="address"  class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">About me.</label>
                                    <input type="text" name ="aboutme"  class="form-control" required>
                                </div>



                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal"><i  class="material-icons">close</i></button>
                            <button type="submit" name="addmember" onclick="this.value = 'sending...';" value="addmember" class="btn btn-primary" ><i  class="material-icons">person_add</i></button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
        <script>
            $(document).ready(function () {
                var hash = window.location.hash;
                if (hash !== '') {
                    $(hash).modal();
                }

            });
        </script>

    </body>
    <!-- Use as a Vanilla JS plugin -->

</html>
