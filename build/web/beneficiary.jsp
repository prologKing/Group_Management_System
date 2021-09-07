<%-- 
    Document   : beneficiary
    Created on : Nov 1, 2020, 6:32:51 PM
    Author     : Developer
--%>
<%@page import="com.gpms.pojo.*, java.util.*,  java.text.SimpleDateFormat, java.text.DecimalFormat, org.apache.commons.lang3.StringUtils, java.time.LocalDate, java.time.format.DateTimeFormatter" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    List<Contribution> userlist = null;
    Contribution ev = null;
    List<EventModel> eventlist = null;
    DecimalFormat df = new DecimalFormat("#,###.00");
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
     String orgname = (String)session.getAttribute("OrgName");
 try{
     
       LoginModel loginCred = new LoginModel();
       userlist = loginCred.fetchBeneficiary();
       DashboardModel dash = new DashboardModel();
       eventlist = dash.fetchEventsAndId();
        if(request.getParameter("addcontribution") != null){
            
         Contribution newEv = new Contribution();
         DashboardModel dashboard = new DashboardModel();
         String member_id = request.getParameter("member_id");
         newEv.setMemberid(member_id); 
         String options = request.getParameter("options");
         String contribution = request.getParameter("contribution");
         newEv.setContribution(Double.parseDouble(contribution)); 
         String event = request.getParameter("list");
         newEv.setEvent(event);
        
          
          String res = dashboard.CreateNewBeneficiary( newEv, (String)session.getAttribute("username"));
          
         
          if(res.equals("Insert Operation Successful")){
           userlist = loginCred.fetchBeneficiary();
        
        }
         
      }
        
          if(request.getParameter("editcontribution") != null){
            
            Contribution newEv = new Contribution();
            DashboardModel dashboard = new DashboardModel();
          String contributionid = request.getParameter("contributionid");
         newEv.setContrubtionid(Integer.parseInt(contributionid)); 
         String contribution = request.getParameter("contribution");
         newEv.setContribution(Double.parseDouble(contribution)); 
         String event = request.getParameter("event");
         newEv.setEventid(Integer.parseInt(event));

          String res = dashboard.UpdateBeneficiaryRecord( newEv, (String)session.getAttribute("username"));
          if(res.equals("Update Successful")){
           userlist = loginCred.fetchBeneficiary();
        
        }
         
      }
          if(request.getParameter("deletecontribution") != null){
            DashboardModel dashboard = new DashboardModel();
          String contributionid = request.getParameter("contributionid");
          String res = dashboard.deleteBeneficiaryRecord(Integer.parseInt(contributionid));
          if(res.equals("Delete Successful")){
           userlist = loginCred.fetchBeneficiary();
        
        }
         
      }
 
            if((String)session.getAttribute("session") != "InSession"){
        response.sendRedirect("./logout");
             }
           
            }catch(Exception e){
         out.println(e);
        }


