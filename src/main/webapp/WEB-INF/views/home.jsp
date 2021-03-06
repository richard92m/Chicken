<%@ include file="header.jspf" %>

<c:if test="${empty user}">
    <% response.sendRedirect("403"); %>
</c:if>


<%-- For accessing current user w/o a getSelf call--%>
<div style="display: none;">
    <span id="firstName" style="visibility: hidden;">${user.getFirstName()}</span>
    <span id="lastName" style="visibility: hidden;">${user.getLastName()}</span>
    <span id="idNum" style="visibility: hidden;">${user.getId()}</span>
    <span id="isBaby" style="visibility: hidden;">${user.isBaby()}</span>
    <span id="status" style="visibility: hidden;">${user.getStatus().getName()}</span>
</div>


<div id="userOptions">
    <label for="qAble">${user.getEmail()} queueing: &nbsp;</label>
    <input name="qAble" id="qAble" type="checkbox">
    <%--<input data-height="0" id="qAble" checked data-toggle="toggle" data-on="Yes" data-off="No" type="checkbox">--%>
</div>


<div ng-controller="SpotlightController" id="home-container" class="container-fluid row">

    <div id="spotlight-col" class="col-xs-9">

        <div class="container-fluid">

            <div id="waitingContainer">
                <h2><em>Waiting</em> for round to start...</h2>
                <img src="static/img/loading.gif"/>
            </div>

            <div id="spotlightContainer" class="row">

                <div id="youAreAChickContainer" class="alert-success">
                    <h1>You're a <img src="static/img/chicken-emoji.png" alt="Chicken"/>!</h1>
                </div>

                <div id="vsContainer">
                    <h3>
                        <button id="voteChick1" class="btn btn-primary vote-btn"><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span> &nbsp;&nbsp; {{currentRound.chick1Votes}}</button>
                        {{currentRound.chick1.firstName}} &nbsp;&nbsp; <em>VS</em> &nbsp;&nbsp; {{currentRound.chick2.firstName}}
                        <button id="voteChick2" class="btn btn-primary vote-btn"><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span> &nbsp;&nbsp; {{currentRound.chick2Votes}}</button>
                    </h3>
                </div>



                <div id="chick1" class="col-xs-6 chick">
                    <div id="chick1StreamContainer" class="chickVideoContainer white-container"></div>
                    <%--<h3 class="chickName">--%>
                        <%--<button id="voteChick1" class="btn btn-primary vote-btn"><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span> &nbsp;&nbsp; {{currentRound.chick1Votes}}</button>--%>
                        <%--{{currentRound.chick1.firstName}}--%>
                    <%--</h3>--%>
                </div>

                <div id="chick2" class="col-xs-6 chick">
                    <div id="chick2StreamContainer" class="chickVideoContainer white-container"></div>
                    <%--<h3 class="chickName">--%>
                        <%--<button id="voteChick2" class="btn btn-primary vote-btn"><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span> &nbsp;&nbsp; {{currentRound.chick2Votes}}</button>--%>
                        <%--{{currentRound.chick2.firstName}}--%>
                    <%--</h3>--%>
                </div>


                <h2 id="timerContainer">
                    <span id="seconds"></span> seconds remain!
                </h2>

            </div>

        </div>
    </div>


    <div class="col-xs-3" id="globalChatContainer">

        <%-- Queue list --%>
        <a id="queueListBtn" href="#queueList" data-toggle="collapse"><span class="glyphicon glyphicon-hourglass" aria-hidden="true"></span></a>
        <ul id="queueList" class="collapse">
            <li ng-repeat="user in currentRound.queue">
                {{user.firstName}} {{user.lastName}}
            </li>
        </ul>

        <%-- User list --%>
        <a id="userListBtn" href="#userList" data-toggle="collapse"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></a>
        <ul id="userList" class="collapse"></ul>

        <%-- Global chat --%>
        <div id="container">
            <div id="chatboxContainer">
                <div id="chatbox"></div>
            </div>
        </div>


        <div id="messageContainer">
            <input class="form-control" name="keywords" type="text" id="message" size="50" placeholder="Say something!" onkeypress="handleKeyPress(event)">
        </div>

        <div class="modal fade" id="UserProfile">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"
                                aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 id="fullNameUserModal" style="text-align:center;" class="modal-title">User Profile</h4>
                    </div>
                    <div class="modal-body container-fluid row">
                        <div id="avatarContainer" class="col-xs-3">
                            <img id="avatar" src=""/>
                        </div>

                        <div class="col-xs-8">
                            <table class="table">
                                <tr>
                                    <td>Status</td>
                                    <td id="userStatus"></td>
                                </tr>
                                <tr>
                                    <td>Games Played</td>
                                    <td id="games"></td>
                                </tr>
                                <tr>
                                    <td>Games Won</td>
                                    <td id="wins"></td>
                                </tr>
                                <tr>
                                    <td>Time in the Spotlight</td>
                                    <td id="spotlight"></td>
                                </tr>
                                <tr>
                                    <td>Votes Received</td>
                                    <td id="votes"></td>
                                </tr>
                                <tr>
                                    <td>Votes Cast</td>
                                    <td id="votesCast"></td>
                                </tr>
                            </table>
                            <select id="selectStatus">
                                <option id="stat1" value="normal">normal</option>
                                <option id="stat2" value="shadow ban">shadow ban</option>
                                <option id="stat3" value="permanent ban">permanent ban</option>
                                <option id="stat4" value="admin" selected>admin</option>
                            </select>
                            <button id="statusButton" class="btn btn-primary">Submit Changes</button>
                            <span id="statusChangeId" style="visibility: hidden;"></span>
                        </div>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
    </div>


</div>


<script src="https://cdn.pubnub.com/pubnub-3.7.14.min.js"></script>
<script src="https://cdn.pubnub.com/webrtc/webrtc.js"></script>
<script src="https://cdn.pubnub.com/webrtc/rtc-controller.js"></script>
<script src="static/js/webrtcKeys.js"></script>

<script src="//cdn.temasys.io/skylink/skylinkjs/0.6.x/skylink.complete.min.js"></script>

<script src="static/lib/stomp.min.js"></script>
<script src="static/js/home.js"></script>
<script src="static/js/globalChat.js"></script>

<%@ include file="footer.jspf" %>



