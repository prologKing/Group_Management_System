<%-- 
    Document   : electionresult
    Created on : Sep 21, 2019, 10:44:35 AM
    Author     : Developer
--%>

<%@page import="com.gpms.pojo.*, org.apache.commons.lang3.StringUtils, java.util.*, java.text.SimpleDateFormat, java.time.LocalDate, java.time.format.DateTimeFormatter" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
 Organization orgs = null;
 VoteResult voteresult = null;
 ElectionSeat e_seat = null;
 String organization_name = "";
 String seatname = "";
List<String> list = new ArrayList<String>();
List<String> slist = new ArrayList<String>();
List<VoteResult> votelist = null;
List<VoteResult> votelist2 = null;
 List<ElectionSeat> seatlist = null;
 String e_id = request.getParameter("eid");
  String len= e_id.substring(6,7);
  String eid = e_id.substring(7,7 + Integer.parseInt(len));


     try{
         LoginModel loginCred = new LoginModel();
         DashboardModel dash = new DashboardModel();
         if(eid != null){
         votelist = dash.fetchVoteSummary(eid);
         votelist2 = dash.fetchVoteAnalysis(eid);
         seatlist = dash.fetchElectionSeats(eid);
         
         }

      orgs = (Organization)loginCred.fetchOrganizationDetails().get(0);
      organization_name = orgs.getName();
}catch(Exception e){
out.println(e);
}
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <title>Election Result</title>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <!-- Bootstrap core CSS -->
        <link href="assets/eresults/css/bootstrap.min.css" rel="stylesheet" />
        <!-- Material Design Bootstrap -->
        <link href="assets/eresults/css/mdb.min.css" rel="stylesheet" />
        <!-- Your custom styles (optional) -->
        <link href="assets/eresults/css/style.min.css" rel="stylesheet" />
    </head>
    <body class="grey lighten-3">
        <header>
            <!-- Sidebar -->
            <div class="sidebar-fixed position-fixed">
                <br />
                <br />
                <div class="login100-form-avatar">
                    <img src="assets/img/profilepic/<%=orgs.getLogo()%>" alt="AVATAR" />
                </div>


            </div>

            <!-- Sidebar -->
        </header>
        <!--Main Navigation-->

        <!--Main layout-->
        <main class="pt-5 mx-lg-5">
            <%
            if(votelist2.size()> 0){
            %>
            <div class="modal fade" id="modalLoginAvatarDemo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog cascading-modal modal-avatar modal-sm" role="document">
                    <!--Content-->
                    <div class="modal-content">

                        <!--Header-->
                        <div class="modal-header">
                            <canvas id="pie"></canvas>
                        </div>
                        <!--Body-->
                        <div class="modal-body text-center mb-1">

                            <h5 class="mt-1 mb-2">Eligible Vs. Actual Voters</h5>
                            <b><label for="form1" class="ml-0"># of Eligible voters</label></b>: <%=votelist.get(0).getNumOfEligibleVoters()%>
                            <b><label for="form1" class="ml-0"># of Actual voters</label></b>: <%=votelist.get(0).getNumOfVoters()%>

                        </div>

                    </div>
                    <!--/.Content-->
                </div>
            </div>
            <div class="container-fluid mt-5">
                <!-- Heading -->
                <div class="card mb-4 wow fadeIn">
                    <!--Card content-->
                    <div class="card-body unique-color">
                        <form action="./Nav?v=election_result" method="post">
                            <h4 class="text-center white-text">
                                <button type="button" style="float: left;" class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#modalLoginAvatarDemo">Votes Summary
                                </button><span><%=organization_name%> Election Result</span> 

                                <button type="submit" style="float: right;" class="btn btn-outline-info btn-sm"><i class="fas fa-backward mr-3"></i>Back
                                </button>



                            </h4>
                        </form>
                    </div>
                </div>

                <!-- Heading -->


                <%
                                    
                                          int p = 0;
                            while (p < seatlist.size()) {
                                 e_seat = (ElectionSeat)seatlist.get(p);
                                 if(e_seat.getNumberOfCandidatesPerSeat() > 0){
                                  list.add(String.valueOf(p));    
                             slist.add(e_seat.getSeatName());
                %>
                <!--Grid row-->
                <div class="row wow fadeIn">
                    <!--Grid column-->
                    <div class="col-md-9 mb-4">
                        <!--Card-->
                        <div class="card">
                            <div class="card-header text-center">
                                <span style="display: block; font-size: 12px;"># OF CANDIDATES FOR <b><%=e_seat.getSeatName()%></b> POSITION: <%=e_seat.getNumberOfCandidatesPerSeat()%></span>
                                <span style="display: block; font-size: 12px;">TOTAL VOTES RECEIVED FOR <b><%=e_seat.getSeatName()%></b> POSITION: <%=e_seat.getNumberOfVotesReceived()%></span>
                            </div>
                            <!--Card content-->
                            <div class="card-body  d-sm-flex justify-content-between">

                                <canvas id="<%=p%>"></canvas>
                            </div>
                        </div>
                        <!--/.Card-->
                    </div>
                    <!--Grid column-->
                    <!--Card-->
                    <div class="col-md-3 mb-4">
                        <div class="card mb-4">

                            <!-- Card header -->
                            <div class="card-header text-center">
                                Vote Percentage(%) Per Candidate 
                            </div>

                            <!--Card content-->
                            <div class="card-body">

                                <canvas id="<%=p%>_"></canvas>

                            </div>

                        </div>
                    </div>
                    <!--Grid column-->
                </div>
                <%
                                    
                                
                }
p++;
}
                                
                %>

                <!--Grid row-->
            </div>
            <!--Grid row-->
            <%
            }else{
            %>
            <p>No results Found For election type!</p>
            <%
            }
            %>
        </main>
        <!--Main layout-->

        <!--Footer-->
        <footer
            class="page-footer text-center font-small primary-color-dark darken-2 mt-4 wow fadeIn"
            >
            <hr class="my-4" />

            <!--Copyright-->
            <div class="footer-copyright py-3">
                © 2019 Copyright:

                GPMS

            </div>
            <!--/.Copyright-->
        </footer>
        <!--/.Footer-->

        <!-- SCRIPTS -->
        <!-- JQuery -->
        <script type="text/javascript" src="assets/eresults/js/jquery-3.4.1.min.js"></script>
        <!-- Bootstrap tooltips -->
        <script type="text/javascript" src="assets/eresults/js/popper.min.js"></script>
        <!-- Bootstrap core JavaScript -->
        <script type="text/javascript" src="assets/eresults/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="assets/eresults/js/mdb.min.js"></script>
        <!-- Initializations -->
        <script type="text/javascript">
            // Animations initialization
            new WOW().init();
        </script>

        <!-- Charts -->
        <%
          int counter = 0;
          while(counter < list.size()){
        %>
        <script>


            var parser, xmlDoc, result, result2, i;
            var txt = "";
            var xmht = new XMLHttpRequest();
            var ull = "./Nav?e_id=<%=eid%>";
            xmht.onreadystatechange = function () {

                if (this.readyState === 4 && this.status === 200) {

                    parser = new DOMParser();
                    xmlDoc = parser.parseFromString(this.responseText, "text/xml");
                    result = xmlDoc.getElementsByTagName("item");
                    result2 = xmlDoc.getElementsByTagName("seat");
                    var ar = [];
                    var arr = [];
                    var arr2 = [];
                    var sum = 0;
                    var percentage = 0;
                    for (i = 0; i < result.length; i++) {


                        if ("<%=slist.get(counter)%>" === result2[i].childNodes[0].nodeValue) {

                            ar.push(result[i].childNodes[0].nodeValue);
                            arr.push(result[i].getAttribute('id'));
                            sum += parseFloat(result[i].getAttribute('id'));

                        }
                        if (i === result.length - 1) {
                            for (var l = 0; l < arr.length; l++) {
                                percentage = arr[l] / sum * 100;
                                arr2.push(percentage);
                            }
                        }

                    }


                    if (arr.length > 0 && ar.length > 0) {
                        var ctx = document.getElementById("<%=list.get(counter)%>").getContext("2d");
                        var myChart = new Chart(ctx, {
                            type: "bar",
                            data: {
                                labels: ar,
                                datasets: [
                                    {
                                        label: "# of Votes per Candidate",
                                        data: arr,
                                        backgroundColor: [
                                            "rgba(255, 99, 132, 0.8)",
                                            "rgba(54, 162, 235, 0.8)",
                                            "rgba(255, 206, 86, 0.8)",
                                            "rgba(75, 192, 192, 0.8)",
                                            "rgba(153, 102, 255, 0.8)",
                                            "rgba(255, 159, 64, 0.8)",
                                            "rgba(25, 179, 34, 0.8)"
                                        ],
                                        borderColor: [
                                            "rgba(255,99,132,1)",
                                            "rgba(54, 162, 235, 1)",
                                            "rgba(255, 206, 86, 1)",
                                            "rgba(75, 192, 192, 1)",
                                            "rgba(153, 102, 255, 1)",
                                            "rgba(255, 159, 64, 1)",
                                            "rgba(25, 179, 34, 1)"
                                        ],
                                        borderWidth: 1
                                    }
                                ]
                            },
                            options: {
                                scales: {
                                    yAxes: [
                                        {
                                            ticks: {
                                                beginAtZero: true
                                            }
                                        }
                                    ]
                                }
                            }
                        });
                        var ctxP = document.getElementById("<%=list.get(counter)%>_").getContext('2d');
                        var myPieChart = new Chart(ctxP, {
                            type: 'pie',
                            data: {
                                labels: ar,
                                datasets: [{
                                        data: arr2,
                                        backgroundColor: ["#F7464A", "#46BFBD", "#FDB45C", "#949FB1", "#4D5360", "#FF3D67", "#27A6FC"],
                                        hoverBackgroundColor: ["#FF5A5E", "#5AD3D1", "#FFC870", "#A8B3C5", "#616774", "#FF3D67", "#27A6FC"]
                                    }]
                            },
                            options: {
                                responsive: true,
                                legend: false
                            }
                        });
                    }




                }


            };
            try {
                xmht.open("GET", ull, true);
                xmht.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmht.send();
            } catch (e) {
                alert("unable to connect to server");
            }


        </script>
        <%
        counter++;
        }
        %>
        <script>
            var ctxP = document.getElementById("pie").getContext('2d');
            var myPieChart = new Chart(ctxP, {
                type: 'pie',
                data: {
                    labels: ["Eligible Voters", "Actual Voters"],
                    datasets: [{
                            data: [<%=votelist.get(0).getNumOfEligibleVoters()%>, <%=votelist.get(0).getNumOfVoters()%>],
                            backgroundColor: ["#F7464A", "#46BFBD", "#FDB45C", "#949FB1", "#4D5360", "#FF3D67", "#27A6FC"],
                            hoverBackgroundColor: ["#FF5A5E", "#5AD3D1", "#FFC870", "#A8B3C5", "#616774", "#FF3D67", "#27A6FC"]
                        }]
                },
                options: {
                    responsive: true,
                    legend: false
                }
            });
        </script>    
    </body>
</html>

