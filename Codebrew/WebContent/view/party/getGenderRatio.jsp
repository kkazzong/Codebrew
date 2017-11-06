<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript"> 
	
		//============= "파티 비율 확인하기"  Event 처리 및  연결 =============
		$(function(){
			$("#ratioLock").on("click", function() {
				//self.location="/partyRest/json/getGenderRatio/${party.partyNo}";
				console.log("파티 비율 확인하기 버튼 클릭.....");
				var partyNo = $("#partyNo").val();
				console.log("partyNo :: "+partyNo);
				$.getJSON( "/partyRest/json/getGenderRatio/"+partyNo,
							//{ partyNo : $("#partyNo").val() },
							function(JSONData, status){
								console.log(status);
								console.log("JSONData : "+JSON.stringify(JSONData));
								
								console.log("JSONData.femalePercentage : "+JSONData.femalePercentage);
								console.log("JSONData.femaleAgeAverage : "+JSONData.femaleAgeAverage);
								console.log("JSONData.malePercentage : "+JSONData.malePercentage);
								console.log("JSONData.maleAgeAverage : "+JSONData.maleAgeAverage);
								console.log("JSONData.partyName : "+JSONData.partyName);
								
								var html =  "<div><h1 align='center'>"+JSONData.partyName+"</h1></div>"
											+"<div>여자 비율 "+JSONData.femalePercentage+"%</div>"
											+"<div>여자 나이 평균 "+JSONData.femaleAgeAverage+"살</div>"
											+"<hr>"
											+"<div>남자 비율 "+JSONData.malePercentage+"%</div>"
											+"<div>남자 나이 평균"+JSONData.maleAgeAverage+"살</div>"
								
								$("form.form-horizontal-2").html(html);
											
								var chart = AmCharts.makeChart("chartdiv",
										{
										    "type": "serial",
										    "theme": "light",
										    "dataProvider": [{
										        "name": "여자",
										        "points": JSONData.femalePercentage,
										        "color": "#DB4C3C",
										        /* "bullet": "https://www.amcharts.com/lib/images/faces/D02.png" */
										        "bullet": "/resources/image/ui/female.png"
										    },{
										        "name": "남자",
										        "points": JSONData.malePercentage,
										        "color": "#7F8DA9",
										        /* "bullet": "https://www.amcharts.com/lib/images/faces/A04.png" */
										        "bullet": "/resources/image/ui/male.png"
										    }],
										    "valueAxes": [{
										        "maximum": 100,
										        "minimum": 0,
										        "axisAlpha": 0,
										        "dashLength": 4,
										        "position": "left"
										    }],
										    "startDuration": 1,
										    "graphs": [{
										        "balloonText": "<span style='font-size:13px;'>[[category]]: <b>[[value]]</b></span>",
										        "bulletOffset": 10,
										        "bulletSize": 52,
										        "colorField": "color",
										        "cornerRadiusTop": 8,
										        "customBulletField": "bullet",
										        "fillAlphas": 0.8,
										        "lineAlpha": 0,
										        "type": "column",
										        "valueField": "points"
										    }],
										    "marginTop": 50,
										    "marginRight": 0,
										    "marginLeft": 0,
										    "marginBottom": 20,
										    "autoMargins": false,
										    "categoryField": "name",
										    "categoryAxis": {
										        "axisAlpha": 0,
										        "gridAlpha": 0,
										        "inside": true,
										        "tickLength": 0
										    },
										    "export": {
										    	"enabled": true
										     }
										});
							});
				
			});
		});
		
		
		
	</script> 
	
	   
<!--  화면구성 div Start /////////////////////////////////////-->

<!-- Button trigger modal -->
<!-- <div class="col-md-offset-4 col-md-4 text-center" > -->
	<!-- <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#exampleModal2">
	  확인하기
	</button> -->
	<!-- <img src="../../resources/image/buttonImage/ratio_lock_icon.png" width="20%" height="20%" data-toggle="modal" data-target="#exampleModal2"> -->
	
	
	
<!-- </div> -->

<!-- Modal -->
<div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">파티 성별 비율</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form class="form-horizontal-2" enctype="multipart/form-data">
			
			
			
		</form>
		
		<div id="chartdiv"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
	
