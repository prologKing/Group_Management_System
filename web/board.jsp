<%-- 
    Document   : register
    Created on : Aug 15, 2019, 2:33:15 AM
    Author     : Developer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
     String res = ""; 
     String resp = request.getParameter("resp");
     String respo = request.getParameter("respo");
     if(resp != null){
    if(resp.equals("a")){
      res = "Registration Successful!! Kindly check your email for details. Thank you!";
  }else{
    
    res = "Your record didn't submit successfully. Either the email or mobile number you provided already exists in our records";
    }
     }
    if(respo != null){ 
  if (respo.equals("a")){
  res = "Your details have been recorded!! You are now an election candidate. Best of luck!";
  }else{
    res = "Your record didn't submit successfully. Please contact support...";
    }
    }
    
    
    %>
    <head>
        <!-- Required meta tags-->
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Colorlib Templates">
        <meta name="author" content="Colorlib">
        <meta name="keywords" content="Colorlib Templates">

        <!-- Title Page-->
        <title>Au Register Forms by Colorlib</title>

        <!-- Icons font CSS-->
        <link href="assets/register/vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
        <link href="assets/register/vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
        <!-- Font special for pages-->
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i" rel="stylesheet">

        <!-- Vendor CSS-->
        <link href="assets/register/vendor/select2/select2.min.css" rel="stylesheet" media="all">
        <link href="assets/register/vendor/datepicker/daterangepicker.css" rel="stylesheet" media="all">

        <!-- Main CSS-->
        <link href="assets/register/css/main.css" rel="stylesheet" media="all">
    </head>
    <body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
        <SCRIPT type="text/javascript">
            window.history.forward();
            function noBack() {
                window.history.forward();
            }
        </SCRIPT>
        <div class="page-wrapper bg-blue p-t-100 p-b-100 font-robo">
            <div class="wrapper wrapper--w680">
                <div class="card card-1">
                    <div class="card-heading"></div>
                    <div class="card-body">
                        <%=res%>

                    </div>
                </div>
            </div>
        </div>
        <!-- Jquery JS-->
        <script src="assets/register/vendor/jquery/jquery.min.js"></script>
        <!-- Vendor JS-->
        <script src="assets/register/vendor/select2/select2.min.js"></script>
        <script src="assets/register/vendor/datepicker/moment.min.js"></script>
        <script src="assets/register/vendor/datepicker/daterangepicker.js"></script>

        <!-- Main JS-->
        <script src="assets/register/js/global.js"></script>
    </body>
</html>
