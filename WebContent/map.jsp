<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Insert title here</title>
<style>
	#map {
		width: 100%;
		height: 700px;
	}
</style>
</head>
<body>

<div class="container" style="padding-top: 52px;">
	<div id="map"></div>
</div>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
	
	
	
	function initMap() {
		if(navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				var center = {
						lat: position.coords.latitude,
						lng: position.coords.longitude
				};
				
				var map = new google.maps.Map(document.getElementById('map'), {
					zoom : 14,
					center : center
				});
				
				var locations = [
					['city hall', 37.559841094, 126.973356107],
					['jongro', 37.572881, 126.9898893]
				];
				
				
				
				for(var i in locations) {
					
					var marker = new google.maps.Marker({
						position : new google.maps.LatLng(locations[i][1], locations[i][2]),
						title: locations[i][0],
						map : map
					});
					
					google.maps.event.addListener(marker, 'click', function() {
						console.log(marker.position.lat());
					});
				}
				
				
			})
		}
		
		
		
		
		google.maps.event.addListener(map, 'click', function(event) {
			var lat = event.latLng.lat();
			var lng = event.latLng.lng();
			
			map.panTo(new google.maps.LatLng(lat, lng));
		})
// 		map.setOptions({
// 			draggable : false
// 		});
	}
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDNpuB1xYE0YGvnADInd_oZGj62v73c7jo&callback=initMap" type="text/javascript"></script>
</html>