<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/resources/css/animate.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>

	<script type="text/javascript">
	

	function fncGetInitListDB() {
		
		$(function() {
				 
					$.ajax( 
							{
								url : "/festivalRest/json/getInitListDB",
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(jsonData , status) {
									
									for(var i = 0 ; i<3; i++){
										
									var festivalName =  jsonData.list[i].festivalName;	
									var festivalImage = jsonData.list[i].festivalImage
									var festivalNo = jsonData.list[i].festivalNo
									var startDate = jsonData.list[i].startDate
									var endDate = jsonData.list[i].endDate
									var addr = jsonData.list[i].addr
									
									}
									
									/* 0 */
									$("#festivalName0").text(jsonData.list[0].festivalName);
									$("#image0").attr("src",jsonData.list[0].festivalImage);
									$("#festivalNo0 > p").text(jsonData.list[0].festivalNo);
									$("#date0").text(jsonData.list[0].startDate + " ~ " + jsonData.list[0].endDate);
									$("#addr0").text(jsonData.list[0].addr);
									$("c").attr("test",jsonData.list[0].festivalImage +".contains('http://')==false");
									$(".first-slide").attr("src",jsonData.list[0].festivalImage);
									$("#tag0 > div > p").text(jsonData.list[0].festivalNo);
									$("#tag0").val(jsonData.list[0].festivalNo);
									
									
									/* 1 */
									$("#festivalName1").text(jsonData.list[1].festivalName);
									$("#image1").attr("src",jsonData.list[1].festivalImage);
									$("#festivalNo1 > p").text(jsonData.list[1].festivalNo);
									$("#date1").text(jsonData.list[1].startDate + " ~ " + jsonData.list[1].endDate);
									$("#addr1").text(jsonData.list[1].addr);
									$(".second-slide").attr("src",jsonData.list[1].festivalImage);
									$("#tag1 > div > p").text(jsonData.list[1].festivalNo);
									$("#tag1").val(jsonData.list[1].festivalNo);
									
									/* 2 */
									$("#festivalName2").text(jsonData.list[2].festivalName);
									$("#image2").attr("src",jsonData.list[2].festivalImage);
									$("#festivalNo2 > p").text(jsonData.list[2].festivalNo);
									$("#date2").text(jsonData.list[2].startDate + " ~ " + jsonData.list[2].endDate);
									$("#addr2").text(jsonData.list[2].addr);
									$(".third-slide").attr("src",jsonData.list[2].festivalImage);
									$("#tag2 > div > p").text(jsonData.list[2].festivalNo);
									$("#tag2").val(jsonData.list[2].festivalNo);
									
									
									
								}
						});
				});
	}

	
	$(function() {

		$("button").on("click", function() {

		var festivalNo = $(this).val();

		self.location = "/festival/getFestivalDB?festivalNo=" + festivalNo;
	});
});
	
	    
</script>


<style type="text/css">

	body {
            padding-top : 50px;
    }
	

  .carousel-inner > .item > img {
      min-width: 100%;
      min-height: 100%;
    
    }
    
    #myCarousel, .carousel-inner{
           height : 400x;
    }
    
    

</style>



<title>Moana</title>
</head>

<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	


<body onload="fncGetInitListDB();">
	
	
  	
  		<div class="page-header text-center">
					<h3 class="text-info">main</h3>
				</div>
				
				<!-- carousel  -->
				
				<div class="container">

      <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
          <li data-target="#carousel-example-generic" data-slide-to="1"></li>
          <li data-target="#carousel-example-generic" data-slide-to="2"></li>
        </ol>
        
        <div class="carousel-inner" role="listbox">
           
          <div class="item active">
          
      		<label for="item">
      		</label>  
            <img class="first-slide" src="" alt="First slide"  style="width : 600px; height : 400px;"  title="Click Images">
            <div class="carousel-caption" >
            
            
            <!-- data 삽입태그 -->
            <h1 class="glyphicon glyphicon-eye-open" id="festivalName0" aria-hidden="true"></h1><br/>
            <h4 class="glyphicon glyphicon-map-marker" id="addr0" aria-hidden="true"></h4><br/>
            <h4 class="glyphicon glyphicon-calendar" id="date0"></h4><br/>
            <button type="button" id="tag0" data-loading-text="Loading..." class="btn btn-primary" value="">상세보기</button>
            <div style=diplay:none>
            <p></p>
            </div>
            
            
            <div class="container">
          		</div>
          		</div>
          		</div>
          <div class="item">
          <label for="item">
      		</label>  
            <img class="second-slide" src="" alt="Second slide"  style="width : 600px; height : 400px;" title="Click Images" >
            <div class="container">
            <div class="carousel-caption">
            
            <!-- data 삽입태그 -->
            <h1 class="glyphicon glyphicon-eye-open" id="festivalName1" aria-hidden="true"></h1><br/>
            <h4 class="glyphicon glyphicon-map-marker" id="addr1" aria-hidden="true"></h4><br/>
            <h4 class="glyphicon glyphicon-calendar" id="date1"></h4><br/>
            <div>
            <button type="button" id="tag1" data-loading-text="Loading..." class="btn btn-primary" value="">상세보기</button>
            <p></p>
            </div>
          		</div>
          		</div>
          		</div>
          <div class="item">
          <label for="item">
      		</label>  
            <img class="third-slide" src="" alt="Third slide" style="width : 600px; height : 400px;" title="Click Images" >
            <div class="container">
            <div class="carousel-caption">
            
            <!-- data 삽입태그 -->
            <h1 class="glyphicon glyphicon-eye-open" id="festivalName2" aria-hidden="true"></h1><br/>
            <h4 class="glyphicon glyphicon-map-marker" id="addr2" aria-hidden="true"></h4><br/>
            <h4 class="glyphicon glyphicon-calendar" id="date2"></h4><br/>
            <div>
            <button type="button" id="tag2" data-loading-text="Loading..." class="btn btn-primary" value="">상세보기</button>
            <p></p>
            </div>
          		</div>
          		</div>
          		</div>
          		</div>
        <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
          <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div>
      
      </div> 
      
    <!-- carousel 끝 -->
    
    
	<div class="container">
		<div class="row">
		  	<div class="col-md-12">
		  	
		  		<div class="col-md-4">
		  		
		  			
		  		
		  		</div>
		  	
		  	
  	
  	
  			</div>
  		</div>
  	</div>
    
    
    
    
    
    
      
				

    


	</body>
</html>