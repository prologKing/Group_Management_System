<%-- 
    Document   : user
    Created on : Mar 10, 2019, 10:00:56 PM
    Author     : Developer
--%>

<%@page import="com.gpms.pojo.*, java.util.*, java.text.SimpleDateFormat, java.time.LocalDate, java.time.format.DateTimeFormatter" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    
     User user = null;
    String myUpdatedProfile = null;
    String gend = null;
     String url = "";
     String li1 = "";
    String li2 = "";
    String li3 = "";
    String li4 = "";
    String li5 = "";
    String li6 = "";
    String li7 = "";
    String li8 = "";
    String li9 = "";
    String li10 = "";
     String privilege = (String)session.getAttribute("privilege");
     if(privilege.substring(0,1).equals("1")){
     li1="inline";
     }else{
     li1="none";
     }
      if(privilege.substring(1,2).equals("1")){
     li2="inline";
     }else{
     li2="none";
     }
       if(privilege.substring(2,3).equals("1")){
     li3="inline";
     }else{
     li3="none";
     }
        if(privilege.substring(3,4).equals("1")){
     li4="inline";
     }else{
     li4="none";
     }
         if(privilege.substring(4,5).equals("1")){
     li5="inline";
     }else{
     li5="none";
     }
      if(privilege.substring(5,6).equals("1")){
     li6="inline";
     }else{
     li6="none";
     }
      if(privilege.substring(6,7).equals("1")){
     li7="inline";
     }else{
     li7="none";
     }
     if(privilege.substring(7).equals("1")){
     li8="inline";
     }else{
     li8="none";
     }
      if(privilege.substring(5,6).equals("1") || privilege.substring(6,7).equals("1") || privilege.substring(7).equals("1")){
     li9="inline";
     }else{
     li9="none";
     }
    String usernam = request.getParameter("username");
    
   
    String orgname = (String)session.getAttribute("OrgName");
    
 try{
     LoginModel loginCred = new LoginModel();
       
            List userlist = loginCred.fetchIndividualUser(usernam);
            int j = 0;
             while (j < userlist.size()) {
            user = (User)userlist.get(j);
            session.setAttribute("userprofile", user);
           j++;
        }
             if(user.getImageurl() == null){
      url = "<img class='img' src='assets/img/profilepic/' alt='assets/img/profilepic/' />";
      }else{
        url = "<img class='img' src='assets/img/profilepic/"+user.getImageurl()+"' alt='assets/img/profilepic/"+user.getImageurl()+"' />";
      }
      gend = user.getGender();
      if(gend.equals('M')){
      gend = "Male";
      }else{
      gend = "Female";
      }
      if(request.getParameter("imageupload") != null){
         
         String upload = request.getParameter("upload");
         
         response.sendRedirect("./update?upload="+upload);   
      }
      if(request.getParameter("update") != null){
           User updatedUser = new User();
           DashboardModel dashboard = new DashboardModel();
          
          
            String username = request.getParameter("username");
             updatedUser.setUsername(username);
            String password = request.getParameter("password");
             updatedUser.setPassword(password);
            String email = request.getParameter("email");
            updatedUser.setEmail(email);
            String fname = request.getParameter("firstname");
            updatedUser.setFname(fname);
            String lname = request.getParameter("lastname");
            updatedUser.setLname(lname);
            String phone = request.getParameter("phone");
            updatedUser.setMobile(phone);
            updatedUser.setRole(user.getRole());
             updatedUser.setRole(user.getRole());

            String gender = request.getParameter("gender");
            updatedUser.setGender(gender);
          
            myUpdatedProfile = dashboard.updateUserRecord(updatedUser);
            if(myUpdatedProfile.equals("Update Successful")){
            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);
            user.setFname(fname);
            user.setLname(lname);
            user.setMobile(phone);
            user.setGender(gender);
            if(gender.equals("M")){
                gend = "Male";
                }else{
                gend = "Female";
                }
            }
      }
            if((String)session.getAttribute("session") != "InSession"){
        response.sendRedirect("./logout");
             }
            
            }catch(Exception e){
               
         out.println(e.getMessage());
        }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
 try{
    
        LoginModel loginCred = new LoginModel();
          
            List userlist = loginCred.fetchIndividualUser(usernam);
            int j = 0;
             while (j < userlist.size()) {
            user = (User)userlist.get(j);
            session.setAttribute("myProfile", user);
           j++;
        }
        if(request.getParameter("adduser") != null){
           DashboardModel dashboard = new DashboardModel(); 
           LoginModel lModel = new LoginModel();
            User newUser = new User();  
          String mid = request.getParameter("mid");
           String lastMemberId = lModel.MemberFullNameFetch( mid);
          if(mid != null && mid != ""){
             
         String uname = request.getParameter("uname");
          newUser.setUsername(uname); 
         String password1 = request.getParameter("password1");
         newUser.setPassword(password1); 
        // String res = lModel.updateMemberRecord(newUser);
          }else{
              String finame = request.getParameter("finame");
          newUser.setFname(finame); 
           String laname = request.getParameter("laname");
          newUser.setLname(laname); 
         String genderr = request.getParameter("genderr");
       
          newUser.setGender(genderr); 
         String mobilephone = request.getParameter("mobilephone");
        
          newUser.setMobile(mobilephone); 
         String uname = request.getParameter("uname");
         
          newUser.setUsername(uname); 
         String password1 = request.getParameter("password1");
       
          newUser.setPassword(password1);  
          String res = dashboard.CreateNewUserRecord(newUser);
          }
      }
     if(request.getParameter("uname") != null){
     
      LoginModel lmodel = new LoginModel();
      String reply = lmodel.usernameValidation(request.getParameter("uname"));
       user = (User)session.getAttribute("myProfile");
     }
      
      if(user.getImageurl() == null){
      url = "<img class='img' src='assets/img/profilepic/' alt='assets/img/profilepic/' />";
      }else{
        url = "<img class='img' src='assets/img/profilepic/"+user.getImageurl()+"' alt='assets/img/profilepic/"+user.getImageurl()+"' />";
      }
      gend = user.getGender();
      if(gend.equals('M')){
      gend = "Male";
      }else{
      gend = "Female";
      }
      if(request.getParameter("imageupload") != null){
         
         String upload = request.getParameter("upload");
         
         response.sendRedirect("./update?upload="+upload);   
      }
      if(request.getParameter("update") != null){
           User updatedUser = new User();
           DashboardModel dashboard = new DashboardModel();
          
          
            String username = request.getParameter("username");
             updatedUser.setUsername(username);
            String password = request.getParameter("password");
             updatedUser.setPassword(password);
            String email = request.getParameter("email");
            updatedUser.setEmail(email);
            String fname = request.getParameter("firstname");
            updatedUser.setFname(fname);
            String lname = request.getParameter("lastname");
            updatedUser.setLname(lname);
            String phone = request.getParameter("phone");
            updatedUser.setMobile(phone);
             updatedUser.setRole(user.getRole());

            String gender = request.getParameter("gender");
            updatedUser.setGender(gender);
          
            myUpdatedProfile = dashboard.updateUserRecord(updatedUser);
            if(myUpdatedProfile.equals("Update Successful")){
            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);
            user.setFname(fname);
            user.setLname(lname);
            user.setMobile(phone);
            user.setGender(gender);
            if(gender.equals("M")){
                gend = "Male";
                }else{
                gend = "Female";
                }
            }
            
           
            
      
      }
            if((String)session.getAttribute("session") != "InSession"){
        response.sendRedirect("./logout");
             }
            user = (User)session.getAttribute("myProfile");
            }catch(Exception e){
               
         out.println(e.getMessage());
        }


