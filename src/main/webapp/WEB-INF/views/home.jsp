<%@ include file="header.jspf" %>

${user.getEmail()}

<div ng-controller="SpotlightController" class="container-fluid">

    <input id="qAble" data-toggle="toggle" data-on="Yes" data-off="No" type="checkbox">

    <div id="spotlight" class="row">
        <div id="chick1" class="col-xs-6">
            <h3 class="chickName">{{currentRound.chick1.email}}</h3>
            <div id="chick1StreamContainer"></div>
            <button id="voteChick1">vote ({{currentRound.chick1Votes}})</button>
        </div>

        <div id="chick2" class="col-xs-6">
            <h3 class="chickName">{{currentRound.chick2.email}}</h3>
            <div id="chick2StreamContainer"></div>
            <button id="voteChick2">vote ({{currentRound.chick2Votes}})</button>
        </div>

        <div id="queueContainer" class="col-xs-4">
            <h3>Queue</h3>
            <table class="table table-hover">
                <tr ng-repeat="user in currentRound.queue">
                    <td>{{user.email}}</td>
                </tr>
            </table>
        </div>


    </div>


</div>

<div id="global">
    <p>global chat</p>
</div>



<script src="https://cdn.pubnub.com/pubnub-3.7.14.min.js"></script>
<script src="https://cdn.pubnub.com/webrtc/webrtc.js"></script>
<script src="https://cdn.pubnub.com/webrtc/rtc-controller.js"></script>
<script src="static/js/webrtcKeys.js"></script>

<script src="static/lib/stomp.min.js"></script>
<script src="static/js/home.js"></script>


<%@ include file="footer.jspf" %>



