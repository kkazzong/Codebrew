<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	  jQuery , Bootstrap CDN 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	Bootstrap Dropdown Hover CSS
  	<link href="/css/animate.min.css" rel="stylesheet">
  	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	<link rel="stylesheet" href="/css/jquery-ui.css" type="text/css" />  
   
    Bootstrap Dropdown Hover JS
   <script src="/javascript/boot strap-dropdownhover.min.js"></script>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

 	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->

<div class="form-group has-warning">
				  <input type="hidden" name="currentPage" value=""/>				
				  <input type="hidden" name="countPerPage" value="8"/>		
				  <input type="hidden" name="resultType" value="json"/> 			
				  <input type="hidden" name="confmKey" value="U01TX0FVVEgyMDE3MDgyNjE0MDUzNzI0MzI0"/>	
				  <label for="keyword" class="col-sm-offset-1 col-sm-3 control-label">배송지</label>
				  <div class="col-sm-5">
				  <input class="form-control input-sm" type="text" id="keyword" name="keyword" value="" placeholder="주소를 입력하세요"/>
				  <input type="button" class="btn btn-default btn-xs" onclick="getAddr(1)" value="주소검색"/>
				  <span id="helpBlock" class="help-block">
			    		주소입력 후 주소 검색 버튼을 눌러주세요
			    </span>
				  </div>
				  <div id="list"></div>
			</div>
			
			<div class="form-group">
					<label for="postNum" class="sr-only col-sm-offset-1 col-sm-3 control-label">배송지</label>
					<div class="col-sm-5">
					<input type="text" id="postNum" name="postNum" class="form-control input-sm" width="100px" placeholder="우편번호" readonly/>
					</div>
			</div> 
			
			<div class="form-group">
				<label for="doroAddr" class="sr-only col-sm-offset-1 col-sm-3 control-label">배송지</label>
				<div class="col-sm-5">
					<input type="text" id="doroAddr" name="receiverAddr" class="form-control input-sm" placeholder="배송지 주소" readonly/>
				</div>
			</div> 
			