%>

<html lang="en">
    <head>
        <title>
            Material Dashboard by GPMS
        </title>

        <meta charset="utf-8" />

        <!--  <meta name="viewport" content="width=device-width, initial-scale=1">
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>-->
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" href="assets/img/favicon.png">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />


        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
        <!--     Fonts and icons     -->

        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">

        <!-- CSS Files -->
        <link href="assets/css/material-dashboard.css?v=2.1.1" rel="stylesheet" />
        <!-- CSS Just for demo purpose, don't include it in your project -->
        <link href="assets/demo/demo.css" rel="stylesheet" />
    </head>

    <body>
        <script>

            function checkExist(value) {
                var xmlhttp = new XMLHttpRequest();
                var username = value;
                if (username !== "") {
                    var url = "./Nav?uname=" + username;
                    xmlhttp.onreadystatechange = function () {
                        if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                            if (xmlhttp.responseText === "User already exists")
                                document.getElementById("isE").style.color = "red";
                            else
                                document.getElementById("isE").style.color = "green";
                            document.getElementById("isE").innerHTML = xmlhttp.responseText;
                            document.getElementById("hiddenvalue").value = document.getElementById("isE").innerHTML;
                        }

                    };
                    try {
                        xmlhttp.open("GET", url, true);
                        xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        xmlhttp.send();
                    } catch (e) {
                        alert("unable to connect to server");
                    }
                } else {
                    document.getElementById("isE").innerHTML = "";
                    document.getElementById("hiddenvalue").value = "";

                }
            }
            function fetchFullName(value) {
                var xmlhttp = new XMLHttpRequest();
                var username = value;
                if (username !== "") {
                    var url = "./Nav?memberid=" + username;
                    xmlhttp.onreadystatechange = function () {
                        if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                            if (xmlhttp.responseText !== "" && xmlhttp.responseText !== null) {
                                document.getElementById("fulname").style.display = "block";
                                document.getElementById("firstname").style.display = "none";
                                document.getElementById("lastname").style.display = "none";
                                document.getElementById("gendy").style.display = "none";
                                document.getElementById("mob").style.display = "none";
                                document.getElementById("fname").innerHTML = xmlhttp.responseText;
                            } else {
                                document.getElementById("fulname").style.display = "none";
                                document.getElementById("firstname").style.display = "block";
                                document.getElementById("lastname").style.display = "block";
                                document.getElementById("gendy").style.display = "block";
                                document.getElementById("mob").style.display = "inline";
                            }
                        }

                    };
                    try {
                        xmlhttp.open("GET", url, true);
                        xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        xmlhttp.send();
                    } catch (e) {
                        alert("unable to connect to server");
                    }
                } else {
                    document.getElementById("fname").innerHTML = "";
                    document.getElementById("fulname").style.display = "none";
                    document.getElementById("firstname").style.display = "block";
                    document.getElementById("lastname").style.display = "block";
                    document.getElementById("gendy").style.display = "block";
                    document.getElementById("mob").style.display = "inline";

                }
            }
            function checkPassword(value) {
                var x = document.forms["regF"]["password1"].value;
                var z = document.forms["regF"]["hiddenvalue"].value;
                var y = document.forms["regF"]["password2"].value;
                if (y === "") {
                    alert(z);

                } else {
                    if (x === y) {
                        document.forms["regF"]["adduser"].value = "adduser";
                    } else {
                        alert("Passwords do not match!");
                    }
                }
            }
            function validateMyForm(value) {
                var x = document.forms["regF"]["password1"].value;

                var y = document.forms["regF"]["password2"].value;
                if (x === y) {
                    document.forms['regF'].submit();
                    return true;
                } else {
                    return false;
                }




            }
        </script>
        <div class="container">

        </div>
            <div class="wrapper ">
                <div class="sidebar" data-color="purple" data-background-color="white" data-image="assets/img/sidebar-1.jpg">
                    <!--
                      Tip 1: You can change the color of the sidebar using: data-color="purple | azure | green | orange | danger"
              
                      Tip 2: you can also add an image using data-image tag
                    -->
                    <div class="logo" style=" padding: 10px;">
                    <span  class="login100-title logo-normal" style="display: block; text-align: center;">
                        <%=orgname%>
                    </span>
                </div>
                    <div class="sidebar-wrapper">
                       <ul class="nav">
                        <li class="nav-item">
                            <a class="nav-link" href="./Nav?area=dashboard">

                                <i class="material-icons">dashboard</i>
                                <p>Dashboard</p>
                            </a>
                        </li>

                        <li style="display: <%=li1%>;" class="nav-item ">
                            <a class="nav-link" href="./Nav?area=member-management">
                                <i class="material-icons">content_paste</i>
                                <p>Member Management</p>
                            </a>
                        </li>
                        <li style="display: <%=li2%>;" class="nav-item ">
                            <a class="nav-link" href="./Nav?area=events">
                                <i class="material-icons">event</i>
                                <p>Events</p>
                            </a>
                        </li>
                        
                        <li style="display: <%=li3%>;" class="nav-item ">
                            <a class="nav-link" href="./Nav?area=contributions">
                                <i class="material-icons">money</i>
                                <p>Contributions</p>
                            </a>
                        </li>
                        <li style="display: <%=li3%>;" class="nav-item">
                            <a class="nav-link" href="./Nav?area=beneficiary">
                                <i class="material-icons">people</i>
                                <p>Beneficiaries</p>
                            </a>
                        </li>
                        <li style="display: <%=li4%>;" class="nav-item ">
                            <a class="nav-link" href="./Nav?area=bulksms">
                                <i class="material-icons">library_books</i>
                                <p>Bulk SMS</p>
                            </a>
                        </li>
                        <li style="display: <%=li10%>;" class="nav-item ">
                            <a class="nav-link" href="./Nav?area=election">
                                <i class="material-icons">how_to_vote</i>
                                <p>Election</p>
                            </a>
                        </li>
                        
                        <li style="display: <%=li9%>;" class="nav-item active">
                            <a class="nav-link" data-toggle="dropdown" href="#">  <i class="material-icons">view_list</i><p>Preferences<span class="caret"></span></p> </a>
                            <ul class="dropdown-menu">
                                <li style="display: <%=li6%>;" class="nav-link active"><a href="./Nav?area=user-profile">
                                        <i class="material-icons">people</i>
                                        <p style="color:white;">User Management</p>
                                    </a></li>
                                <li style="display: <%=li7%>;"> <a class="nav-link" href="./Nav?area=org-profile">
                                        <i class="material-icons">location_city</i>
                                        <p>Organization Profile</p>
                                    </a></li>
                               <li style="display: <%=li8%>;"><a class="nav-link" href="./Nav?area=config"><i class="material-icons">settings</i><p>Configurations</p></a></li>
                            </ul>
                        </li>
