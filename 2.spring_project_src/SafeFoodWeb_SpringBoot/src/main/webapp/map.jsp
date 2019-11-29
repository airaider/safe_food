<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Place Details</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <script src="./js/jquery-3.3.1.js"></script>
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
     <link rel="stylesheet" href="./css/food.css">
     <link rel="stylesheet" href="./css/main.css">
     <link rel="stylesheet" href="./font/cssFont/all.css">
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
       width: 100%;
	height: 600px;
	clear: both;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
    <script>

      function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: 37.501469, lng: 127.039628},
          zoom: 16
        });
        var pid = ${pid}
		console.log(pid)
        var placeIDs = [
        	pid[0],
        	pid[1],
        	pid[2]
        ];
        var infowindow = new google.maps.InfoWindow();
        var service = new google.maps.places.PlacesService(map);
        
        for (var i = 0; i < placeIDs.length; i++) {
            service.getDetails({placeId: placeIDs[i]}, function(place, status) {
                if (status === google.maps.places.PlacesServiceStatus.OK) {
                  var marker = new google.maps.Marker({
                    map: map,
                    position: place.geometry.location
                  });
                  google.maps.event.addListener(marker, 'click', function() {
                    infowindow.setContent('<a href="' + "https://www.google.com/maps/place/?q=place_id:"+place.place_id+'"><strong>' + place.name + '</strong></a>');
                    infowindow.open(map, this);
                  });
                }
              });
        }

        
      }
    </script>
  </head>
  <body>
  <jsp:include page = "nav.jsp" />
  <!-- Container (중간 섹션) -->
	<div class="bg-1">
		<div>
			<br />
			<br />
			<br />
			<br />
			<br />
			<br />
		</div>
		<div id="band" class="container conta text-center">
			<h1>
				<em>WHAT WE PROVIDE</em>
			</h1>
			<P>건강한 삶을 위한 먹거리 프로젝트</P>
			<br>

		</div>
	</div>
	<article id="two" class="container">
	<h2 style="text-align: center">개인화 추천 맛집 : <%=(String)session.getAttribute("cat") %></h2>
		<section id="sectionOne">
		
    <div id="map"></div>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCV1d2eqCMjro-HWjpggqM6Nv7xYNHsynM&libraries=places&callback=initMap">
    </script>
		
		</section>
	</article>
    
    <footer class="text-center">
		<jsp:include page="copyright.jsp" />
	</footer>
  </body>
</html>