<script language="javascript">
function getAddr(page){
	if(page == null || page == '') {
		$("input:hidden[name='currentPage']").val(1);
	} else {
		$("input:hidden[name='currentPage']").val(page);
	}
	
	// AJAX 주소 검색 요청
	$.ajax({
		url:"http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"	/* // 주소검색 OPEN API URL */
		,type:"post"
		,data:$("#detailForm").serialize() 								/* // 요청 변수 설정 */
		,dataType:"jsonp"											/* // 크로스도메인으로 인한 jsonp 이용, 검색결과형식 JSON  */
		,crossDomain:true
		,success:function(jsonStr){		
			//alert(JSON.stringify(jsonStr));/* // jsonStr : 주소 검색 결과 JSON 데이터			 */
			$("#list").html("");									/* // 결과 출력 영역 초기화 */
			var errCode = jsonStr.results.common.errorCode;
			var errDesc = jsonStr.results.common.errorMessage;
			if(errCode != "0"){ 
				alert(errCode+"="+errDesc);
			}else{
				if(jsonStr!= null){
					console.log(JSON.stringify(jsonStr));
					makeListJsonTable(jsonStr);
					makeListAddr(jsonStr)/* // 결과 JSON 데이터 파싱 및 출력 */
				}
			}
		}
		,error: function(xhr,status, error){
			alert("에러발생");										/* // AJAX 호출 에러 */
		}
	});
}
function makeListJson(jsonStr){
	var htmlStr = "";
	htmlStr += "<table class='table table-border'>";
	// jquery를 이용한 JSON 결과 데이터 파싱
	$(jsonStr.results.juso).each(function(){
		htmlStr += "<tr>";
		htmlStr += "<td>"+this.roadAddr+"</td>";
		htmlStr += "<td>"+this.roadAddrPart1+"</td>";
		htmlStr += "<td>"+this.roadAddrPart2+"</td>";
		htmlStr += "<td>"+this.jibunAddr+"</td>";
		htmlStr += "<td>"+this.engAddr+"</td>";
		htmlStr += "<td>"+this.zipNo+"</td>";
		htmlStr += "<td>"+this.admCd+"</td>";
		htmlStr += "<td>"+this.rnMgtSn+"</td>";
		htmlStr += "<td>"+this.bdMgtSn+"</td>";
		htmlStr += "<td>"+this.detBdNmList+"</td>";
		/** API 서비스 제공항목 확대 (2017.02) **/
		htmlStr += "<td>"+this.bdNm+"</td>";
		htmlStr += "<td>"+this.bdKdcd+"</td>";
		htmlStr += "<td>"+this.siNm+"</td>";
		htmlStr += "<td>"+this.sggNm+"</td>";
		htmlStr += "<td>"+this.emdNm+"</td>";
		htmlStr += "<td>"+this.liNm+"</td>";
		htmlStr += "<td>"+this.rn+"</td>";
		htmlStr += "<td>"+this.udrtYn+"</td>";
		htmlStr += "<td>"+this.buldMnnm+"</td>";
		htmlStr += "<td>"+this.buldSlno+"</td>";
		htmlStr += "<td>"+this.mtYn+"</td>";
		htmlStr += "<td>"+this.lnbrMnnm+"</td>";
		htmlStr += "<td>"+this.lnbrSlno+"</td>";
		htmlStr += "<td>"+this.emdNo+"</td>";
		htmlStr += "</tr>";
	});
	htmlStr += "</table>";
	// 결과 HTML을 FORM의 결과 출력 DIV에 삽입
	$("#list").html(htmlStr);
}	
function makeListJsonTable(jsonStr){
	
	console.log(JSON.stringify(jsonStr));
	
	var htmlStr = "";
	htmlStr += "<table class='table table-border'>";
	// jquery를 이용한 JSON 결과 데이터 파싱
	htmlStr +="총 "+jsonStr.results.common.totalCount+"건<br>";
	htmlStr += "<thead class='bg-danger'><tr><td>우편번호</td><td>도로명</td></tr></thead>"
	$(jsonStr.results.juso).each(function(){
		htmlStr += "<tr>";
		htmlStr += "<td rowspan='2' id='zipNo'>"+this.zipNo+"</td>";
		htmlStr += "<td id='roadAddr'>"+this.roadAddr+"</td></tr>";
		htmlStr += "<tr><td><small class='text-muted'>"+this.jibunAddr+"</small></td></tr>";
		htmlStr += "</tr>";
	});
	htmlStr += "</table>";
	var result = jsonStr.results.common.totalCount;
	htmlStr += "<ul class='pagination'>"
	for(var i = 1; i <= 5; i++){
		
		htmlStr += "<li><a onClick='getAddr("+i+")'>"+i+"</a></li?";
	}
	htmlStr += "</ul>";
	
	// 결과 HTML을 FORM의 결과 출력 DIV에 삽입
	$("#list").html(htmlStr);
	
	
	$("tr:nth-child(n+1)").hover(function(){
		console.log("hover");
		$(this).css("color","#cccccc");
	},function(){
		$(this).removeAttr("style");
	}).bind('click',function(){
		console.log("click");
		console.log($("#zip",this).text().trim());
		var jsonStrClick = {"zipNo" : $("#zipNo",this).text().trim(),
									 "roadAddr" : $("#roadAddr",this).text().trim()};
		console.log(jsonStrClick);
		makeListAddr(jsonStrClick);
		$("#list").html("");
	});
	
}	
function makeListAddr(jsonStrClick){
	// jquery를 이용한 JSON 결과 데이터 파싱
	var htmlStr = "";
	//var zipNo = "";
	/* console.log(JSON.stringify(jsonStr));
	$(jsonStr.results.juso).each(function(){
		htmlStr += this.roadAddr;
		//zipNo +=this.zipNo;
	}); */
	// 결과 HTML을 FORM의 결과 출력 DIV에 삽입
	//console.log(JSON.stringify(jsonStr.roadAddr));
	//var addr = JSON.stringify(jsonStr.roadAddr);
	
	//$("#doroAddr").val("왜안대");
	//$("#doroAddr").val(jsonStr.zipNo);
	//console.log("도른"+jsonStr.results.juso[0].roadAddr);
	$("#postNum").val(jsonStrClick.zipNo);
	$("#doroAddr").val(jsonStrClick.roadAddr);
	//$("#jibunAddr").val(jsonStr.results.juso[0].jibunAddr);
}	

