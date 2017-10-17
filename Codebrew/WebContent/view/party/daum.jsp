<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<div id="map" style="width:350px;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4c581b38ff4c308971bc220233e61b89&libraries=services"></script>
<script>
	var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
    mapOption = {
        center: new daum.maps.LatLng(33.450701, 126.570667), // ������ �߽���ǥ
        level: 3 // ������ Ȯ�� ����
    };  

	// ������ ����
	var map = new daum.maps.Map(mapContainer, mapOption); 
	
	// �ּ�-��ǥ ��ȯ
	var geocoder = new daum.maps.services.Geocoder();

	// �ּҷ� ��ǥ�� �˻�
	geocoder.addressSearch('����Ư���� ���ʱ� �������53�� 8', function(result, status) {

	    // ���������� �˻��� �Ϸ������ 
	     if (status === daum.maps.services.Status.OK) {
	    	 
			console.log(JSON.stringify(result));
	        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	
	        // ��������� ���� ��ġ�� ��Ŀ�� ǥ���մϴ�
	        var marker = new daum.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // ����������� ��ҿ� ���� ������ ǥ���մϴ�
	        /* var infowindow = new daum.maps.InfoWindow({
	            content: '<div style="text-align:center;padding:2px 0;border:1px solid #4ec3cd;">Tube Shop</div>'
	        });
	        infowindow.open(map, marker); */
	
	        // ������ �߽��� ��������� ���� ��ġ�� �̵���ŵ�ϴ�
	        map.setCenter(coords);
   	 } 
});    
	
	
	
</script>
</body>
</html>

