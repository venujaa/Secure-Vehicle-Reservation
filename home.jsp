<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<!--
~   Copyright (c) 2018 WSO2 Inc. (http://wso2.com) All Rights Reserved.
~
~   Licensed under the Apache License, Version 2.0 (the "License");
~   you may not use this file except in compliance with the License.
~   You may obtain a copy of the License at
~
~        http://www.apache.org/licenses/LICENSE-2.0
~
~   Unless required by applicable law or agreed to in writing, software
~   distributed under the License is distributed on an "AS IS" BASIS,
~   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
~   See the License for the specific language governing permissions and
~   limitations under the License.
-->
<%@ page import="org.wso2.carbon.identity.sso.agent.bean.LoggedInSessionBean" %>
<%@ page import="org.wso2.carbon.identity.sso.agent.util.SSOAgentConstants" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.wso2.qsg.webapp.pickup.dispatch.CommonUtil"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="org.wso2.samples.claims.manager.ClaimManagerProxy"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="PICKUP DISPATCH - Vehicle allocation application">
    <title>Pickup-Dispatch</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Custom styles -->
    <link href="css/custom.css" rel="stylesheet">
    <link href="css/dispatch.css" rel="stylesheet">
</head>
<body class="app-home dispatch bg-light">

<div class="container-fluid p-0">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="home.jsp"><i class="fas fa-taxi"></i> PICKUP DISPATCH</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
                aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user-circle"></i> <span><%=subjectId%></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li><a class="dropdown-item" href="#">Profile</a></li>
                        <li><a class="dropdown-item" href="<%=SAML_LOGOUT_URL%>">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>

    <main class="main-content py-5">
        <div class="container">
            <div class="row text-center">
                <div class="col">
                    <h1 class="display-4">PICKUP DISPATCH</h1>
                    <p class="lead">Vehicle Booking Application</p>
                </div>
            </div>

            <div class="row">
                <div class="col-md-8 mx-auto">
                    <ul class="nav nav-pills justify-content-center mb-3" id="pills-tab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true"><i class="fas fa-edit"></i> Make a Booking</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false"><i class="fas fa-list"></i> View Bookings</button>
                        </li>
                    </ul>
                    <div class="tab-content" id="pills-tabContent">
                        <!-- Booking Form Tab -->
                        <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                            <form class="p-4 border rounded bg-white">
                                <div class="mb-3">
                                    <label for="drivers" class="form-label">Driver</label>
                                    <select class="form-select" id="drivers">
                                        <option selected>Select a driver</option>
                                        <option>Tiger Nixon (D0072)</option>
                                        <option>Joshua Winters (D0053)</option>
                                        <option>Lucas Thiyago (D0046)</option>
                                        <option>Woo Jin (D0027)</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="vehicles" class="form-label">Vehicle</label>
                                    <select class="form-select" id="vehicles">
                                        <option selected>Select a vehicle</option>
                                        <option>CAS 234 (Car)</option>
                                        <option>KNW 456 (Van)</option>
                                        <option>JDQ 887 (Car)</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="passesnger" class="form-label">Passenger</label>
                                    <select class="form-select" id="passesnger">
                                        <option selected>Select a passenger</option>
                                        <option>James Easton (P0064)</option>
                                        <option>Ryan Martin (P0052)</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="date" class="form-label">Date and Time</label>
                                    <div class="d-flex gap-2">
                                        <input type="date" class="form-control" id="date">
                                        <input type="time" class="form-control" id="time">
                                    </div>
                                </div>
                                <div class="text-center">
                                    <button type="button" class="btn btn-primary">Add Booking</button>
                                </div>
                            </form>
                        </div>

                        <!-- View Bookings Tab -->
                        <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                            <div class="table-responsive mt-4">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>Driver</th>
                                        <th>Vehicle</th>
                                        <th>Passenger</th>
                                        <th>Date and Time</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>Tiger Nixon</td>
                                        <td>CAS 234 (Car)</td>
                                        <td>Zofia Cox</td>
                                        <td>2024-10-15 14:30</td>
                                        <td><a href="#" class="text-danger"><i class="fas fa-trash-alt"></i></a></td>
                                    </tr>
                                    <tr>
                                        <td>Woo Jin</td>
                                        <td>HGY 423 (Car)</td>
                                        <td>Ryan Martin</td>
                                        <td>2024-10-16 10:00</td>
                                        <td><a href="#" class="text-danger"><i class="fas fa-trash-alt"></i></a></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Footer -->
<footer class="text-center py-4">
    <p class="mb-0">&copy; 2024 Pickup Dispatch | Powered by <a href="http://wso2.com/" target="_blank">WSO2</a></p>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>
