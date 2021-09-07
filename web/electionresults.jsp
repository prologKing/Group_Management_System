<%-- 
    Document   : polling
    Created on : Sep 8, 2019, 8:16:59 PM
    Author     : Developer
--%>

<%@page import="com.gpms.pojo.*, org.apache.commons.lang3.StringUtils, java.util.*, java.text.SimpleDateFormat, java.time.LocalDate, java.time.format.DateTimeFormatter" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
 Organization orgs = null;
 ElectionType elect_type = null;
 String organization_name = "";
 List<ElectionType> eType = null;
     try{
         
        
         LoginModel loginCred = new LoginModel();
         eType = loginCred.fetchAllElections();
     
      orgs = (Organization)loginCred.fetchOrganizationDetails().get(0);
      organization_name = orgs.getName();
     }catch(Exception e){
  out.println(e);
 }
%>
<html>
    <head>
        <title>Login V12</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--===============================================================================================-->
        <link rel="icon" type="image/png" href="assets/img/icons/favicon.ico" />
        <!--===============================================================================================-->
        <link
            rel="stylesheet"
            type="text/css"
            href="assets/vendor/bootstrap/css/bootstrap.min.css"
            />
        <!--===============================================================================================-->
        <link
            rel="stylesheet"
            type="text/css"
            href="assets/fonts/font-awesome-4.7.0/css/font-awesome.min.css"
            />
        <!--===============================================================================================-->
        <link
            rel="stylesheet"
            type="text/css"
            href="assets/fonts/Linearicons-Free-v1.0.0/icon-font.min.css"
            />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="assets/vendor/animate/animate.css" />
        <!--===============================================================================================-->
        <link
            rel="stylesheet"
            type="text/css"
            href="assets/vendor/css-hamburgers/hamburgers.min.css"
            />
        <!--===============================================================================================-->
        <link
            rel="stylesheet"
            type="text/css"
            href="assets/vendor/select2/select2.min.css"
            />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="assets/css/inner_css/util.css" />
        <link rel="stylesheet" type="text/css" href="assets/css/inner_css/main.css" />
        <!--===============================================================================================-->
    </head>
    <body>
        <div class="limiter">
            <div
                class="container-login100"
                style="background-image: url('assets/img/img-01.jpg');"
                >
                <div class="wrap-login100 p-t-190 p-b-30">
                    <form class="login100-form validate-form" method="post" action="">
                        <div class="login100-form-avatar">
                            <img src="assets/img/profilepic/<%=orgs.getLogo()%>" alt="AVATAR" />
                        </div>

                        <span class="login100-form-title p-t-20 p-b-45">
                            <h2> <%=organization_name%> </h2>
                            <br /> 
                            <h5>Election Results Portal</h5>
                        </span>

                        <div class="wrap-input100 validate-input m-b-10"
                             data-validate="Election type is required">

                            <select class="input100" name="electionid" id="electionid" required>
                                <option disabled="disabled" selected="selected"
                                        >Select Election Type</option>
                                <%
                                                                        int i = 0;
                                                                        if(eType != null){
                                                          while (i < eType.size()) {
                                                               elect_type = (ElectionType)eType.get(i);
                                                               
                                %>
                                
                                <option value="<%=elect_type.getId()%>"><%=elect_type.getElectionName()%></option>  
                                <%i++;}}%>  
                            </select>
                            <div class="select2-selection__arrow"></div>
                        </div>


                        <div class="container-login100-form-btn p-t-10">
                            <button class="login100-form-btn" type="button" name="submit" onclick="validate()">
                                View Result
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            function makeid(length) {
                var result = '';
                var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
                var charactersLength = characters.length;
                for (var i = 0; i < length; i++) {
                    result += characters.charAt(Math.floor(Math.random() * charactersLength));
                }
                return result;
            }
            function validate() {
                var value = document.getElementById("electionid").value;
                if(value !== "" && value !== null && value !== "Select Election Type"){
                    
                newString = makeid(3) + makeid(3) +value.length+document.getElementById("electionid").value + makeid(3)+ makeid(3);
                document.location.href = './Nav?v=election_result&eid=' + newString;
            }else{
                alert("Select Election Type..");
            }
            }

        </script>
        <!--===============================================================================================-->
        <script src="assets/vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="assets/vendor/bootstrap/js/popper.js"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="assets/vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="assets/js/main.js"></script>
    </body>

</html>
