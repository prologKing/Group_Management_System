<%-- 
    Document   : register
    Created on : Aug 15, 2019, 2:33:15 AM
    Author     : Developer
--%>

<%@page import="com.gpms.pojo.*, org.apache.commons.lang3.StringUtils, java.util.*, java.text.SimpleDateFormat, java.time.LocalDate, java.time.format.DateTimeFormatter" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
 Organization orgs = null;
 String organization_name = "";
     try{
         LoginModel loginCred = new LoginModel();
     
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
                            <h5 class="title">Registration Form</h5></center>
                        <form action="./Registration" method="POST"  onsubmit="return validate();">
                            <div class="input-group">
                                <input
                                    class="input--style-1"
                                    type="text"
                                    placeholder="Full Name"
                                    name="fullname"
                                    required
                                    />
                            </div>

                            <div class="input-group">
                                <input
                                    class="input--style-1"
                                    type="text"
                                    placeholder="Alias"
                                    name="alias"
                                    required
                                    />
                            </div>

                            <div class="input-group">
                                <input type="email"  placeholder="Email" name ="email" pattern="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[a-z]{2,63}$" class="input--style-1" required>

                            </div>
                            <div class="input-group">
                                <input
                                    class="input--style-1 js-datepicker"
                                    type="text"
                                    placeholder="Date Of Birth"
                                    name="dob"
                                    required
                                    />
                                <i
                                    class="zmdi zmdi-calendar-note input-icon js-btn-calendar"
                                    ></i>
                            </div>
                            <div class="row row-space">
                                <div class="col-2">
                                    <div class="input-group">
                                        <div class="rs-select2 js-select-simple select--no-search">
                                            <select name="gender" required>
                                                <option disabled="disabled" selected="selected"
                                                        >Gender</option
                                                >


                                                <option value="M">Male</option>
                                                <option value="F">Female</option>
                                            </select>
                                            <div class="select-dropdown"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="input-group">
                                        <div class="rs-select2 js-select-simple select--no-search">
                                            <select name="maritalstatus" required>
                                                <option disabled="disabled" selected="selected"
                                                        >Marital Status</option
                                                >

                                                <option value="Single">Single</option>
                                                <option value="Married">Married</option>
                                                <option value="Divorced">Divorced</option>
                                            </select>
                                            <div class="select-dropdown"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>      



                            <div class="row row-space">
                                <div class="col-2">
                                    <div class="input-group">
                                        <input  type="tel" pattern="\+[\d]+"  name ="phone" id="phone" placeholder="Mobile. e.g. +2332..."  class="input--style-1" required />
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="input-group">
                                        <input  type="tel"  name ="altphone" placeholder="Alternative Phone"  class="input--style-1"/>
                                    </div>
                                </div>

                            </div>
                            <div class="input-group">
                                <input  type="number" min ="0" placeholder="Kids?" name ="kids" class="input--style-1" />
                            </div>
                           
                            <div class="input-group">

                                <input type="text" name ="occupation" placeholder="Occupation"  class="input--style-1" required>
                            </div>
                            <div class="input-group">

                                <input type="text" name ="address" placeholder="Residential Address" class="input--style-1" required>
                            </div>
                            <div class="input-group">

                                <input type="text" name ="aboutme" placeholder="Short Profile" class="input--style-1" required>
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
