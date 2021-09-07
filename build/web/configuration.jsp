<%-- 
    Document   : user
    Created on : Mar 10, 2019, 10:00:56 PM
    Author     : Developer
--%>

<%@page import="com.gpms.pojo.*, org.apache.commons.lang3.StringUtils, java.util.*, java.text.SimpleDateFormat, java.time.LocalDate, java.time.LocalDateTime, java.time.format.DateTimeFormatter" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String smtpservername = ""; 
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
    String checkValue1 = "";
    String checkValue2 = "";
    String checkValue3 = "";
    String checkValue4 = "";
    String checkValue5 = "";
    String checkValue6 = "";
    String checkValue7 = "";
    String checkValue8 = "";
    String checkValue9 = "";
    String checkValue10 = "";
    String checkValue11 = "";
    String checkValue12 = "";
    String checkValue13 = "";
    String checkValue14 = "";
    String checkValue15 = "";
    String checkValue16 = "";
    LocalDateTime ldt = LocalDateTime.now();
    LocalDateTime tomorrow = ldt.plusDays(1);
    LocalDateTime dayAfterTomorrow = ldt.plusDays(2);
    DateTimeFormatter formmat1 = DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.ENGLISH);
// Output "2018-05-12T17:21:53.658"

    String fo = formmat1.format(ldt);
    String fo1 = formmat1.format(tomorrow);
    String fo2 = formmat1.format(dayAfterTomorrow);

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
    String smsservername = ""; 
    String response_string= "";
    DashboardModel dashboard = new DashboardModel();
    String orgname = (String)session.getAttribute("OrgName");
     Company emailconf = new Company();
     LoginModel log = new LoginModel();
     if(request.getParameter("updaterole") != null){
    String rolename = request.getParameter("rolename");
    if("Admin".equals(rolename)){
    String bin = "";

            if(request.getParameter("member") != null){
            bin += "1";
            }
            if(request.getParameter("member") == null){
            bin += "0";
            }
            if(request.getParameter("event") != null){
            bin += "1";
            }
            if(request.getParameter("event")== null){
            bin += "0";
            }
             if(request.getParameter("contribution")!= null){
            bin += "1";
            }
            if(request.getParameter("contribution")== null){
            bin += "0";
            }
              if(request.getParameter("bulksms")!= null){
            bin += "1";
            }
            if(request.getParameter("bulksms")== null){
            bin += "0";
            }
             if(request.getParameter("report")!= null){
            bin += "1";
            }
            if(request.getParameter("report")== null){
            bin += "0";
            }
             if(request.getParameter("user")!= null){
            bin += "1";
            }
            if(request.getParameter("user")== null){
            bin += "0";
            }
             if(request.getParameter("orgprofile")!= null){
            bin += "1";
            }
            if(request.getParameter("orgprofile")== null){
            bin += "0";
            }
             if(request.getParameter("configuration")!= null){
            bin += "1";
            }
            if(request.getParameter("configuration")== null){
            bin += "0";
            }
            
            Role role = new Role(rolename, bin);
             dashboard.updateRole(role);
    }
    if("User".equals(rolename)){
    String bin = "";

            if(request.getParameter("member1") != null){
            bin += "1";
            }
            if(request.getParameter("member1") == null){
            bin += "0";
            }
            if(request.getParameter("event1") != null){
            bin += "1";
            }
            if(request.getParameter("event1")== null){
            bin += "0";
            }
             if(request.getParameter("contribution1")!= null){
            bin += "1";
            }
            if(request.getParameter("contribution1")== null){
            bin += "0";
            }
              if(request.getParameter("bulksms1")!= null){
            bin += "1";
            }
            if(request.getParameter("bulksms1")== null){
            bin += "0";
            }
             if(request.getParameter("report1")!= null){
            bin += "1";
            }
            if(request.getParameter("report1")== null){
            bin += "0";
            }
             if(request.getParameter("user1")!= null){
            bin += "1";
            }
            if(request.getParameter("user1")== null){
            bin += "0";
            }
             if(request.getParameter("orgprofile1")!= null){
            bin += "1";
            }
            if(request.getParameter("orgprofile1")== null){
            bin += "0";
            }
             if(request.getParameter("configuration1")!= null){
            bin += "1";
            }
            if(request.getParameter("configuration1")== null){
            bin += "0";
            }
            
            Role role = new Role(rolename, bin);
             dashboard.updateRole(role);
    }
}
     String priv1 = log.fetchRolePrivilege(2).getPrivilege();
     if(priv1.substring(0,1).equals("1")){
     checkValue1 ="checked";
     }
     if(priv1.substring(1,2).equals("1")){
     checkValue2 ="checked";
     }
     if(priv1.substring(2,3).equals("1")){
     checkValue3 ="checked";
     }
     if(priv1.substring(3,4).equals("1")){
     checkValue4 ="checked";
     }
     if(priv1.substring(4,5).equals("1")){
     checkValue5 ="checked";
     }
     if(priv1.substring(5,6).equals("1")){
     checkValue6 ="checked";
     }
     if(priv1.substring(6,7).equals("1")){
     checkValue7 ="checked";
     }
     if(priv1.substring(7).equals("1")){
     checkValue8 ="checked";
     }
     String priv2 = log.fetchRolePrivilege(3).getPrivilege();
      if(priv2.substring(0,1).equals("1")){
     checkValue9 ="checked";
     }
     if(priv2.substring(1,2).equals("1")){
     checkValue10 ="checked";
     }
     if(priv2.substring(2,3).equals("1")){
     checkValue11 ="checked";
     }
     if(priv2.substring(3,4).equals("1")){
     checkValue12 ="checked";
     }
     if(priv2.substring(4,5).equals("1")){
     checkValue13 ="checked";
     }
     if(priv2.substring(5,6).equals("1")){
     checkValue14 ="checked";
     }
     if(priv2.substring(6,7).equals("1")){
     checkValue15 ="checked";
     }
     if(priv2.substring(7).equals("1")){
     checkValue16 ="checked";
     }
     Organization organ = (Organization)log.fetchOrganizationDetails().get(0);
     List<Company> conf = null;
     try{
     conf = dashboard.fetchSMTPServerConfig();
     String id = organ.getSmtpConfigID();
     String id2 = organ.getSmsApiID();
     if(id2.equals("1")){
     smsservername ="Phalco API";
     }
      if(id2.equals("2")){
     smsservername ="Wirepick API";
     }
       if(id2.equals("3")){
     smsservername ="Hubtel API";
     }
     int j= 0;
      while (j < conf.size()) {
              emailconf = (Company)conf.get(j);
              if(emailconf.getId().equals(id)){
              smtpservername = emailconf.getHost();
              
              }
              j++;
      }
       if(request.getParameter("updatesmsserver") != null){
         
         String smsserver = request.getParameter("smsapi");
         response_string = dashboard.updateSMSAPIId(smsserver);
         if(response_string.equals("Update Successful")){
            if(smsserver.equals("1")){
     smsservername ="Phalco API";
     }
      if(smsserver.equals("2")){
     smsservername ="Wirepick API";
     }
       if(smsserver.equals("3")){
     smsservername ="Hubtel API";
     }
         }
         
      } 
       if(request.getParameter("updatemessage") != null){
         
         String msgtype = request.getParameter("msgtype");
          String msg = request.getParameter("msg");
          String time = request.getParameter("broadcast_time");
          String hour = StringUtils.substringBefore(time, ":");
          String minute = StringUtils.substringAfter(time, ":");
         response_string = dashboard.updateMessage(msgtype, msg, hour, minute);
        
         
      
        } 
        if(request.getParameter("electionconfig") != null){
         ElectionType eType = new ElectionType();
         ElectionSeat eSeat = new ElectionSeat();
         String election_name = request.getParameter("election_name");
         eType.setElectionName(election_name);
          String election_date = request.getParameter("election_date");
          DateTimeFormatter h = DateTimeFormatter.ofPattern("yyy-MM-dd HH:mm:ss");
          LocalDateTime e_date = LocalDateTime.parse(election_date, h);
          eType.setElectionStartDate(e_date.toString());
          String election_date2 = request.getParameter("election_date2");
          LocalDateTime e_date2 = LocalDateTime.parse(election_date2, h);
           
          eType.setElectionEndDate(e_date2.toString()); 
          DateTimeFormatter g = DateTimeFormatter.ofPattern("yyyy-MM-dd");
           String opening_date = request.getParameter("opening_date");
            LocalDate o_date = LocalDate.parse(opening_date, g);
           
          eType.setFormOpeningDate(o_date.toString()); 
           String closing_date = request.getParameter("closing_date");
            LocalDate c_date = LocalDate.parse(closing_date, g);
           
          eType.setFormClosingDate(c_date.toString()); 
          String token_date = request.getParameter("token_date");
          LocalDate t_date = LocalDate.parse(token_date, g);
           
          eType.setTokenBroadcastDate(t_date.toString()); 
          String res = dashboard.CreateElectionRecord(eType, (String)session.getAttribute("username"));
          String num_of_seats = request.getParameter("num_of_seats");
          int val = 0;
          while(val < Integer.parseInt(num_of_seats)){
           eSeat.setSeatName(request.getParameter("seatnum"+(val+1)));
           eSeat.setElectionid(Integer.parseInt(res));
           String r = dashboard.CreateElectionSeatsRecord(eSeat);
           if(r.equals("Insert Operation Successful")){
           val++;
           }
          
          }
          if(!res.equals("")){
%>

<script>
    window.onload = function () {
        alert("Election Configured Successfully!");
    };
</script>
<%
    }
  } 
       
if(request.getParameter("updatesmtpserver") != null){
         
   String smtpserver = request.getParameter("smtpserver");
   response_string = dashboard.updateSMTPServerId(smtpserver);
   if(response_string.equals("Update Successful")){
       int n = 0;
     while (n < conf.size()) {
        emailconf = (Company)conf.get(n);
        if(emailconf.getId().equals(smtpserver)){
        smtpservername = emailconf.getHost();
              
        }
        n++;
}
   }
         
} 
if(request.getParameter("addsmtpserver") != null){
            
      Company confi = new Company();
      DashboardModel dshboard = new DashboardModel();
      String host = request.getParameter("host");
        String port = request.getParameter("port");
        String username = request.getParameter("username");
       String password = request.getParameter("password");
        String auth = "true";
       String starttls = "true";
      emailconf.setHost(host); 
      emailconf.setPort(port); 
      emailconf.setUsername(username); 
      emailconf.setPassword(password);
      emailconf.setAuth(auth); 
      emailconf.setStarttls(starttls); 
      dshboard.CreateNewSMTPServerRecord(emailconf);
            
}

}catch(Exception e){
   out.println(e);
  }   