%>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" href="assets/img/favicon.png">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>
            Material Dashboard by GPMS
        </title>
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
        <div class="container">

            <!-- Trigger the modal with a button -->


            <!-- Modal -->
            <div class="modal fade" id="myModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <form action="" method="post">
                            <div class="modal-header">
                                <h4 class="modal-title">New Beneficiary Form</h4>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>

                            </div>
                            <div class="modal-body">


                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="bmd-label-floating">Search Option.</label>
                                                <select name ="options" id="options" class="form-control" id="options" required>
                                                    <option value="M">Member ID</option>
                                                    <option value="P">Phone #</option>
                                                    <option value="A">Alias</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6" style="margin-top: 34px;">
                                            <div class="form-group">

                                                <label class="bmd-label-floating">Enter Value.</label>
                                                <input type="text" name ="name"  class="form-control" onBlur="checkExist(this.value)" required>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row" style="padding-left: 17px; padding-bottom: 20px;">
                                        <div class="form-group">
                                            <b><span id="member_name"></span> </b>
                                            <input type="hidden" name ="member_id" id="member_id"  class="form-control" required>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="bmd-label-floating">Amount.</label>
                                        <input type="text" name ="contribution"  class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label class="">Events</label>
                                        <select name ="list" class="form-control" id="list" required>


                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal"><i  class="material-icons">close</i></button>
                                <button type="submit" name="addcontribution" value="addcontribution" class="btn btn-primary" ><i  class="material-icons">add</i></button>
                            </div>
                        </form>
                    </div>

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
                        <li class="nav-item  ">
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
                        <li style="display: <%=li2%>;" class="nav-item">
                            <a class="nav-link" href="./Nav?area=events">
                                <i class="material-icons">event</i>
                                <p>Events</p>
                            </a>
                        </li>

                        <li style="display: <%=li3%>;" class="nav-item">
                            <a class="nav-link" href="./Nav?area=contributions">
                                <i class="material-icons">money</i>
                                <p>Contributions</p>
                            </a>
                        </li>
                        <li style="display: <%=li3%>;" class="nav-item active">
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
                            <a class="navbar-brand" href="#pablo">Beneficiaries</a>
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
                                        <a class="dropdown-item" href="#">Another One</a>
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
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header card-header-primary">

                                        <h4 class="card-title ">List of Beneficiaries 
                                            <button type="button" style="float:right;" class="btn btn-primary" data-toggle="modal" data-target="#myModal"><i  class="material-icons">add</i></button>
                                        </h4>
                                        <p class="card-category"><%=orgname%></p>
                                    </div>
                                    <div class="card-body">
                                        <div>
                                            <table id="dtBasicExample" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                                                <thead class=" text-primary">
                                                <th>
                                                    Beneficiary
                                                </th>
                                                <th>
                                                    Amount
                                                </th>
                                                <th>
                                                    Event
                                                </th>
                                                <th>
                                                    Date
                                                </th>
                                                <th>

                                                </th>

                                                </thead>
                                                <tbody>
                                                    <%
                                                        int i = 0;
                                          while (i < userlist.size()) {
                                               ev = (Contribution)userlist.get(i);
                                                    %>
                                                    <tr>
                                                        <td>

                                                            <%=ev.getName()%>

                                                        </td>
                                                        <td>
                                                            <%=df.format(ev.getContribution())%>
                                                        </td>
                                                        <td>
                                                            <%=ev.getEvent()%>
                                                        </td>
                                                        <td>
                                                            <%=ev.getContributionDate()%>
                                                        </td>
                                                        <td>
                                                            <button type="button" data-toggle="modal" data-target="#emailModal" data-values='{"id":"<%=ev.getContrubtionid()%>", "name":"<%=ev.getName()%>", "contribution":"<%=ev.getContribution()%>","event": "<%=ev.getEvent()%>", "eventid":"<%=ev.getEventid()%>"}' onclick="loadList('<%=ev.getMemberid()%>', '<%=ev.getEventid()%>', '<%=ev.getEvent()%>')"><i  class="material-icons">edit</i> </button>
                                                            <button type="button" data-toggle="modal" data-target="#deleteModal" data-objvalues='{"id":"<%=ev.getContrubtionid()%>", "name":"<%=ev.getName()%>", "eventname":"<%=ev.getEvent()%>"}'><i  class="material-icons">delete</i> </button>
                                                        </td>

                                                    </tr>
                                                    <%i++;}%>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <script>
                    function checkExist(value) {

                        var xmlhttp = new XMLHttpRequest();
                        var username = value;
                        var parser, xmlDoc, result, i;
                        var txt = "";
                        if (username !== "") {
                            var url = "./Nav?searchinput=" + value + "&option=" + document.getElementById("options").value;
                            xmlhttp.onreadystatechange = function () {
                                if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {

                                    document.getElementById("member_id").value = xmlhttp.responseText;


                                    if (document.getElementById("options").value !== "") {
                                        var xmhtt = new XMLHttpRequest();
                                        var ul = "./Nav?searchvalue=" + value + "&options=" + document.getElementById("options").value;
                                        xmhtt.onreadystatechange = function () {
                                            if (xmhtt.readyState === 4 && xmhtt.status === 200) {


                                                document.getElementById("member_name").innerHTML = xmhtt.responseText;
                                                if (document.getElementById("options").value !== "") {
                                                    var xmht = new XMLHttpRequest();
                                                    var ull = "./Nav?middd=" + document.getElementById("member_id").value;
                                                    xmht.onreadystatechange = function () {
                                                        if (xmht.readyState === 4 && xmht.status === 200) {

                                                            parser = new DOMParser();
                                                            xmlDoc = parser.parseFromString(xmht.responseText, "text/xml");
                                                            result = xmlDoc.getElementsByTagName("item");
                                                            for (i = 0; i < result.length; i++) {
                                                                txt += "<option value=" + result[i].getAttribute('id') + ">" + result[i].childNodes[0].nodeValue + "</option>";
                                                            }
                                                            document.getElementById("list").innerHTML = txt;


                                                        }

                                                    };
                                                    try {
                                                        xmht.open("GET", ull, true);
                                                        xmht.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                                                        xmht.send();

                                                    } catch (e) {
                                                        alert("unable to connect to server");
                                                    }
                                                }

                                            }

                                        };
                                        try {
                                            xmhtt.open("GET", ul, true);
                                            xmhtt.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                                            xmhtt.send();

                                        } catch (e) {
                                            alert("unable to connect to server");
                                        }
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
                        }
                    }

                    function loadList(value, value2, value3) {

                        var xmlhttp = new XMLHttpRequest();
                        var username = value;
                        var parser, xmlDoc, result, i;
                        var txt = "<option value=" + value2 + ">" + value3 + "</option>";
                        if (username !== "") {
                            var url = "./Nav?mid=" + username;
                            xmlhttp.onreadystatechange = function () {
                                if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                                    parser = new DOMParser();
                                    xmlDoc = parser.parseFromString(xmlhttp.responseText, "text/xml");
                                    result = xmlDoc.getElementsByTagName("item");
                                    for (i = 0; i < result.length; i++) {
                                        txt += "<option value=" + result[i].getAttribute('id') + ">" + result[i].childNodes[0].nodeValue + "</option>";
                                    }
                                    document.getElementById("event").innerHTML = txt;
                                }

                            };
                            try {
                                xmlhttp.open("GET", url, true);
                                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                                xmlhttp.send();
                            } catch (e) {
                                alert("unable to connect to server");
                            }
                        }
                    }
                </script>

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
                        <a href="https://demos.creative-tim.com/material-dashboard/docs/2.1/getting-started/introduction.jsp" target="_blank" class="btn btn-default btn-block">
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
        <script>
                                $(document).ready(function () {
                                    $('#dtBasicExample').DataTable({
                                        "pagingType": "simple_numbers" // "simple" option for 'Previous' and 'Next' buttons only
                                    });
                                    $('.dataTables_length').addClass('bs-select');
                                });
        </script>
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
        <div class="modal fade" id="emailModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <form action="" method="post">
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Form</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>

                        </div>
                        <div class="modal-body">

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="bmd-label-floating">Name.</label>
                                    <input type="hidden" name ="contributionid" id="contributionid" class="form-control" required>
                                    <input type="text" name ="name" id="name" class="form-control" readonly>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Contribution.</label>
                                    <input type="text" name ="contribution" id="contribution" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label class="">Events</label>
                                    <select name ="event" id="event" class="form-control" readonly>



                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal"><i  class="material-icons">close</i></button>
                            <button type="submit" name="editcontribution" value="editcontribution" class="btn btn-primary" ><i  class="material-icons">edit</i></button>
                        </div>
                    </form>
                </div>

            </div>
        </div>

        <script>

            $('#emailModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget); // Button that triggered the modal
                var id = button.data('values').id;
                var name = button.data('values').name;
                var contribution = button.data('values').contribution;
                var event = button.data('values').event;
                var eventid = button.data('values').eventid;

                // Extract info from data-* attributes
                // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
                // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
                var modal = $(this);
                modal.find('#contributionid').val(id);
                modal.find('#name').val(name);
                modal.find('#contribution').val(contribution);
                document.getElementById("event").innerHTML = "<option value='" + eventid + "'>" + event + "</option>";

            });

        </script>
        <div class="modal fade" id="deleteModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <form action="" method="post">

                        <div class="modal-body">

                            <div class="col-md-12">
                                <p>Are you sure you want to delete beneficiary record for <span name="eventname" id="eventname"></span> by <span name="membername" id="membername"></span>?</p>
                                <input type="hidden" name ="contributionid" id="contributionid" class="form-control" required />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal"><i  class="material-icons">close</i></button>
                                <button type="submit" name="deletecontribution" value="deletecontribution" class="btn btn-primary" ><i  class="material-icons">delete</i></button>
                            </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
    <script>
        $('#deleteModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var id = button.data('objvalues').id;
            var name = button.data('objvalues').name;
            var eventname = button.data('objvalues').eventname;
            // Extract info from data-* attributes
            // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
            // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
            var modal = $(this);

            modal.find('#contributionid').val(id);
            document.getElementById("membername").innerHTML = name;
            document.getElementById("eventname").innerHTML = eventname;
        });

    </script>
</body>
</html>
