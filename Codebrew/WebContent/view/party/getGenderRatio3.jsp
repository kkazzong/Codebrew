<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript"> 
	
		//============= "파티 비율 확인하기"  Event 처리 및  연결 =============
		$(function(){
			
				console.log(">>> getGenderRatio.jsp 로딩.....");
				
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
								
								var html =  "<div class='row'>"
											+"<div class='col-xs-6'><strong>여자 나이 평균 "+JSONData.femaleAgeAverage+"살</strong></div>"
											+"<div class='col-xs-6'><strong>남자 나이 평균 "+JSONData.maleAgeAverage+"살</strong></div>"
											+"</div>"
								$("form.form-horizontal-2").html(html);
								
								if(JSONData.femalePercentage>JSONData.malePercentage){
								var chart = AmCharts.makeChart("chartdiv",
										{
										    "type": "serial",
										    "theme": "light",
										    "dataProvider": [{
										        "name": "여자",
										        "points": JSONData.femalePercentage,
										        "color": "#DB4C3C",
										        /* "bullet": "https://www.amcharts.com/lib/images/faces/D02.png" */
										       "bullet": "/resources/image/ui/female_up.png"
										    },{
										        "name": "남자",
										        "points": JSONData.malePercentage,
										        "color": "#7F8DA9",
										        /* "bullet": "https://www.amcharts.com/lib/images/faces/A04.png" */
										        "bullet": "/resources/image/ui/male.png"
										    }],
										    "valueAxes": [{
										        "maximum": 120,
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
										    "marginTop": 0,
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
								 }else if(JSONData.femalePercentage<JSONData.malePercentage){
									 
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
												        "bullet": "/resources/image/ui/male_up.png"
												    }],
												    "valueAxes": [{
												        "maximum": 120,
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
												    "marginTop": 0,
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
								 }else{
									 
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
												        "maximum": 120,
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
												    "marginTop": 0,
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
								 }
							});
				
			
			/* 파티 멤버 리스트 보기 버튼 */
			$("#ratioLock > img").on("click", function() {
				if(sessionId !=""){
					var getPartyRatioList = "<div class='hover01 column'>"
											+"<div>"
											+"<figure id='ratioLock'><img src='../../resources/image/buttonImage/ratio_lock_icon.png' width='35%' height='35%' data-toggle='modal' data-target='#exampleModal2'></figure>"
											+"</div>"
											+"</div>";		
						
					$("#partyRatioButtonDiv").html(getPartyRatioList);
				    
				    console.log($("#partyRatioButtonDiv").html(getPartyRatioList));
					
					console.log("코코넛 차감후 파티 비율 보기 실행");
					swal({
						  title: '코코넛을 사용해 파티 참여자의 비율을 확인할 수 있어요!',
						  text: "코코넛 3개를 사용하시겠습니까?",
						  type: 'info',
						  showCancelButton: true,
						  confirmButtonColor: '#9adbf9',
						  cancelButtonColor: '#b5bcbf',
						  confirmButtonText: '네!',
						  cancelButtonText: '아니오' 
						})
						.then(function () {
							
							$("#exampleModal2").css('display', 'block');
						})
					
				}
			});		
		});
		
		
		
	</script> 
	
	   
<!--  화면구성 div Start /////////////////////////////////////-->


<!-- Modal -->
<div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">현재 파티에 참여중인 사람들의 비율이에요!</h5>
        <h1 align="center">${ party.partyName }</h1>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<!-- 성별 비율 차트 -->
		<div id="chartdiv"></div>
		<!-- 나이 비율 -->
        <form class="form-horizontal-2" enctype="multipart/form-data">
		
		</form>
	  </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
	