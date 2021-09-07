<%-- 
    Document   : user
    Created on : Mar 10, 2019, 10:00:56 PM
    Author     : Developer
--%>

<%@page import="com.gpms.pojo.*, java.util.*,java.text.SimpleDateFormat, java.time.LocalDate, java.time.format.DateTimeFormatter" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Member user = null;
    String myUpdatedProfile = null;
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
    String posit = "";
    String positn = "";
     String privilege = (String)session.getAttribute("privilege");
     DashboardModel ddd = new DashboardModel();
     List<PositionModel> positionlist = ddd.fetchMemberPosition();
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
    String gend = null;
     String url = "";
    String id = request.getParameter("id");
    
   
    String orgname = (String)session.getAttribute("OrgName");
    
 try{
     LoginModel loginCred = new LoginModel();
            
            List userlist = loginCred.fetchIndividualMember(id);
            int j = 0;
             while (j < userlist.size()) {
            user = (Member)userlist.get(j);
            session.setAttribute("memberprofile", user);
           j++;
        }
             if(user.getImageurl() == null){
      url = "<img class='img' src='assets/img/profilepic/' alt='assets/img/profilepic/' />";
      }else{
        url = "<img class='img' src='assets/img/profilepic/"+user.getImageurl()+"' alt='assets/img/profilepic/"+user.getImageurl()+"' />";
      }
      gend = user.getGender();
      if(gend.equals("M")){
      gend = "Male";
      }else{
      gend = "Female";
      }
      posit = user.getPosition();
      positn = new DashboardModel().fetchPositionName(Integer.parseInt(posit));
      if(request.getParameter("imageupload") != null){
         
         String upload = request.getParameter("upload");
         
         response.sendRedirect("./update?upload="+upload);   
      }
      if(request.getParameter("update") != null){
           Member updatedUser = new Member();
           DashboardModel dashboard = new DashboardModel();
           //Connection con = (Connection) application.getAttribute("con");
           updatedUser.setMemberId(user.getMemberId());
            
            String email = request.getParameter("email");
            updatedUser.setEmail(email);
            String fullname = request.getParameter("fullname");
            updatedUser.setFullName(fullname);
            String address = request.getParameter("address");
             updatedUser.setAddress(address);
            String phone = request.getParameter("phone");
            updatedUser.setMobile(phone);
            String maritalstatus = request.getParameter("maritalstatus");
            updatedUser.setMaritalStatus(maritalstatus);
            String gender = request.getParameter("gender");
            updatedUser.setGender(gender);
             String position = request.getParameter("position");
            updatedUser.setPosition(position);
            String kids = request.getParameter("kids");
            updatedUser.setKids(Integer.parseInt(kids));
            String dob = request.getParameter("dob");
            DateTimeFormatter f = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate dateOfBirth = LocalDate.parse(dob, f);
            updatedUser.setDob(dateOfBirth.toString());
            
            String occupation = request.getParameter("occupation");
            updatedUser.setOccupation(occupation);
            String aboutme = request.getParameter("aboutme");
            updatedUser.setAboutMe(aboutme);
            myUpdatedProfile = dashboard.updateMemberRecord(updatedUser);
            if(myUpdatedProfile.equals("Update Successful")){
            
            user.setEmail(email);
            user.setFullName(fullname);
             user.setAddress(address);
            user.setMobile(phone);
             user.setKids(Integer.parseInt(kids));
            user.setMaritalStatus(maritalstatus);
            user.setPosition(position);
             positn = new DashboardModel().fetchPositionName(Integer.parseInt(position));
            user.setGender(gender);
            if(gender.equals("M")){
                gend = "Male";
                }else{
                gend = "Female";
                }
            user.setDob(dateOfBirth.toString());
            user.setOccupation(occupation);
            user.setAboutMe(aboutme);
//             if(user.getUsername().equals((String)session.getAttribute("username"))){
//                 session.setAttribute("myProfile", user); 
//             }
            }
            
           
            
      
      }
            if((String)session.getAttribute("session") != "InSession"){
        response.sendRedirect("./logout");
             }
            
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
        <!--        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropper/2.3.4/cropper.min.css">-->

        <!-- CSS Files -->
        <link href="assets/css/material-dashboard.css?v=2.1.1" rel="stylesheet" />
        <!-- CSS Just for demo purpose, don't include it in your project -->
        <link href="assets/demo/demo.css" rel="stylesheet" />
        <link href="assets/css/cropper.css" rel="stylesheet">
       <style>
            .eg-container {
                padding-top: 15px;
                padding-bottom: 15px;
                text-align: center;


            }

            .eg-main {
                max-height: 250px;
                margin-bottom: 30px;
                display: inline-block;
            }

            .eg-wrapper {
                background-color: #f7f7f7;
                margin:0 auto;
                border: 1px solid #eee;
                display: inline-block;
                height: 250px;
                width: 700px;
                padding: 25px;
                overflow: hidden;
            }

            .eg-wrapper img {
                width: 100%;

            }

            .eg-preview {
                margin-bottom: 15px;
            }

            .preview {
                float: left;
                margin-right: 15px;
                margin-bottom: 15px;
                overflow: hidden;
                background: #f7f7f7;
            }

            .preview-lg {
                width: 290px;
                height: 160px;
            }

            .preview-md {
                width: 145px;
                height: 90px;
            }

            .preview-sm {
                width: 72.5px;
                height: 45px;
            }

            .preview-xs {
                width: 36.25px;
                height: 22.5px;
            }

            .eg-data {
                padding-right: 15px;
            }

            .eg-data .input-group {
                width: 100%;
                margin-bottom: 15px;
            }

            .eg-data .input-group-addon {
                min-width: 65px;
            }

            .eg-button > .btn {
                margin-right: 15px;
                margin-bottom: 15px;
            }

            .eg-input .input-group {
                margin-bottom: 15px;
            }

            .eg-output .btn {
                margin-right: 15px;
                margin-bottom: 15px;
            }

            .eg-output img {
                max-height: 214px;
            }
            
            [type="file"] {
  height: 0;
  overflow: hidden;
  width: 0;
}

[type="file"] + label {
  background: #f15d22;
  border: none;
  border-radius: 5px;
  color: #fff;
  cursor: pointer;
  display: inline-block;
	font-family: 'Poppins', sans-serif;
	font-size: inherit;
  font-weight: 600;
  margin-bottom: 1rem;
  outline: none;
  padding: 1rem 50px;
  position: relative;
  transition: all 0.3s;
  vertical-align: middle;
  
  &:hover {
    background-color: darken(#f15d22, 10%);
  }
  
  &.btn-3 {
    background-color: #ee6d9e;
    border-radius: 0;
    overflow: hidden;
    
    span {
      display: inline-block;
      height: 100%;
      transition: all 0.3s;
      width: 100%;
    }
    
    &::before {
      color: #fff;
      content: "\f382";
      font-family: "Font Awesome 5 Pro";
      font-size: 130%;
      height: 100%;
      left: 0;
      line-height: 2.6;
      position: absolute;
      top: -180%;
      transition: all 0.3s;
      width: 100%;
    }

    &:hover {
      background-color: darken(#ee6d9e, 30%);
      
      span {
        transform: translateY(300%);
      }
        
      &::before {
        top: 0;
      }
    }
  }
}
        </style>

        <script type="text/javascript">
            var cFlag = false;

            function setCrop()
            {
                $("#err").text("");
                 document.getElementById("save").style.display = "inline";
                cFlag = true;
            }

            function validate()
            {
                if (cFlag)
                {
                    return cFlag;
                } else
                {
                    $("#err").text("Please crop before upload");
                    $("#err").css("color", "red");
                    return cFlag;
                }

            }
        </script>
       
    </head>

    <body>
        <div class="modal fade" id="myModal" role="dialog" >
            <div class="modal-dialog modal-lg">

                <!-- Modal content-->
                <div class="modal-content">
                      <form action="./profileupdate?id=<%=id%>" method="POST" onsubmit="return validate();">
                        <div class="modal-header">
                            <h4 class="modal-title">Upload Image</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>

                        </div>
                        <div class="modal-body">  
                            <div class="row" >

                                <div class="container-fluid eg-container" id="basic-example" >

                                    <div class="col-md-12 col-xs-12 eg-main">
                                        <div class="col-md-12 col-xs-12 col-sm-12">
                                            <div class="eg-wrapper">
                                                <img class="cropper" src="assets/img/picture-1.png" alt="Picture">
                                            </div>

                                        </div>

                                    </div>

                                    <div class="clearfix">

                                        <div class="col-md-12 col-xs-12 col-sm-12">
                                            <div class="eg-button">
                                                <button class="btn btn-warning" id="reset" type="button"><i  class="material-icons">open_with</i></button>
                                                <button class="btn btn-info" id="zoomIn" type="button"><i  class="material-icons">zoom_in</i></button>
                                                <button class="btn btn-info" id="zoomOut" type="button"><i  class="material-icons">zoom_out</i></button>
                                                <button class="btn btn-info" id="rotateLeft" type="button"><i  class="material-icons">rotate_left</i></button>
                                                <button class="btn btn-info" id="rotateRight" type="button"><i  class="material-icons">rotate_right</i></button>
                                                <button class="btn btn-info" id="download" type="button" title="Download cropped image" style="display: inline">

                                                     <i  class="material-icons">get_app</i>

                                                </button>
                                                <button class="btn btn-warning" id="getDataURL" onclick="setCrop();" type="button" style="display: inline; color:white"><i  class="material-icons">crop</i></button>

                                                <label class="btn btn-3" for="inputImage" title="Upload image file">
                                                    <input class="hide" id="inputImage" name="file" accept="image/*" type="file">
                                                    <span data-original-title="Import image" class="docs-tooltip" data-toggle="tooltip" title="">
                                                        <i  class="material-icons">open_in_browser</i>
                                                    </span>
                                                </label>


                                            </div>

                                            <div class="row eg-output">
                                                <div class="col-md-12">
                                                    <div id="err"></div>
                                                </div>
                                                <div class="col-md-6">
                                                  
                                                        <textarea name="image_file" style="display: none;"class="form-control" id="dataURL" rows="10"></textarea>
                                                       
                                                        <!--imageupload-->
                                                        <input type="submit" name="" id="save" class="btn btn-primary btn-round" value="Upload" style="display: none;" />
                                                   
                                                </div>
                                                <div class="col-md-6">
                                                    <div id="showDataURL"></div>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="hidden-print docs-sidebar" role="complementary">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal"><i  class="material-icons">close</i></button>
                        </div>
                    </form>
                </div>

            </div>
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
                        <li class="nav-item ">
                            <a class="nav-link" href="./Nav?area=dashboard">

                                <i class="material-icons">dashboard</i>
                                <p>Dashboard</p>
                            </a>
                        </li>

                        <li style="display: <%=li1%>;" class="nav-item active">
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
                       
                        <li style="display: <%=li9%>;" class="nav-item">
                            <a class="nav-link" data-toggle="dropdown" href="#">  <i class="material-icons">view_list</i><p>Preferences<span class="caret"></span></p> </a>
                            <ul class="dropdown-menu">
                                <li style="display: <%=li6%>;"><a class="nav-link" href="./Nav?area=user-profile">
                                        <i class="material-icons">people</i>
                                        <p>User Management</p>
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
                            <a class="navbar-brand" href="#pablo">Member Profile</a>
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

                                        <form action="./Nav?area=member-management" method="post">
                                            <h4 class="card-title"><%=user.getFullName()%>'s Profile
                                                <button type="submit" style="float:right;" class="btn btn-primary"><i  class="material-icons">fast_rewind</i></button>

                                                <!-- Trigger the modal with a button -->

                                                <!-- Modal -->




                                            </h4>
                                        </form>
                                        <!--<p class="card-category">Edit your profile</p>-->
                                    </div>
                                    <div class="card-body">
                                        <form action="./Nav?area=member-details&id=<%=id%>" method="post">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label class="bmd-label-floating">Email address</label>
                                                        <input type="email" name ="email" value="<%=user.getEmail()%>" class="form-control" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <div class="form-group">
                                                        <label class="bmd-label-floating">Full Name</label>
                                                        <input type="text" name ="fullname" value="<%=user.getFullName()%>"  class="form-control" required>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="bmd-label-floating">Phone No.</label>
                                                        <input type="text" name ="phone" value="<%=user.getMobile()%>" class="form-control" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label class="bmd-label-floating">Address</label>
                                                        <input type="text" name ="address" value="<%=user. getAddress()%>" class="form-control" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="bmd-label-floating">Marital Status</label>
                                                        <select name ="maritalstatus" value="<%=user.getMaritalStatus()%>" class="form-control">
                                                            <option value="<%=user.getMaritalStatus()%>" selected><%=user.getMaritalStatus()%></option>
                                                            <option value="Single">Single</option>
                                                            <option value="Married">Married</option>
                                                            <option value="Divorced">Divorced</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="bmd-label-floating">Gender</label>
                                                        <select name ="gender" value="<%=gend%>" class="form-control">
                                                            <option value="<%=user.getGender()%>" selected><%=gend%></option>
                                                            <option value="M">Male</option>
                                                            <option value="F">Female</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="">Position</label>
                                                        <select name ="position" class="form-control">
                                                            <option value="<%=user.getPosition()%>" selected><%=positn%></option>
                                                            <%
                                                             int f = 0;
                                                       while (f < positionlist.size()) {
                                                            %>
                                                            <option value="<%=((PositionModel)positionlist.get(f)).getPositionid()%>"><%=((PositionModel)positionlist.get(f)).getPositionname()%></option> 
                                                            <%
                                                            f++;
                                                         }
                                                            %>
                                                            <option value="6">Member</option>
                                                        </select>
                                                    </div>
                                                </div>               
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label class="">Date of Birth</label>
                                                        <input type="date" name ="dob" value="<%=user.getDob()%>" placeholder="Date of Birth" class="form-control" required>
                                                    </div>
                                                </div>
                                                <div class="col-md-5">
                                                    <div class="form-group">
                                                        <label class="">Number of Kids</label>
                                                        <input type="number" name ="kids" value="<%=user.getKids()%>" min="0" class="form-control" required>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="bmd-label-floating">Occupation</label>
                                                        <input type="text" name ="occupation" value="<%=user.getOccupation()%>" class="form-control" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label>About Me</label>
                                                        <div class="form-group">
                                                            <textarea class="form-control" rows="2" name ="aboutme" required><%=user.getAboutMe()%></textarea>
                                                        </div>
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
                                    <div class="card-avatar box-2">

                                        <%=url%>

                                    </div>
                                    <div class="card-body">
                                        <h6 class="card-category text-gray"><%=positn%></h6>
                                        <h4 class="card-title"><%=user.getFullName()%></h4>
                                        <p class="card-description">
                                            <%=user.getOccupation()%>
                                        </p>
                                        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#myModal">Change profile picture</button>
                                        
                                       
                                    </div>
                                </div>

                                <div class="card">
                                    <ul class="nav nav-tabs" role="tablist">
                                        <li class="nav-item" style="background-color: #9124A3;">
                                            <a class="nav-link text-gray active" data-toggle="tab" href="#menu1">Email</a>
                                        </li>
                                        <li class="nav-item" style="background-color: #9124A3;">
                                            <a class="nav-link text-gray" data-toggle="tab" href="#menu2">SMS</a>
                                        </li>
                                        <p> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Placeholder:</b>&nbsp;#alias#</p>
                                    </ul>

                                    <!-- Tab panes -->
                                    <div class="tab-content">
                                        <div id="menu1" class="container tab-pane active"><br>
                                            <form action="" method="post">
                                                <div class="form-group">
                                                    <label class="bmd-label-floating">Subject.</label>
                                                    <input type="text" name ="subject" id="subject" class="form-control" required>
                                                </div>


                                                <div class="form-group">
                                                    <label class="bmd-label-floating">Message.</label>
                                                    <textarea type="text" name ="message"  maxlength="160" class="form-control" required></textarea>
                                                </div>
                                                <div class="form-group" style="float: right;">
                                                    <button type="submit" name="sendmail" value="sendmail" class="btn btn-primary" ><i  class="material-icons">send</i></button>
                                                </div>
                                            </form>
                                        </div>
                                        <div id="menu2" class="container tab-pane fade"><br>
                                            <form action="" method="post">
                                                <div class="form-group">
                                                    <label class="bmd-label-floating">Message.</label>
                                                    <textarea type="text" name ="msgs" maxlength="160"  class="form-control" required></textarea>
                                                </div>
                                                <div class="form-group" style="float: right;">
                                                    <button type="submit" name="sndmail" value="sndmail" class="btn btn-primary" ><i  class="material-icons">send</i></button>
                                                </div>
                                            </form>
                                        </div>

                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
                <%
String resp = "";
if(request.getParameter("sendmail") != null){
 DashboardModel dbd = new DashboardModel();       
String subject = request.getParameter("subject");
String to = user.getEmail();
String message = request.getParameter("message");
resp = dbd.sendIndividualEmail(subject, to, message, user.getMemberId());
if(resp != null && resp != "")
{%>
                <script>
                    window.onload = function () {
                        alert("<%=resp%>");
                    };

                </script>
                <%}
                  }
                %>

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
        <%
   String respons = "";
 if(request.getParameter("sndmail") != null){
 DashboardModel dbd = new DashboardModel();      
String message = request.getParameter("msgs");
respons = dbd.sendIndividualSMS(user.getMobile(), message, user.getMemberId());
if(respons != null && respons != "")
    if(respons.equals("ACT"))
    {
      respons = "SMS has been sent successfully..";
    }
    else{
    respons = "SMS could not be sent. Contact support ...";
    }
{%>
        <script>
                                window.onload = function () {
                                    alert("<%=respons%>");
                                };
        </script>
        <%}
          }
        %>
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
        <!--        <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/0.8.1/cropper.min.js"></script>-->
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="assets/js/cropper.js"></script>
        <script src="assets/js/docs.js"></script>
        <script>
            $(function () {
                var $image = $(".cropper"),
                        $dataX = $("#dataX"),
                        $dataY = $("#dataY"),
                        $dataHeight = $("#dataHeight"),
                        $dataWidth = $("#dataWidth"),
                        console = window.console || {log: $.noop},
                        cropper;

                $image.cropper({
                    aspectRatio: 16 / 9,
                    // autoCropArea: 1,
                    data: {
                        x: 420,
                        y: 50,
                        width: 640,
                        height: 360
                    },
                    preview: ".preview",
                    // multiple: FALSE,
                    // autoCrop: TRUE,
                    // dragCrop: TRUE,
                    // dashed: TRUE,
                    // modal: TRUE,
                    // movable: TRUE,
                    // resizable: TRUE,
                    // zoomable: TRUE,
                    // rotatable: TRUE,

                    // maxWidth: 480,
                    // maxHeight: 270,
                    // minWidth: 160,
                    // minHeight: 90,

                    done: function (data) {
                        $dataX.val(data.x);
                        $dataY.val(data.y);
                        $dataHeight.val(data.height);
                        $dataWidth.val(data.width);
                    },
                    build: function (e) {
                        console.log(e.type);
                    },
                    built: function (e) {
                        console.log(e.type);
                    },
                    dragstart: function (e) {
                        console.log(e.type);
                    },
                    dragmove: function (e) {
                        console.log(e.type);
                    },
                    dragend: function (e) {
                        console.log(e.type);
                    }
                });

                cropper = $image.data("cropper");

                $image.on({
                    "build.cropper": function (e) {
                        console.log(e.type);
                        // e.preventDefault();
                    },
                    "built.cropper": function (e) {
                        console.log(e.type);
                        // e.preventDefault();
                    },
                    "dragstart.cropper": function (e) {
                        console.log(e.type);
                        // e.preventDefault();
                    },
                    "dragmove.cropper": function (e) {
                        console.log(e.type);
                        // e.preventDefault();
                    },
                    "dragend.cropper": function (e) {
                        console.log(e.type);
                        // e.preventDefault();
                    }
                });

                $("#reset").click(function () {
                    $image.cropper("reset");
                });

                $("#reset2").click(function () {
                    $image.cropper("reset", true);
                });

                $("#clear").click(function () {
                    $image.cropper("clear");
                });

                $("#destroy").click(function () {
                    $image.cropper("destroy");
                });

                $("#enable").click(function () {
                    $image.cropper("enable");
                });

                $("#disable").click(function () {
                    $image.cropper("disable");
                });

                $("#zoom").click(function () {
                    $image.cropper("zoom", $("#zoomWith").val());
                });

                $("#zoomIn").click(function () {
                    $image.cropper("zoom", 0.1);
                });

                $("#zoomOut").click(function () {
                    $image.cropper("zoom", -0.1);
                });

                $("#rotate").click(function () {
                    $image.cropper("rotate", $("#rotateWith").val());
                });

                $("#rotateLeft").click(function () {
                    $image.cropper("rotate", -90);
                });

                $("#rotateRight").click(function () {
                    $image.cropper("rotate", 90);
                });

                $("#setAspectRatio").click(function () {
                    $image.cropper("setAspectRatio", $("#aspectRatio").val());
                });

                $("#replace").click(function () {
                    $image.cropper("replace", $("#replaceWith").val());
                });

                $("#getImageData").click(function () {
                    $("#showImageData").val(JSON.stringify($image.cropper("getImageData")));
                });

                $("#setData").click(function () {
                    $image.cropper("setData", {
                        x: $dataX.val(),
                        y: $dataY.val(),
                        width: $dataWidth.val(),
                        height: $dataHeight.val()
                    });
                });

                $("#getData").click(function () {
                    $("#showData").val(JSON.stringify($image.cropper("getData")));
                });

                $("#getDataURL").click(function () {
                    var dataURL = $image.cropper("getDataURL");

                    $("#dataURL").text(dataURL);
                    $("#showDataURL").html('<img src="' + dataURL + '">');
                });

                $("#getDataURL2").click(function () {
                    var dataURL = $image.cropper("getDataURL", "image/jpeg");

                    $("#dataURL").text(dataURL);
                    $("#showDataURL").html('<img src="' + dataURL + '">');
                });
            });
        </script>
    </body>
</html>
