<%@ include file="header.jspf" %>

${user.getEmail()}

<div ng-controller="SpotlightController" class="container-fluid">

    <div id="spotlight" class="row">
        <div id="chick1StreamContainer" class="col-xs-4">
            <h3 class="chickName">chick1</h3>
        </div>

        <div id="chick2StreamContainer" class="col-xs-4">
            <h3 class="chickName">chick2</h3>
        </div>

        <div id="queueContainer" class="col-xs-4">
            <h3>Queue</h3>
            <table class="table table-hover">
                <tr ng-repeat="user in queue">
                    <td>{{user.email}}</td>
                </tr>
            </table>
        </div>
    </div>

    <div class="row">
        <button id="chick1StreamBtn">chick1-stream</button>
        <button id="chick2StreamBtn">chick2-stream</button>

        <button onclick="attachSpotlight();">View</button>
    </div>

</div>

<div id="global">
    <p>global chat</p>
</div>

<div id="misc">
    <p>misc info</p>
</div>




<div>
    <button id="startNextRound">start next round</button>
    <button id="stopRound">stop round</button>
</div>



<script src="https://cdn.pubnub.com/pubnub-3.7.14.min.js"></script>
<script src="https://cdn.pubnub.com/webrtc/webrtc.js"></script>
<script src="https://cdn.pubnub.com/webrtc/rtc-controller.js"></script>
<script src="static/js/webrtcKeys.js"></script>
<script src="static/js/home.js"></script>

<script>
    var app = angular.module('mainApp', [])
        .controller('SpotlightController', function ($scope) {

            setInterval(function() {
                getSpotlightQueue(function(res) {
                    $scope.queue = res;
                    $scope.$apply();
                });
            }, 500);

        });
</script>


<%@ include file="footer.jspf" %>



