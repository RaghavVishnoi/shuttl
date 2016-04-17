/**
 * Created by Yash on 15/04/16.
 */
window.mapMaker = (function () {

  var busIcon = new google.maps.MarkerImage("/assets/busIcon", null, null, null, new google.maps.Size(25, 40)),
    homeIcon = new google.maps.MarkerImage("/assets/homeIcon", null, null, null, new google.maps.Size(25, 40)),
    officeIcon = new google.maps.MarkerImage("/assets/officeIcon", null, null, null, new google.maps.Size(25, 40)),

    wayPointIcon = new google.maps.MarkerImage("/assets/waypointIcon", null, null, null, new google.maps.Size(10, 10)),

    drawLabelMarkers = function (position, label, map, iconType) {
      return new MarkerWithLabel({
        position: position,
        draggable: false,
        raiseOnDrag: false,
        map: map,
        labelContent: label,
        labelClass: "pickup-labels",
        labelStyle: {opacity: 0.75},
        icon: iconType,
        labelAnchor: new google.maps.Point(22, 0)
      });
    },

    drawWayPointMarker = function(position, map) {
      new google.maps.Marker({
        icon: wayPointIcon,
        map: map,
        position: position,
        scale: 0.7,
        opacity: 0.7
      });
    },

    renderStartStopPoints = function (params, map) {
      var pmarker = drawLabelMarkers(new google.maps.LatLng(params.from[0], params.from[1]), "Start", map, homeIcon);

      google.maps.event.addListener(pmarker, "click", function (e) {
        new google.maps.InfoWindow({
          content: params.source
        }).open(map, this);
      });

      var dmarker = drawLabelMarkers(new google.maps.LatLng(params.to[0], params.to[1]), "Stop", map, officeIcon);

      google.maps.event.addListener(dmarker, "click", function (e) {
        new google.maps.InfoWindow({
          content: params.destination
        }).open(map, this);
      });
    };

  return {
    init: function (params) {

      var directionsService = new google.maps.DirectionsService,
        directionsDisplay = new google.maps.DirectionsRenderer({suppressMarkers: true}),
        map = new google.maps.Map(params.mapElement, {
          zoom: 6,
          panControl: true
          //center: {lat: 28.5747488, lng: 77.3538323}
        });


      //=====================Add the Start and stop markers======================//////
      renderStartStopPoints(params, map);
      
      //=====================Add the home and office markers======================//////
      //drawLabelMarkers(params.waypts[0].location, 'Home', map, busIcon);
      //drawLabelMarkers(params.waypts[3].location, 'Office', map, busIcon);

      directionsDisplay.setMap(map);

      directionsService.route({
        origin: params.source,
        destination: params.destination,
        waypoints: params.waypts,
        optimizeWaypoints: true,
        travelMode: google.maps.TravelMode.DRIVING
      }, function (response, status) {
        if (status === google.maps.DirectionsStatus.OK) {
          directionsDisplay.setDirections(response);

          for (var i = 0; i < params.waypts.length; i++) {
            drawWayPointMarker(params.waypts[i].location, map);
          }

        } else {
          window.alert('Directions request failed due to ' + status);
        }
      });
    }
  }
})();