<li style="display: <%=li5%>;" class="nav-item">
                            <a class="nav-link" data-toggle="dropdown" href="#">  <i class="material-icons">report</i><p>Reports<span class="caret"></span></p> </a>
                            <ul class="dropdown-menu">
                                <li style="display: <%=li5%>;"><a class="nav-link" href="./Nav?area=memberlisting">
                                        <i class="material-icons">assignment</i>
                                        <p>Member Listing</p>
                                    </a></li>
                                <li style="display: <%=li5%>;"> <a class="nav-link" href="./Nav?area=membersummary">
                                        <i class="material-icons">assignment_ind</i>
                                        <p>Member Summary</p>
                                    </a></li>
                                     <li style="display: <%=li5%>;"> <a class="nav-link" href="./Nav?area=contributionreport">
                                        <i class="material-icons">description</i>
                                        <p>Contribution Report</p>
                                    </a></li>
                                    <li style="display: <%=li5%>;"> <a class="nav-link" href="./Nav?area=emailreport">
                                        <i class="material-icons">insert_comment</i>
                                        <p>Email Report</p>
                                    </a></li>
                                   <li style="display: <%=li5%>;"> <a class="nav-link" href="./Nav?area=eventreport">
                                        <i class="material-icons">receipt</i>
                                        <p>Event Report</p>
                                    </a></li> 
                                    <li style="display: <%=li5%>;"> <a class="nav-link" href="./Nav?area=beneficiaryreport">
                                        <i class="material-icons">book</i>
                                        <p>Beneficiary Report</p>
                                    </a></li> 
                               
                            </ul>
                        </li>


                        <li class="nav-item ">
                            <a class="nav-link" href="./logout">
                                <i class="material-icons">power_settings_new</i>
                                <p>Log out</p>
                            </a>
                        </li>

                    </ul>
                    </div>
                </div>
                <div class="main-panel">
                    <!-- Navbar -->
                    <nav class="navbar navbar-expand-lg navbar-transparent navbar-absolute fixed-top ">
                        <div class="container-fluid">
                            <div class="navbar-wrapper">
                                <a class="navbar-brand" href="#pablo">User Profile</a>
                            </div>
                            <button class="navbar-toggler" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="navbar-toggler-icon icon-bar"></span>
                                <span class="navbar-toggler-icon icon-bar"></span>
                                <span class="navbar-toggler-icon icon-bar"></span>
                            </button>
                            <div class="collapse navbar-collapse justify-content-end">

                                <ul class="navbar-nav">
                                    <li class="nav-item">
                                        <a class="nav-link" href="#pablo">
                                            <i class="material-icons">dashboard</i>
                                            <p class="d-lg-none d-md-block">
                                                Stats
                                            </p>
                                        </a>
                                    </li>
                                    <li class="nav-item dropdown">
                                        <a class="nav-link" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="material-icons">notifications</i>
                                            <span class="notification">5</span>
                                            <p class="d-lg-none d-md-block">
                                                Some Actions
                                            </p>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                                            <a class="dropdown-item" href="#">Mike John responded to your email</a>
                                            <a class="dropdown-item" href="#">You have 5 new tasks</a>
                                            <a class="dropdown-item" href="#">You're now friend with Andrew</a>
                                            <a class="dropdown-item" href="#">Another Notification</a>

                                        </div>
                                    </li>
                                    <li class="nav-item dropdown">
                                        <a class="nav-link" href="#pablo" id="navbarDropdownProfile" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="material-icons">person</i>
                                            <p class="d-lg-none d-md-block">
                                                Account
                                            </p>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownProfile">
                                            <a class="dropdown-item" href="#">Profile</a>
                                            <a class="dropdown-item" href="#">Settings</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Log out</a>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </nav>
                    <!-- End Navbar -->
                    <div class="content">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="card">
                                        <div class="card-header card-header-primary">
                                            <form action="./Nav?area=user-profile" method="post">
                                                <h4 class="card-title"><%=user.getUsername()%>'s Profile

                                                    <!-- Trigger the modal with a button -->
                                                    <button type="submit" style="float:right;" class="btn btn-primary"><i  class="material-icons">fast_rewind</i></button>
                                                    <!-- Modal -->




                                                </h4>
                                            </form>
                                            <p class="card-category">Edit your profile</p>
                                        </div>
                                        <div class="card-body">
                                            <form action="./Nav?area=user-details&username=<%=usernam%>" method="post">
                                                <div class="row">

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label class="bmd-label-floating">Username</label>
                                                            <input type="text" name ="username" value="<%=user.getUsername()%>" class="form-control" readonly>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <label class="bmd-label-floating">Password</label>
                                                            <input type="text" name ="password" value="<%=user.getPassword()%>" class="form-control" required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-5">
                                                        <div class="form-group">
                                                            <label class="bmd-label-floating">Email address</label>
                                                            <input type="email" name ="email" value="<%=user.getEmail()%>" class="form-control" required>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="bmd-label-floating">First Name</label>
                                                            <input type="text" name ="firstname" value="<%=user.getFname()%>"  class="form-control" required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="bmd-label-floating">Last Name</label>
                                                            <input type="text" name ="lastname" value="<%=user.getLname()%>"  class="form-control" required>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="bmd-label-floating">Phone No.</label>
                                                            <input type="text" name ="phone" value="<%=user.getMobile()%>" class="form-control" required>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="bmd-label-floating">Gender</label>
                                                            <select name ="gender" value="<%=gend%>" class="form-control">
                                                                <option value="<%=user.getGender()%>" selected><%=gend%></option>
                                                                <option value="M">Male</option>
                                                                <option value="F">Female</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                </div>
                                                <button type="submit" name ="update" class="btn btn-primary pull-right">Update Profile</button>
                                                <div class="clearfix"></div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card card-profile">

                                        <div class="card-avatar" id="img">
                                            <a href="#pablo">
                                                <%=url%>
                                            </a>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-category text-gray">CEO / Co-Founder</h6>
                                            <h4 class="card-title"><%=user.getFname()+" "+user.getLname()%></h4>
                                            <p class="card-description">

                                            </p>
                                            <form method="post" action="./profileupdate?username=<%=usernam%>" enctype="multipart/form-data">
                                                <input type="file" name="upload" accept='image/*'>

                                                <input type="submit" name="imgupload" class="btn btn-primary btn-round" value="Upload" />
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                     <footer class="footer">
        <div class="container-fluid">
          
          <div class="copyright float-right">
            &copy;
            <script>
              document.write(new Date().getFullYear())
            </script>, Powered by
            GPMS for a better web.
          </div>
        </div>
      </footer>
                </div>
            </div>
            <div class="fixed-plugin">
                <div class="dropdown show-dropdown">
                    <a href="#" data-toggle="dropdown">
                        <i class="fa fa-cog fa-2x"> </i>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="header-title"> Sidebar Filters</li>
                        <li class="adjustments-line">
                            <a href="javascript:void(0)" class="switch-trigger active-color">
                                <div class="badge-colors ml-auto mr-auto">
                                    <span class="badge filter badge-purple" data-color="purple"></span>
                                    <span class="badge filter badge-azure" data-color="azure"></span>
                                    <span class="badge filter badge-green" data-color="green"></span>
                                    <span class="badge filter badge-warning" data-color="orange"></span>
                                    <span class="badge filter badge-danger" data-color="danger"></span>
                                    <span class="badge filter badge-rose active" data-color="rose"></span>
                                </div>
                                <div class="clearfix"></div>
                            </a>
                        </li>
                        <li class="header-title">Images</li>
                        <li class="active">
                            <a class="img-holder switch-trigger" href="javascript:void(0)">
                                <img src="assets/img/sidebar-1.jpg" alt="">
                            </a>
                        </li>
                        <li>
                            <a class="img-holder switch-trigger" href="javascript:void(0)">
                                <img src="assets/img/sidebar-2.jpg" alt="">
                            </a>
                        </li>
                        <li>
                            <a class="img-holder switch-trigger" href="javascript:void(0)">
                                <img src="assets/img/sidebar-3.jpg" alt="">
                            </a>
                        </li>
                        <li>
                            <a class="img-holder switch-trigger" href="javascript:void(0)">
                                <img src="assets/img/sidebar-4.jpg" alt="">
                            </a>
                        </li>
                        <li class="button-container">
                            <a href="https://www.creative-tim.com/product/material-dashboard" target="_blank" class="btn btn-primary btn-block">Free Download</a>
                        </li>
                        <!-- <li class="header-title">Want more components?</li>
                            <li class="button-container">
                                <a href="https://www.creative-tim.com/product/material-dashboard-pro" target="_blank" class="btn btn-warning btn-block">
                                  Get the pro version
                                </a>
                            </li> -->
                        <li class="button-container">
                            <a href="https://demos.creative-tim.com/material-dashboard/docs/2.1/getting-started/introduction.html" target="_blank" class="btn btn-default btn-block">
                                View Documentation
                            </a>
                        </li>
                        <li class="button-container github-star">
                            <a class="github-button" href="https://github.com/creativetimofficial/material-dashboard" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star ntkme/github-buttons on GitHub">Star</a>
                        </li>
                        <li class="header-title">Thank you for 95 shares!</li>
                        <li class="button-container text-center">
                            <button id="twitter" class="btn btn-round btn-twitter"><i class="fa fa-twitter"></i> &middot; 45</button>
                            <button id="facebook" class="btn btn-round btn-facebook"><i class="fa fa-facebook-f"></i> &middot; 50</button>
                            <br>
                            <br>
                        </li>
                    </ul>
                </div>
            </div>
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
            <% if(response.getHeader("msg") != null && response.getHeader("msg") != ""){%>
            <script>
                                alert("<%=response.getHeader("msg")%>");

            </script>
            <%}%>
            <script>
                $(document).ready(function () {
                    $().ready(function () {
                        $sidebar = $('.sidebar');

                        $sidebar_img_container = $sidebar.find('.sidebar-background');

                        $full_page = $('.full-page');

                        $sidebar_responsive = $('body > .navbar-collapse');

                        window_width = $(window).width();

                        fixed_plugin_open = $('.sidebar .sidebar-wrapper .nav li.active a p').jsp();

                        if (window_width > 767 && fixed_plugin_open == 'Dashboard') {
                            if ($('.fixed-plugin .dropdown').hasClass('show-dropdown')) {
                                $('.fixed-plugin .dropdown').addClass('open');
                            }

                        }

                        $('.fixed-plugin a').click(function (event) {
                            // Alex if we click on switch, stop propagation of the event, so the dropdown will not be hide, otherwise we set the  section active
                            if ($(this).hasClass('switch-trigger')) {
                                if (event.stopPropagation) {
                                    event.stopPropagation();
                                } else if (window.event) {
                                    window.event.cancelBubble = true;
                                }
                            }
                        });

                        $('.fixed-plugin .active-color span').click(function () {
                            $full_page_background = $('.full-page-background');

                            $(this).siblings().removeClass('active');
                            $(this).addClass('active');

                            var new_color = $(this).data('color');

                            if ($sidebar.length != 0) {
                                $sidebar.attr('data-color', new_color);
                            }

                            if ($full_page.length != 0) {
                                $full_page.attr('filter-color', new_color);
                            }

                            if ($sidebar_responsive.length != 0) {
                                $sidebar_responsive.attr('data-color', new_color);
                            }
                        });

                        $('.fixed-plugin .background-color .badge').click(function () {
                            $(this).siblings().removeClass('active');
                            $(this).addClass('active');

                            var new_color = $(this).data('background-color');

                            if ($sidebar.length != 0) {
                                $sidebar.attr('data-background-color', new_color);
                            }
                        });

                        $('.fixed-plugin .img-holder').click(function () {
                            $full_page_background = $('.full-page-background');

                            $(this).parent('li').siblings().removeClass('active');
                            $(this).parent('li').addClass('active');


                            var new_image = $(this).find("img").attr('src');

                            if ($sidebar_img_container.length != 0 && $('.switch-sidebar-image input:checked').length != 0) {
                                $sidebar_img_container.fadeOut('fast', function () {
                                    $sidebar_img_container.css('background-image', 'url("' + new_image + '")');
                                    $sidebar_img_container.fadeIn('fast');
                                });
                            }

                            if ($full_page_background.length != 0 && $('.switch-sidebar-image input:checked').length != 0) {
                                var new_image_full_page = $('.fixed-plugin li.active .img-holder').find('img').data('src');

                                $full_page_background.fadeOut('fast', function () {
                                    $full_page_background.css('background-image', 'url("' + new_image_full_page + '")');
                                    $full_page_background.fadeIn('fast');
                                });
                            }

                            if ($('.switch-sidebar-image input:checked').length == 0) {
                                var new_image = $('.fixed-plugin li.active .img-holder').find("img").attr('src');
                                var new_image_full_page = $('.fixed-plugin li.active .img-holder').find('img').data('src');

                                $sidebar_img_container.css('background-image', 'url("' + new_image + '")');
                                $full_page_background.css('background-image', 'url("' + new_image_full_page + '")');
                            }

                            if ($sidebar_responsive.length != 0) {
                                $sidebar_responsive.css('background-image', 'url("' + new_image + '")');
                            }
                        });

                        $('.switch-sidebar-image input').change(function () {
                            $full_page_background = $('.full-page-background');

                            $input = $(this);

                            if ($input.is(':checked')) {
                                if ($sidebar_img_container.length != 0) {
                                    $sidebar_img_container.fadeIn('fast');
                                    $sidebar.attr('data-image', '#');
                                }

                                if ($full_page_background.length != 0) {
                                    $full_page_background.fadeIn('fast');
                                    $full_page.attr('data-image', '#');
                                }

                                background_image = true;
                            } else {
                                if ($sidebar_img_container.length != 0) {
                                    $sidebar.removeAttr('data-image');
                                    $sidebar_img_container.fadeOut('fast');
                                }

                                if ($full_page_background.length != 0) {
                                    $full_page.removeAttr('data-image', '#');
                                    $full_page_background.fadeOut('fast');
                                }

                                background_image = false;
                            }
                        });

                        $('.switch-sidebar-mini input').change(function () {
                            $body = $('body');

                            $input = $(this);

                            if (md.misc.sidebar_mini_active == true) {
                                $('body').removeClass('sidebar-mini');
                                md.misc.sidebar_mini_active = false;

                                $('.sidebar .sidebar-wrapper, .main-panel').perfectScrollbar();

                            } else {

                                $('.sidebar .sidebar-wrapper, .main-panel').perfectScrollbar('destroy');

                                setTimeout(function () {
                                    $('body').addClass('sidebar-mini');

                                    md.misc.sidebar_mini_active = true;
                                }, 300);
                            }

                            // we simulate the window Resize so the charts will get updated in realtime.
                            var simulateWindowResize = setInterval(function () {
                                window.dispatchEvent(new Event('resize'));
                            }, 180);

                            // we stop the simulation of Window Resize after the animations are completed
                            setTimeout(function () {
                                clearInterval(simulateWindowResize);
                            }, 1000);

                        });
                    });
                });
            </script>
    </body>
</html>