%>
<%
if(request.getParameter("updateuserrole") != null){
         
         String user_username = request.getParameter("user_username");
         String rol = request.getParameter("rolename2");
         String val = log.usernameValidation(user_username);
         if(val.equals("User already exists")){
             log.updateUserRecord(rol, user_username);
         }else{
%>
<script>
    window.onload = function () {
        alert("Username does not exist");
    };
</script>
<%
}
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap-clockpicker.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/github.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <!-- CSS Files -->
        <link href="assets/css/material-dashboard.css?v=2.1.1" rel="stylesheet" />
        <!-- CSS Just for demo purpose, don't include it in your project -->
        <link href="assets/demo/demo.css" rel="stylesheet" />
    </head>

    <body>

        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <form action="" method="post">
                        <div class="modal-header">
                            <h4 class="modal-title">New SMTP Server Config</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>

                        </div>
                        <div class="modal-body">

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="bmd-label-floating">Host.</label>
                                    <input type="text" name ="host"  class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Port.</label>
                                    <input type="text" name ="port"  class="form-control" required>
                                </div>

                                <div class="form-group">
                                    <label class="bmd-label-floating">Username.</label>
                                    <input type="text" name ="username"  class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Password.</label>
                                    <input type="text" name ="password"  class="form-control" required>
                                </div>



                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal"><i  class="material-icons">close</i></button>
                            <button type="submit" name="addsmtpserver" value="addmember" class="btn btn-primary" ><i  class="material-icons">add</i></button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
        <script>

    function pickSelection(value) {

        if (document.getElementById("msgtype").value === "5" || document.getElementById("msgtype").value === "10") {

            document.getElementById("clock").style.display = "block";
            document.getElementById("placeholder1").style.display = "none";
            if (document.getElementById("msgtype").value === "5") {
                document.getElementById("placeholder2").style.display = "inline";
            }
            document.getElementById("placeholder3").style.display = "none";
            document.getElementById("placeholder4").style.display = "none";
             document.getElementById("placeholder6").style.display = "none";
             document.getElementById("placeholder7").style.display = "none";
            if (document.getElementById("msgtype").value === "10") {
                document.getElementById("placeholder5").style.display = "inline";
            }
        } else if (document.getElementById("msgtype").value === "7") {
            document.getElementById("clock").style.display = "block";
            document.getElementById("placeholder3").style.display = "inline";
            document.getElementById("placeholder1").style.display = "none";
            document.getElementById("placeholder2").style.display = "none";
            document.getElementById("placeholder4").style.display = "none";
            document.getElementById("placeholder5").style.display = "none";
            document.getElementById("placeholder6").style.display = "none";
            document.getElementById("placeholder7").style.display = "none";
        } else {
            document.getElementById("clock").style.display = "none";
            if (document.getElementById("msgtype").value === "6" || document.getElementById("msgtype").value === "1" || document.getElementById("msgtype").value === "3") {
                document.getElementById("placeholder1").style.display = "none";
                document.getElementById("placeholder2").style.display = "inline";
                document.getElementById("placeholder3").style.display = "none";
                document.getElementById("placeholder4").style.display = "none";
                document.getElementById("placeholder5").style.display = "none";
                document.getElementById("placeholder6").style.display = "none";
                document.getElementById("placeholder7").style.display = "none";
            } else if (document.getElementById("msgtype").value === "8" || document.getElementById("msgtype").value === "9" ) {
                document.getElementById("placeholder1").style.display = "none";
                document.getElementById("placeholder2").style.display = "none";
                document.getElementById("placeholder3").style.display = "none";
                document.getElementById("placeholder4").style.display = "inline";
                document.getElementById("placeholder5").style.display = "none";
                document.getElementById("placeholder6").style.display = "none";
                document.getElementById("placeholder7").style.display = "none";
            }else if (document.getElementById("msgtype").value === "13" || document.getElementById("msgtype").value === "14" ) {
                document.getElementById("placeholder1").style.display = "none";
                document.getElementById("placeholder2").style.display = "none";
                document.getElementById("placeholder3").style.display = "none";
                document.getElementById("placeholder4").style.display = "none";
                document.getElementById("placeholder5").style.display = "none";
                document.getElementById("placeholder6").style.display = "none";
                document.getElementById("placeholder7").style.display = "inline";
            } else if (document.getElementById("msgtype").value === "11") {
                document.getElementById("placeholder1").style.display = "none";
                document.getElementById("placeholder2").style.display = "none";
                document.getElementById("placeholder3").style.display = "none";
                document.getElementById("placeholder4").style.display = "none";
                document.getElementById("placeholder5").style.display = "inline";
                document.getElementById("placeholder6").style.display = "none";
                document.getElementById("placeholder7").style.display = "none";
            }else if (document.getElementById("msgtype").value === "12") {
                document.getElementById("placeholder1").style.display = "none";
                document.getElementById("placeholder2").style.display = "none";
                document.getElementById("placeholder3").style.display = "none";
                document.getElementById("placeholder4").style.display = "none";
                document.getElementById("placeholder5").style.display = "none";
                document.getElementById("placeholder6").style.display = "inline";
                document.getElementById("placeholder7").style.display = "none";
            }
            else {
                document.getElementById("placeholder1").style.display = "inline";
                document.getElementById("placeholder2").style.display = "none";
                document.getElementById("placeholder3").style.display = "none";
                document.getElementById("placeholder4").style.display = "none";
                document.getElementById("placeholder5").style.display = "none";
                document.getElementById("placeholder6").style.display = "none";
                document.getElementById("placeholder7").style.display = "none";
            }
        }
        var xmlhttp = new XMLHttpRequest();

        if (value !== "") {
            var url = "./Nav?msg=" + value;

            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                    if (xmlhttp.responseText !== "" && xmlhttp.responseText !== null) {
                        document.getElementById("msg12").innerHTML = xmlhttp.responseText;
                        if (document.getElementById("msgtype").value === "5" || document.getElementById("msgtype").value === "7" || document.getElementById("msgtype").value === "10") {
                            var xmhttp = new XMLHttpRequest();
                            var url = "./Nav?msgtime=" + value;
                            xmhttp.onreadystatechange = function () {
                                if (xmhttp.readyState === 4 && xmhttp.status === 200) {
                                    if (xmhttp.responseText !== "" && xmhttp.responseText !== null) {

                                        document.getElementById("broadcast_time").value = xmhttp.responseText;
                                    }
                                }

                            };
                            try {
                                xmhttp.open("GET", url, true);
                                xmhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                                xmhttp.send();

                            } catch (e) {
                                alert("unable to connect to server");
                            }
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
    function roleFetch(value) {

        if (value === "Admin") {
            document.getElementById("role1").style.display = "block";
            document.getElementById("role2").style.display = "block";
            document.getElementById("role3").style.display = "none";
            document.getElementById("role4").style.display = "none";
        } else {
            document.getElementById("role1").style.display = "none";
            document.getElementById("role2").style.display = "none";
            document.getElementById("role3").style.display = "block";
            document.getElementById("role4").style.display = "block";
        }
    }
    function datevalue(v) {
        var value = new Date(v);
        var value2 = new Date(v);
        value.setDate(value.getDate() - 1);
        value2.setDate(value2.getDate());
        var dd = value.getDate();
        var dd1 = value2.getDate();
        var mm = value.getMonth() + 1;
        var mm1 = value2.getMonth() + 1;
        if (dd.toString().length === 1) {
            dd = "0" + dd;
        }
        if (dd1.toString().length === 1) {
            dd1 = "0" + dd1;
        }
        if (mm.toString().length === 1) {
            mm = "0" + mm;
        }
        if (mm1.toString().length === 1) {
            mm1 = "0" + mm1;
        }
        var yyyy = value.getFullYear();
        var yyyy1 = value2.getFullYear();
        var newdate = yyyy + "-" + mm + "-" + dd;
        var newdate1 = yyyy1 + "-" + mm1 + "-" + dd1;
        document.getElementById("myDate").max = newdate;
        document.getElementById("myDate1").max = newdate;
        document.getElementById("myDate2").max = newdate1;
    }
    function TextFieldGenerator(value) {
        var count = 0;
        var even = 0;
        var html = "";
        if (value < 1) {
            document.getElementById("injected").innerHTML = "";
        }

        while (count < value) {
            even = value - count;

            if (even % 2 === 0 || even > 2) {
                html += "<div class='row'><div class='col-md-6'>" +
                        "<div class='form-group'><label class='bmd-label-floating'>Name of Seat " + (count + 1) + ".</label>" +
                        "<input type='text' name ='seatnum" + (count + 1) + "' class='form-control' required></div></div>" +
                        "<div class='col-md-6'><div class='form-group'><label class='bmd-label-floating'>Name of Seat " + (count + 2) + ".</label>" +
                        "<input type='text' name ='seatnum" + (count + 2) + "' class='form-control' required></div></div></div>";
                document.getElementById("injected").innerHTML = html;
                count = count + 2;
            } else {
                html += "<div class='row'><div class='col-md-6'><div class='form-group'>" +
                        "<label class='bmd-label-floating'>Name of Seat " + (count + 1) + ".</label>" +
                        "<input type='text' name ='seatnum" + (count + 1) + "' class='form-control' required></div></div></div>";
                document.getElementById("injected").innerHTML = html;
                count = count + 2;
            }


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
                                <li style="display: <%=li6%>;" class="nav-item"><a class="nav-link" href="./Nav?area=user-profile">
                                        <i class="material-icons">people</i>
                                        <p>User Management</p>
                                    </a></li>
                                <li style="display: <%=li7%>;" class="nav-item"> <a class="nav-link" href="./Nav?area=org-profile">
                                        <i class="material-icons">location_city</i>
                                        <p>Organization Profile</p>
                                    </a></li>
                                <li style="display: <%=li8%>;" class="nav-item active"><a class="nav-link" href="./Nav?area=config"><i class="material-icons">settings</i><p style="color:white;">Configurations</p></a></li>
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
                            <a class="navbar-brand" href="#pablo">Configuration</a>
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
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item" style="background-color: #dfbae6;">
                                <a class="nav-link active" data-toggle="tab" href="#home">Message Config</a>
                            </li>
                            <li class="nav-item" style="background-color: #dfbae6;">
                                <a class="nav-link" data-toggle="tab" href="#menu1">Email/SMS Config</a>
                            </li>
                            <li class="nav-item" style="background-color: #dfbae6;">
                                <a class="nav-link" data-toggle="tab" href="#menu2">Role Config</a>
                            </li>
                            <li class="nav-item" style="background-color: #dfbae6;">
                                <a class="nav-link" data-toggle="tab" href="#menu3">Election Config</a>
                            </li>
                        </ul>

                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div id="home" class="container tab-pane active"><br>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header card-header-primary">
                                                <form action="./Nav?area=user-profile" method="post">
                                                    <h4 class="card-title">Message Configuration
                                                    </h4>
                                                </form>
                                                <!--<p class="card-category">Edit your profile</p>-->
                                            </div>
                                            <div class="card-body">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group" style="background-color: #e9ecef; ">
                                                            Placeholder Options:&nbsp;&nbsp;  <span id="placeholder1" style="display: inline;"><b>#firstname#&nbsp;&nbsp;&nbsp; #lastname#&nbsp;&nbsp;&nbsp; #organizationName# &nbsp;&nbsp;&nbsp;#username#&nbsp;&nbsp;&nbsp;#password#  </b> </span>
                                                            <span id="placeholder2" style="display: none;"><b>#fullname#&nbsp;&nbsp;&nbsp; #memberid#&nbsp;&nbsp;&nbsp; #organizationName# </b> </span>
                                                            <span id="placeholder3" style="display: none;"><b>#alias#&nbsp;&nbsp;&nbsp;#fullname#&nbsp;&nbsp;&nbsp; #memberid#</b> </span>
                                                            <span id="placeholder4" style="display: none;"><b>#fullname#&nbsp;&nbsp;&nbsp; #contribution#&nbsp;&nbsp;&nbsp; #event#&nbsp;&nbsp;&nbsp; #startdate# &nbsp;&nbsp;&nbsp; #enddate#</b> </span>
                                                            <span id="placeholder5" style="display: none;"><b>#fullname#&nbsp;&nbsp;&nbsp; #electiontoken# </b> </span>
                                                            <span id="placeholder6" style="display: none;"><b>#fullname#&nbsp;&nbsp;&nbsp; #seatname#&nbsp;&nbsp;&nbsp; #electionname# </b> </span>
                                                            <span id="placeholder7" style="display: none;"><b>#fullname#&nbsp;&nbsp;&nbsp; #beneficiaryAmount#&nbsp;&nbsp;&nbsp; #event# &nbsp;&nbsp;&nbsp; #eventdate# </b> </span>
                                                        </div>
                                                        <!--<p>#contributionAmount#</p>-->
                                                    </div>
                                                </div>
                                                <form action="" method="post">
                                                    <div class="row">
                                                        <div class="col-md-9">
                                                            <div class="form-group">
                                                                <label class="bmd-label-floating">Message Type.</label>
                                                                <select id = "msgtype" name ="msgtype" class="form-control" onchange="pickSelection(this.value)">
                                                                    <option value=""></option>
                                                                    <option value="1">New Member Welcome Message(SMS)</option>
                                                                    <option value="2">New User Welcome message(SMS)</option>
                                                                    <option value="3">New Member Welcome Message(Email)</option>
                                                                    <option value="4">New User Welcome message(Email)</option>
                                                                    <option value="5">BirthDay Message(SMS)</option>
                                                                    <option value="6">BirthDay Message(Email)</option>
                                                                    <option value="7">BirthDay Alert for Admin(s) </option>
                                                                    <option value="8">Contribution Alert(SMS)</option>
                                                                    <option value="9">Contribution Alert(Email)</option>
                                                                    <option value="10">Election Token(SMS)</option>
                                                                    <option value="11">Election Token(Email)</option>
                                                                    <option value="12">Candidate Alert (SMS/Email)</option>
                                                                    <option value="13">Beneficiary Alert(SMS)</option>
                                                                    <option value="14">Beneficiary Alert(Email)</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-3">
                                                            <div class="clearfix form-group" id="clock" style="display: none;">
                                                                <label class="bmd-label-floating">Time of Message Transfer.</label>
                                                                <div class="input-group clockpicker-with-callbacks">
                                                                    <input type="text" class="form-control" value="00:00" id="broadcast_time" name = "broadcast_time">
                                                                    <span class="input-group-addon">
                                                                        <span class="glyphicon glyphicon-time"></span>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <script type="text/javascript">
                                                                var input = $('.clockpicker-with-callbacks').clockpicker({
                                                                    donetext: 'Done',
                                                                    init: function () {
                                                                        console.log("colorpicker initiated");
                                                                    },
                                                                    beforeShow: function () {
                                                                        console.log("before show");
                                                                    },
                                                                    afterShow: function () {
                                                                        console.log("after show");
                                                                    },
                                                                    beforeHide: function () {
                                                                        console.log("before hide");
                                                                    },
                                                                    afterHide: function () {
                                                                        console.log("after hide");
                                                                    },
                                                                    beforeHourSelect: function () {
                                                                        console.log("before hour selected");
                                                                    },
                                                                    afterHourSelect: function () {
                                                                        console.log("after hour selected");
                                                                    },
                                                                    beforeDone: function () {
                                                                        console.log("before done");
                                                                    },
                                                                    afterDone: function () {
                                                                        console.log("after done");
                                                                    }
                                                                });

                                                                // Manually toggle to the minutes view
                                                                $('#check-minutes').click(function (e) {
                                                                    // Have to stop propagation here
                                                                    e.stopPropagation();
                                                                    input.clockpicker('show')
                                                                            .clockpicker('toggleView', 'minutes');
                                                                });

                                                                function validate() {
                                                                    var election_Startdate = new Date(document.getElementById("election_date").value);
                                                                    var election_Enddate = new Date(document.getElementById("election_date2").value);
                                                                    if (election_Startdate > election_Enddate) {
                                                                        alert("Election start date cannot be after election end date");
                                                                        return false;
                                                                    } else {
                                                                        return true;
                                                                    }
                                                                }
                                                            </script>
                                                        </div>


                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label>Message</label>
                                                                <div class="form-group">
                                                                    <textarea class="form-control" rows="2" id="msg12" name ="msg" required></textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <button type="submit" name ="updatemessage" class="btn btn-primary pull-right">Update</button>
                                                    <div class="clearfix"></div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="menu1" class="container tab-pane fade"><br>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-header card-header-primary">
                                                <form action="./Nav?area=config" method="post">
                                                    <h4 class="card-title">Email Configuration
                                                        <!-- Trigger the modal with a button -->
                                                        <button type="button" style="float:right;" class="btn btn-primary" data-toggle="modal" data-target="#myModal"><i  class="material-icons">add</i></button>
                                                        <!-- Modal -->
                                                    </h4>
                                                </form>
                                                <!--<p class="card-category">Edit your profile</p>-->
                                            </div>
                                            <div class="card-body">
                                                <form action="" method="post">

                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="bmd-label-floating">Choose SMTP server(s).</label>
                                                                <select name ="smtpserver" value="" class="form-control">
                                                                    <option value="" selected><%=smtpservername%></option>
                                                                    <%
                                                                                   int i = 0;
                                                                            while (i < conf.size()) {
                                                                                 emailconf = (Company)conf.get(i);
                                               
                                                                    %>
                                                                    <option value="<%=emailconf.getId()%>"><%=emailconf.getHost()%></option>
                                                                    <%
                                                                    i++;
                                                                    }%>
                                                                </select>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <button type="submit" name ="updatesmtpserver" class="btn btn-primary pull-right">Update</button>
                                                    <div class="clearfix"></div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-header card-header-primary">
                                                <form action="./Nav?area=user-profile" method="post">
                                                    <h4 class="card-title">SMS Configuration
                                                    </h4>
                                                </form>
                                                <!--<p class="card-category">Edit your profile</p>-->
                                            </div>
                                            <div class="card-body">
                                                <form action="" method="post">

                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="bmd-label-floating">Choose SMS API.</label>
                                                                <select name ="smsapi" value="" class="form-control">
                                                                    <option value="" selected><%=smsservername%></option>
                                                                    <option value="1">Phalco API</option>
                                                                    <option value="2">Wirepick API</option>
                                                                    <option value="3">Hubtel API</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <button type="submit" name ="updatesmsserver" class="btn btn-primary pull-right">Update</button>
                                                    <div class="clearfix"></div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="menu2" class="container tab-pane fade"><br>

                                <div class="row">                                
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-header card-header-primary">

                                                <h4 class="card-title">Role Configuration
                                                </h4>

                                                <!--<p class="card-category">Edit your profile</p>-->
                                            </div>
                                            <div class="card-body">
                                                <form action="" method="post">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="bmd-label-floating">Role</label>
                                                                <select name ="rolename" value="" class="form-control" onchange="roleFetch(this.value)"  required>

                                                                    <option value="Admin" selected>Admin</option>
                                                                    <option value="User">User</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="row" id ="role1" style="display: block;">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="checkbox"><input type="checkbox" name="member" <%=checkValue1%> /> Member Management </label>
                                                                <label class="checkbox"><input type="checkbox" name="event" <%=checkValue2%> /> Events</label>
                                                                <label class="checkbox"><input type="checkbox"name="contribution" <%=checkValue3%> /> Contributions </label>
                                                                <label class="checkbox"><input type="checkbox" name="bulksms" <%=checkValue4%> /> Bulk SMS </label>

                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="row" id ="role2" style="display: block;">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="checkbox"><input type="checkbox" name="report" <%=checkValue5%> /> Reports </label>
                                                                <label class="checkbox"><input type="checkbox" name="user" <%=checkValue6%> /> User Management</label>
                                                                <label class="checkbox"><input type="checkbox" name="orgprofile" <%=checkValue7%> /> Organization Profile</label>
                                                                <label class="checkbox"><input type="checkbox"name="configuration" <%=checkValue8%> /> Configurations</label>

                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="row" id ="role3" style="display: none;">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="checkbox"><input type="checkbox" name="member1" <%=checkValue9%> /> Member Management </label>
                                                                <label class="checkbox"><input type="checkbox" name="event1" <%=checkValue10%> /> Events</label>
                                                                <label class="checkbox"><input type="checkbox"name="contribution1" <%=checkValue11%> /> Contributions </label>
                                                                <label class="checkbox"><input type="checkbox" name="bulksms1" <%=checkValue12%> disabled /> Bulk SMS </label>

                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="row" id ="role4" style="display: none;">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="checkbox"><input type="checkbox" name="report1" <%=checkValue13%> /> Reports </label>
                                                                <label class="checkbox"><input type="checkbox" name="user1" <%=checkValue14%> /> User Management</label>
                                                                <label class="checkbox"><input type="checkbox" name="orgprofile1" <%=checkValue15%> /> Organization Profile</label>
                                                                <label class="checkbox"><input type="checkbox"name="configuration1" <%=checkValue16%> disabled /> Configurations</label>

                                                            </div>
                                                        </div>

                                                    </div>
                                                    <button type="submit" name ="updaterole" class="btn btn-primary pull-right">Update</button>
                                                    <div class="clearfix"></div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-header card-header-primary">
                                                <form action="./Nav?area=user-profile" method="post">
                                                    <h4 class="card-title">User Role Configuration
                                                    </h4>
                                                </form>
                                                <!--<p class="card-category">Edit your profile</p>-->
                                            </div>
                                            <div class="card-body">
                                                <form action="" method="post">
                                                    <div class="row">

                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="bmd-label-floating">Username</label>
                                                                <input type="text" name ="user_username" class="form-control" required>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="bmd-label-floating">Role</label>
                                                                <select name ="rolename2" value="" class="form-control" required>
                                                                    <option value="" selected></option>
                                                                    <option value="1">Super</option>
                                                                    <option value="2">Admin</option>
                                                                    <option value="3">User</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <button type="submit" name ="updateuserrole" class="btn btn-primary pull-right">Update</button>
                                                    <div class="clearfix"></div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="menu3" class="container tab-pane fade"><br>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header card-header-primary">
                                                <form action="./Nav?area=user-profile" method="post">
                                                    <h4 class="card-title">Election Configuration
                                                    </h4>
                                                </form>
                                                <!--<p class="card-category">Edit your profile</p>-->
                                            </div>
                                            <div class="card-body">

                                                <form action="" method="post" onsubmit="return validate();">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label class="bmd-label-floating">Election Name.</label>
                                                                <input type="text" name ="election_name" class="form-control" required>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label class="bmd-label-floating">Election Start Date.</label>
                                                                <input type="text" id = "election_date" onblur = "datevalue(this.value)" name ="election_date" class="form-control datetimepicker" value="21/06/2018" required>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label class="bmd-label-floating">Election End Date.</label>
                                                                <input type="text" id = "election_date2" name ="election_date2" class="form-control datetimepicker" value="21/06/2018" required>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="bmd-label-floating">Candidate Form opening Date.</label>
                                                                <input type="date" min="<%=fo%>" max="<%=fo1%>" id="myDate" name ="opening_date"  class="form-control" required>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="bmd-label-floating">Candidate Form closing Date.</label>
                                                                <input type="date" min="<%=fo%>" max="<%=fo1%>" id="myDate1" name ="closing_date" class="form-control" required>
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="row">

                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="bmd-label-floating">Token Broadcast Date.</label>
                                                                <input type="date" min="<%=fo%>" max="<%=fo2%>" id="myDate2" name ="token_date" class="form-control" required>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label class="bmd-label-floating">Number of Seats.</label>
                                                                <input type="number" min="0" name ="num_of_seats" class="form-control" onchange="TextFieldGenerator(this.value)" required>
                                                            </div>
                                                        </div>
                                                    </div>




                                                    <div id="injected">

                                                    </div>
                                                    <button type="submit" name ="electionconfig" class="btn btn-primary pull-right">Submit</button>
                                                    <div class="clearfix"></div>
                                                </form>
                                            </div>
                                        </div>
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
                                window.onload = function () {
                                    alert("<%=response.getHeader("msg")%>");
                                };

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
            var todayDate = new Date().getDate();
            
            $('.datetimepicker').datetimepicker({
                format: "YYYY-MM-DD HH:mm:ss",
                minDate: new Date(new Date(new Date().setDate(todayDate + 2)).setHours(0, 0, 0, 0)),
                icons: {
                    time: "fa fa-clock-o",
                    date: "fa fa-calendar",
                    up: "fa fa-chevron-up",
                    down: "fa fa-chevron-down",
                    previous: 'fa fa-chevron-left',
                    next: 'fa fa-chevron-right',
                    today: 'fa fa-screenshot',
                    clear: 'fa fa-trash',
                    close: 'fa fa-remove'
                }
            });


        </script>
       <script type="text/javascript" src="assets/js/jquery.min.js"></script>
        <script type="text/javascript" src="assets/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="assets/js/bootstrap-clockpicker.min.js"></script>
        <script type="text/javascript">
            $('.clockpicker').clockpicker()
                    .find('input').change(function () {
                console.log(this.value);
            });
            var input = $('#single-input').clockpicker({
                placement: 'bottom',
                align: 'left',
                autoclose: true,
                'default': 'now'
            });

            $('.clockpicker-with-callbacks').clockpicker({
                donetext: 'Done',
                init: function () {
                    console.log("colorpicker initiated");
                },
                beforeShow: function () {
                    console.log("before show");
                },
                afterShow: function () {
                    console.log("after show");
                },
                beforeHide: function () {
                    console.log("before hide");
                },
                afterHide: function () {
                    console.log("after hide");
                },
                beforeHourSelect: function () {
                    console.log("before hour selected");
                },
                afterHourSelect: function () {
                    console.log("after hour selected");
                },
                beforeDone: function () {
                    console.log("before done");
                },
                afterDone: function () {
                    console.log("after done");
                }
            })
                    .find('input').change(function () {
                console.log(this.value);
            });

            // Manually toggle to the minutes view
            $('#check-minutes').click(function (e) {
                // Have to stop propagation here
                e.stopPropagation();
                input.clockpicker('show')
                        .clockpicker('toggleView', 'minutes');
            });
            if (/mobile/i.test(navigator.userAgent)) {
                $('input').prop('readOnly', true);
            }

        </script>
    </body>
</html>
