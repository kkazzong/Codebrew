<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<div id="map" style="width:350px;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4c581b38ff4c308971bc220233e61b89&libraries=services"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

	// 지도를 생성
	var map = new daum.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환
	var geocoder = new daum.maps.services.Geocoder();

	// 주소로 좌표를 검색
	geocoder.addressSearch('서울특별시 서초구 강남대로53길 8', function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === daum.maps.services.Status.OK) {
	    	 
			console.log(JSON.stringify(result));
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
</body>
</html>

