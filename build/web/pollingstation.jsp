<%-- 
    Document   : pollingstation
    Created on : Sep 7, 2019, 5:26:40 PM
    Author     : Developer
--%>

<%@page import="com.gpms.pojo.*, org.apache.commons.lang3.StringUtils, java.util.*, java.text.SimpleDateFormat, java.time.LocalDate, java.time.LocalDateTime, java.time.format.DateTimeFormatter" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
 Organization orgs = null;
 Candidate candidate = null;
 ElectionSeat e_seat = null;
 String organization_name = "";
 String result = "";
 String token = "";
 String electionEndDate = "";
 List<Candidate> canlist = null;
 List<ElectionSeat> seatlist = null;
 String eid = request.getParameter("eid");
 String mid = request.getParameter("id");
 String memberid = mid.substring(3,4);
 memberid += mid.substring(7,8);
 memberid += mid.substring(11,12);
 memberid += mid.substring(15,16);
     try{
         DashboardModel loginCred = new DashboardModel();
         if(eid != null){
         canlist = loginCred.fetchCandidates(eid);
         seatlist = loginCred.fetchElectionSeat(eid);
          String datetimevalue = loginCred.fetchElectionEndDate(eid);
         DateTimeFormatter f = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
         DateTimeFormatter g = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm:ss");
         LocalDateTime e_date = LocalDateTime.parse(datetimevalue, f);
         electionEndDate = e_date.format(g).toString();
         token = loginCred.fetchToken(eid, memberid);
         
         }
         if(request.getParameter("vote") != null){
                    int b = 0;
                    List<String> list = new ArrayList<String>();
                    while (b < canlist.size()) {
                         candidate = (Candidate)canlist.get(b);
                         
                         if(!list.contains(candidate.getSeatid())){
                         Vote vote = new Vote(request.getParameter(""+candidate.getSeatid()), candidate.getSeatid(), token);
                         result = loginCred.NewVote(vote);
                         list.add(candidate.getSeatid());
                         }
           b++;                                    
         
         }
            if(result.equals("Insert Operation Successful")){
%>
<script>
    window.onload = function () {
        alert("Your vote has been received!");
        document.location.href = './Nav?v=election_portal';
    };
</script>
<%
    
}
}
//      orgs = (Organization)loginCred.fetchOrganizationDetails().get(0);
//      organization_name = orgs.getName();
}catch(Exception e){
out.println(e);
}
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

        <!-- For Resposive Device -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Polling Station</title>




        <!-- Main style sheet -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <!-- responsive style sheet -->
        <link rel="stylesheet" type="text/css" href="assets/css/responsive.css">
        <style>
            .button {
                background-color: #4CAF50; /* Green */
                border: none;
                color: white;
                padding: 16px 32px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                -webkit-transition-duration: 0.4s; /* Safari */
                transition-duration: 0.4s;
                cursor: pointer;
            }
            .button2 {
                background-color: white; 
                color: black; 
                border: 2px solid #008CBA;
            }

            .button2:hover {
                background-color: #008CBA;
                color: white;
            }
            .li {
                display: inline-block;
                font-size: 1.5em;
                list-style-type: none;
                padding: 1em;
                text-transform: uppercase;
            }

            .li span {
                display: block;
                font-size: 4.5rem;
            }

        </style>
    </head>
    <body>
        <div class="main-page-wrapper">
            <center><ul>
                    <li class="li"><span id="days"></span>days</li>
                    <li class="li"><span id="hours"></span>Hours</li>
                    <li class="li"><span id="minutes"></span>Minutes</li>
                    <li class="li"><span id="seconds"></span>Seconds</li>
                </ul> 
            </center>
            <!--
            =====================================================
                    Team Section
            =====================================================
            -->
            <div id="team-section">
                <form action="" method="post">
                    <button type="submit" name="vote" class="button button2" style="float:right; margin-right: 20px; margin-top: 20px;">Submit Your Vote</button>
                    <div class="container">


                        <%
                                                           int p = 0;
                                             while (p < seatlist.size()) {
                                                  e_seat = (ElectionSeat)seatlist.get(p);
                                                  if(e_seat.getNumberOfCandidatesPerSeat() > 0){
                        %>
                        <div class="theme-title">

                            <h2><%=e_seat.getSeatName()%> Category</h2> 
                            <p>You can only vote for one candidate in each category.</p>

                        </div> <!-- /.theme-title -->

                        <div class="clear-fix team-member-wrapper">
                            <%
                                                            int i = 0;
                                              while (i < canlist.size()) {
                                                   candidate = (Candidate)canlist.get(i);
                                                    if(candidate.getSeatname().equals(e_seat.getSeatName())){
                            %>


                            <div class="float-left">
                                <div class="single-team-member">
                                    <div class="img">
                                        <img src="assets/img/profilepic/<%=candidate.getCampaignpic()%>" alt="Image" width="360px" height="360px">
                                        <div class="opacity tran4s">

                                            <h4><%=candidate.getMembername()%></h4>
                                            <span>Vying for: <%=candidate.getSeatname()%></span>
                                            <p>Brief Manifesto: <%=candidate.getManifesto()%></p>
                                        </div>
                                    </div> <!-- /.img -->
                                    <div class="member-name">
                                        <h6><%=candidate.getMembername()%></h6>
                                        <p>Vying for: <%=candidate.getSeatname()%></p>
                                        <ul>
                                            <li>
                                                <label class="radio">
                                                    <input type="radio" name="<%=candidate.getSeatid()%>" value="<%=candidate.getMemberid()%>" required>
                                                    <span>Vote for me!</span>
                                                </label>
                                            </li>
                                        </ul>

                                    </div> <!-- /.member-name -->
                                </div> <!-- /.single-team-member -->
                            </div> <!-- /float-left -->
                            <%}i++;}%> 
                        </div> <!-- /.team-member-wrapper -->
                        <%}p++;}%> 

                    </div> <!-- /.conatiner -->
                </form>
            </div> <!-- /#team-section -->






            <!--
            =====================================================
                    Footer
            =====================================================
            -->
            <footer>
                <div class="container">

                    <p>Copyright @2018 All rights reserved | Brought to you by GPMS</p>
                </div>
            </footer>




            <!-- =============================================
                    Loading Transition
            ============================================== -->
            <div id="loader-wrapper">
                <div id="preloader_1">
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>


            <!-- Scroll Top Button -->
            <button class="scroll-top tran3s p-color-bg">
                <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
            </button>


            <script type="text/javascript" src="assets/vendor/jquery.2.2.3.min.js"></script>
            <script type="text/javascript" src="assets/js/theme.js"></script>
            <script>
// Set the date we're counting down to
    var countDownDate = new Date("<%=electionEndDate%>").getTime();

// Update the count down every 1 second
    var x = setInterval(function () {

        // Get today's date and time
        var now = new Date().getTime();

        // Find the distance between now and the count down date
        var distance = countDownDate - now;

        // Time calculations for days, hours, minutes and seconds
        var days = Math.floor(distance / (1000 * 60 * 60 * 24));
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        // Output the result in an element with id="demo"

        document.getElementById('days').innerText = days,
                document.getElementById('hours').innerText = hours,
                document.getElementById('minutes').innerText = minutes,
                document.getElementById('seconds').innerText = seconds;

        // If the count down is over, write some text 
        if (distance < 0) {
            clearInterval(x);
            document.location.href = './Nav?v=election_portal';
        }
    }, 1000);
            </script>

        </div>
    </body>
</html>
