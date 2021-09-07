<%-- 
    Document   : register
    Created on : Aug 15, 2019, 2:33:15 AM
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
         eType = loginCred.fetchElections();
     
      orgs = (Organization)loginCred.fetchOrganizationDetails().get(0);
      organization_name = orgs.getName();
     }catch(Exception e){
  out.println(e);
 }
%>
<html>
    <head>
        <!-- Required meta tags-->
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Colorlib Templates">
        <meta name="author" content="Colorlib">
        <meta name="keywords" content="Colorlib Templates">

        <!-- Title Page-->
        <title>GPMS - Register</title>

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
        <link href="assets/css/cropper.css" rel="stylesheet">
<style>
            .eg-container {
                padding-top: 15px;
                padding-bottom: 15px;


            }

            .eg-main {
                max-height: 250px;
                margin-bottom: 30px;

            }

            .eg-wrapper {
                background-color: #f7f7f7;

                border: 1px solid #eee;
                display: inline-block;
                height: 250px;
                width: 100%;
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
                cFlag = true;
               
            }

            function validate()
            {
                if (cFlag)
                {
                    return cFlag;
                } else
                {
                    $("#err").text("Please crop & save before submission");
                    $("#err").css("color", "red");
                    return cFlag;
                }

            }
        </script>

        <script type="text/javascript">
            function checkExist(value) {

                var xmlhttp = new XMLHttpRequest();
                var username = value;
                var parser, xmlDoc, result, i;
                var txt = "";
                if (username !== "") {
                    var url = "./Nav?sinput=" + value + "&opt=" + document.getElementById("options").value;
                    xmlhttp.onreadystatechange = function () {
                        if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {

                            document.getElementById("member_id").value = xmlhttp.responseText;


                            if (document.getElementById("options").value !== "") {
                                var xmhtt = new XMLHttpRequest();
                                var ul = "./Nav?svalue=" + value + "&opt=" + document.getElementById("options").value;
                                xmhtt.onreadystatechange = function () {
                                    if (xmhtt.readyState === 4 && xmhtt.status === 200) {
                                        if (xmhtt.responseText === "") {
                                            document.getElementById("member_name").innerHTML = "Your record cannot be found!";
                                        } else {

                                            document.getElementById("member_name").innerHTML = xmhtt.responseText;
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
                } else {
                    document.getElementById("member_name").innerHTML = "";
                }
            }

            function populateDropdown(value) {


                var username = value;
                var parser, xmlDoc, result, i;
                var txt = "<option disabled='disabled' selected='selected'>Select Election Seat</option>";
                if (username !== "") {
                    var xmht = new XMLHttpRequest();
                    var ull = "./Nav?eid=" + value;
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

                } else {
                    document.getElementById("list").innerHTML = "";
                }
            }

        </script>
    </head>
    <body>
        <div class="page-wrapper bg-blue p-t-100 p-b-100 font-robo">
            <div class="wrapper wrapper--w680">
                <div class="card card-1">
                    <div class="login100-form-avatar">
                            <img src="assets/img/profilepic/<%=orgs.getLogo()%>" alt="AVATAR" />
                      </div>
                    <div class="card-body">
                        <center><h1><%=organization_name%></h1>
                            <br /><br />
                            <% if(eType != null){%>
                            <h5 class="title">Election Candidate Form</h5></center>
                        <form action="./Registration" method="POST"  onsubmit="return validate();">


                            <div class="row row-space">
                                <div class="col-2">
                                    <div class="input-group">
                                        <b><input type="text" placeholder="Search for your record." class="input--style-1" readonly></b>

                                        <div class="rs-select2 js-select-simple select--no-search">
                                            <select name="options" id="options" required>
                                                <option disabled="disabled" selected="selected"
                                                        >Search Criteria</option
                                                >


                                                <option value="M">Member ID</option>
                                                <option value="P">Phone #</option>
                                                <option value="A">Alias</option>

                                            </select>
                                            <div class="select-dropdown"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <input type="text" placeholder="" class="input--style-1" readonly>

                                    <div class="input-group">
                                        <input  type="text"  name ="name" onBlur="checkExist(this.value)" placeholder="Search value"  class="input--style-1" required/>
                                    </div>
                                </div>
                            </div>      
                            <div class="row row-space">
                                <div class="input-group">

                                    <b><span id="member_name"></span> </b>
                                    <input type="hidden" name ="member_id" id="member_id"  class="input--style-1" required>

                                </div>
                            </div>


                            <div class="row row-space">
                                <div class="col-2">
                                    <div class="input-group">

                                        <div class="rs-select2 js-select-simple select--no-search">
                                            <select name="eid" id="eid" onchange="populateDropdown(this.value)" required>
                                                <option disabled="disabled" selected="selected"
                                                        >Select Election Type</option
                                                >


                                                <%
                                                        int i = 0;
                                          while (i < eType.size()) {
                                               elect_type = (ElectionType)eType.get(i);
                                                %>
                                                <option value="<%=elect_type.getId()%>"><%=elect_type.getElectionName()%></option>  
                                                <%i++;}%>    
                                            </select>
                                            <div class="select-dropdown"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="input-group">

                                        <div class="rs-select2 js-select-simple select--no-search">
                                            <select name="list" id="list" required>


                                            </select>
                                            <div class="select-dropdown"></div>
                                        </div>
                                    </div>
                                </div>

                            </div>


                            <div class="input-group">
                                <input type="text" placeholder="Manifesto" class="input--style-1" readonly>
                                <br />
                                <textarea type="text" name ="manifesto" id="manifesto" cols="60" row="20"  maxlength="160" class="input--style-1" required></textarea>

                            </div>
                            <div class="input-group">
                                <input type="text" placeholder="Upload Image & Crop" class="input--style-1" readonly>
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
                                                 <label class="btn btn-3 btn--radius btn--green" for="inputImage" title="Upload image file">
                                                     <input class="hide" id="inputImage" name="file" accept="image/*" type="file" required>
                                                   
                                                       Upload
                                                   
                                                </label>
                                                <button class="btn btn--radius btn--green" id="getDataURL" onclick="setCrop();" type="button" style="display: inline; color:white">Crop & Save</button>

                                            </div>

                                            <div class="row eg-output">
                                                <div class="col-md-12">
                                                    <div id="err"></div>
                                                </div>
                                                <div class="col-md-6">

                                                    <textarea name="image_file" style="display: none;"class="form-control" id="dataURL" rows="10"></textarea>

                                                    <!--imageupload-->


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
                            <div class="p-t-20">
                                <button class="btn btn--radius btn--green" type="submit" name="addmember">
                                    Submit
                                </button>
                            </div>
                        </form>
                        <%}else{%>
                         <center><h5>There are no upcoming elections!</h5></center>
                        <%}%>     
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
