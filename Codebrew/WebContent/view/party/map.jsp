<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="map" style="width:500px;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0de5c0a0d8c0939d9e305e1dfb812b72&libraries=services"></script>
<script>
	var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
    var mapOption = {
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    	};  

	// 지도를 생성
	var map = new daum.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환
	var geocoder = new daum.maps.services.Geocoder();
	
	// 파티 도로명 주소
	var partyPlace = "${ party.partyPlace }";
	
	// 파티 도로명 주소 parsing
	

	// 주소로 좌표를 검색
	geocoder.addressSearch(partyPlace, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === daum.maps.services.Status.OK) {
	    	 
			console.log("map result :: "+JSON.stringify(result));
	        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new daum.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        /* var infowindow = new daum.maps.InfoWindow({
	            content: '<div style="text-align:center;padding:2px 0;border:1px solid #4ec3cd;">Tube Shop</div>'
	        });
	        infowindow.open(map, marker); */
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	   	 } 
	});    
	
	
	
</script>