</script>
<style type="text/css">

.btn .btn-xs{
	background : #000;
	border : 1px solid #000;
}
</style>
<%-- <title>OPEN API 샘플 소스</title>
</head>
<body>
<div class="container">
	 <div class="row">
		<div class="col-md-offset-2 col-md-6">
			<form class="form form-inline" name="form" id="form" method="post">
			  <div class="form-group">
			  <input type="hidden" name="currentPage" value="1"/>				요청 변수 설정 (현재 페이지. currentPage : n > 0)
			  <input type="hidden" name="countPerPage" value="10"/>				요청 변수 설정 (페이지당 출력 개수. countPerPage 범위 : 0 < n <= 100)
			  <input type="hidden" name="resultType" value="json"/> 			요청 변수 설정 (검색결과형식 설정, json) 
			  <input type="hidden" name="confmKey" value="U01TX0FVVEgyMDE3MDgyNjE0MDUzNzI0MzI0"/>		요청 변수 설정 (승인키)
			  <label for="keyword"></label>
			  <input class="form-control input-sm" type="text" id="keyword" name="keyword" value="" placeholder="주소를 입력하세요"/>						요청 변수 설정 (키워드)
			  <input type="button" class="btn btn-xs" onclick="getAddr()" value="주소검색"/>
			  </div>
			  <div id="list"></div>
			</form>
		</div>
	</div>
	<div class="row">
		<div class="col-md-offset-2 col-md-6">
			<form class="form">
				<div class="form-group">
					<label for="postNum">우편번호</label>
					<input type="text" id="postNum" name="postNum" class="form-control input-sm" width="100px" readonly/>
				</div>
				<div class="form-group">
					<label for="doroAddr">도로명주소</label>
					<input type="text" id="doroAddr" name="doroAddr" class="form-control input-sm" readonly/>
				</div>
				<div class="form-group">
					<label for="jibunAddr">지번주소</label>
					<input type="text" id="jibunAddr" name="jibunAddr" class="form-control input-sm" readonly/>
				</div>
			</form>
		</div>
	</div> 
</div>
</body>
</htm<l> --%>
			<!-- <div class="form-group has-warning">
				  <input type="hidden" name="currentPage" value="1"/>				
				  <input type="hidden" name="countPerPage" value="10"/>				
				  <input type="hidden" name="resultType" value="json"/> 			
				  <input type="hidden" name="confmKey" value="U01TX0FVVEgyMDE3MDgyNjE0MDUzNzI0MzI0"/>	
				  <div class="col-sm-4">	
				  <label for="keyword" class="sr-only col-sm-offset-1 col-sm-3 control-label"></label>
				  <div class="col-sm-offset-1 col-sm-6">
				  <input class="form-control input-sm" type="text" id="keyword" name="keyword" value="" placeholder="주소를 입력하세요"/>					
				  <input type="button" class="btn btn-xs" onclick="getAddr()" value="주소검색"/>
				  </div>
				  <div id="list"></div>
				  </div>
			</div>
			
			<div class="form-group">
					<label for="postNum" class="col-sm-offset-1 col-sm-3 control-label">배송지</label>
					<div class="col-sm-4">
					<input type="text" id="postNum" name="postNum" class="form-control input-sm" width="100px" placeholder="우편번호" readonly/>
					</div>
			</div> 
			
			<div class="form-group form-inline">
				<label for="doroAddr" class="sr-only col-sm-offset-1 col-sm-3 control-label">배송지</label>
				<div class="col-sm-4">
					<input type="text" id="doroAddr" name="doroAddr" class="form-control input-sm" placeholder="배송지 주소" readonly/>
				</div>
			</div> -->
