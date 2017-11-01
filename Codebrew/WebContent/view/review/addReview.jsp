<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	
	<title>후기등록화면</title>
	
	<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN(Content Delivery Network) ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	
	<!-- 아래 테스트 중 -->
	<!-- <script type = "text/javascript" src="../../resources/javascript/ckeditor/ckeditor.js"></script> -->
	
	<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
	<!-- <script src="js/vendor/jquery.ui.widget.js"></script> -->
	<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
	<!-- <script src="js/jquery.iframe-transport.js"></script> -->
	<!-- The basic File Upload plugin -->
	<!-- <script src="js/jquery.fileupload.js"></script> -->
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body > div.container{
			border: 3px solid #D6CDB7;
			margin-top: 10px;
		}
    	
    	.img_wrap{
        	width:600px;
        	margin-top: 50px;
        }
        
        .img_wrap img{
        max-width: 200px;
        }
        
        .form-control{
        	resize: none; /* cannot be changed by the user */
        }
        
 		body {
            padding-top : 50px;
        }
        
        .imgs_wrap { 
        	width: 600px;
        	margin-top: 50px;
        	aling-items: center;
        	justify-content: center;
        }
        
        .imgs_wrap img {
        	max-width: 200px;
        }
		        
    </style>
    
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	//=====기존 Code 주석 처리 후 jQuery 변경 =====//
	function fncAddReview() {
		
		//Form 유효성 검증
	 	//var reviewTitle = document.detailForm.reviewTitle.value;
		//var reviewDetail = document.detailForm.reviewDetail.value;
		//var reviewImageList = document.detailForm.reviewImageList.value;
		
		var reviewTitle = $("input[name='reviewTitle']").val();
		var reviewDetail = $("textarea[name='reviewDetail']").val();
		var reviewImageList = $("input[name='uploadReviewImageList']").val();
		
		if(reviewTitle == null || reviewTitle.length<1){
			alert("후기제목은 반드시 입력하여야 합니다.");
			return;
		}
		if(reviewDetail == null || reviewDetail.length<1){
			alert("후기상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		if(reviewImageList == null || reviewImageList.length<1){
			alert("후기사진는 반드시 1장 이상 등록하여야 합니다.");
			return;
		}
		
		$("form").attr("method", "POST").attr("action", "/review/addReview").submit();
	}
	
	
	$(function(){
		//==>"등록" Event 처리 및 연결
		//==> DOM Object GET 3가지 방법 ==> 1.$(tagName) : 2.(#id) : 3.$(.className)
		//==>1과 3 방법의 조합 : $("tagName.className:filter함수") 사용함.
		$("button.btn.btn-primary:contains('등록')").on("click", function(){
			//Debug..
			//alert($("td.ct_btn01:contains('등록')").html());
			fncAddReview();
		});
		
		//==>"취소" Event 처리 및 연결
		//==>DOM Object GET 3가지 방법 ==> 1.$(tagName) : 2.(#id) : 3.$(.className)
		//==>1과 3 방법의 조합 : $("tagName.className:filter함수") 사용함.
		$("button.btn.btn-primary:contains('취소')").on("click", function(){
			//Debug..
			//alert($("td.ct_btn01:contains('취소')").html());
			if(confirm("취소하면 모든 정보가 사라집니다. 계속 하시겠습니까?")){
				javascript:history.go(-1);
			}else{
				return;
			}
		});
		
		//debug
		$("input:text[name='festivalNo']").on("keydown", function(){
			console.log($(this).val());
		});
		
		//modal창 띄우기
		$("button.btn.btn-primary:contains('축제검색')").on("click", function(){
			window.open("/festival/getFestivalListDB?menu=pop", null, "height=450,width=600,status=yes,toolbar=no,menubar=no,location=no");
		});
		
		
	});
	
	// 해시태그 등록
	$(document).ready(function(){
		$("input[name=toBeHashtag]").keydown(function(key){
			if(key.keyCode == 13 || key.keyCode == 32){ //키 값이 13(enter)면 실행, 32(space)
				alert("hashtag로 등록됩니다.");
				console.log($(this).val());	
				var innerHtml = $("input:text[name=reviewHashtag]").val();
				innerHtml += "#"+$(this).val();
				
				$("input:text[name=reviewHashtag]").val(innerHtml);
				$(this).val("");
			}
			
		});
		
		$("#reviewDetail").keydown(function(key){
			if(key.keyCode == 13){
				//alert("enter 입력 : 한줄 개행");
				var innerReviewDetail = $("input:text[name=reviewDetail]").val();
				innerReviewDetail += "<br>";
			}
		})
	});
	
	// 다중 이미지 미리보기 and 삭제
	// 이미지 정보를 담을 배열
	
	var sel_files = [];
	
	$(document).ready(function(){
		$("#uploadReviewImageList").on("change", handleImgsFilesSelect);
	});
	
	function fileUploadAction() {
		console.log("fileUploadAction");
		$("#uploadReviewImageList").trigger('click"');
	} 
	
	
	function handleImgsFilesSelect(e){
		
		sel_files = []; //이미지 정보 초기화 : handler event 발생시 기존 이미지 정보들 모두 초기화
		$(".imgs_wrap").empty();
		
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		var index = 0;
		filesArr.forEach(function(f) {
			if(!f.type.match("image.*")) {
				alert("확장자는 이미지 확장자만 가능합니다.");
				return;
			}
			sel_files.push(f);
			
			var reader = new FileReader();
			reader.onload = function(e) {
				var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\"><img src=\"" + e.target.result + "\" data-file = '"+f.name+"' class='selProductFile' title='Click to remove'></a>";
				$(".imgs_wrap").append(html);
				index++;
				
			}
			reader.readAsDataURL(f);
		});
	}
	
	function deleteImageAction(index) {
		console.log("index : "+index);
		sel_files.splice(index, 1);
		
		var img_id = "#img_id_"+index;
		$(img_id).remove();
		console.log(sel_files);
	}
	
	/* 테스트중 ckeditor */
	/* 
	$(function(){
        
        CKEDITOR.replace( 'ckeditor', {//해당 이름으로 된 textarea에 에디터를 적용
            width:'100%',
            height:'400px',
            filebrowserImageUploadUrl: '/review/imageUpload' //여기 경로로 파일을 전달하여 업로드 시킨다.
        });
         
         
        CKEDITOR.on('dialogDefinition', function( ev ){
            var dialogName = ev.data.name;
            var dialogDefinition = ev.data.definition;
          
            switch (dialogName) {
                case 'image': //Image Properties dialog
                    //dialogDefinition.removeContents('info');
                    dialogDefinition.removeContents('Link');
                    dialogDefinition.removeContents('advanced');
                    break;
            }
        });
    });
	 */
	 
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="../../toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->


<!-- ////////// 화면구성 div Start ////////// -->
<div class="container">

	<!-- 모달 -->
	<%-- 
	<jsp:include page="/view/festival/popupListDB.jsp"></jsp:include>
	 --%>
	  
	<h1 class="bg-primary text-center">후기등록양식</h1>
	
	<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
		축제검색
	</button>
	 
	<!-- ////////// form Start ////////// -->
	<form class="form-horizontal" method="post" name="detailForm" enctype="multipart/form-data">

		<!-- in the form group, should be there the hidden prodNo? -->
		<div class="form-group">
			<label for="festivalName" class="col-sm-offset-1 col-sm-3 control-label">축제번호</label>
			<div class="col-md-4">
				<input type="text" class="form-control" id="festivalNo" name="festivalNo" value="${festival.festivalNo }" readonly>
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="festivalName" class="col-sm-offset-1 col-sm-3 control-label">축제명</label>
			<div class="col-md-4">
				<input type="text" class="form-control" id="festivalName" name="festivalName" value="${festival.festivalName}" readonly>
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="addr" class="col-sm-offset-1 col-sm-3 control-label">축제위치</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="addr" name="addr" value="${festival.addr }" readonly>
			</div>
		</div>
		<!-- 위의 3항목은 festival에서 value 받아올 예정 -->
		
		
		<hr/>
		
		<div class="form-group">
			<label for="reviewTitle" class="col-sm-offset-1 col-sm-3 control-label">후기제목</label>
			<div class="col-md-4">
				<input type="text" class="form-control" id="reviewTitle" name="reviewTitle"/>
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">작성자</label>
			<div class="col-md-4">
				<input type="text" class="form-control" id="userId" name="userId" value="${sessionScope.user.userId }" readonly/>
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="reviewFestivalRating" class="col-sm-offset-1 col-sm-3 control-label">축제에대한 작성자의 평점</label>
			<div class="col-md-2">
				<input type="number" class="form-control" id="reviewFestivalRating" name="reviewFestivalRating" min="1" max="10"> 
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="reviewImageList" class="col-md-offset-1 col-md-3 control-label">후기사진</label>
			<div class="col-md-4">
				<input type="file" class="form-control" id="uploadReviewImageList" name="uploadReviewImageList" multiple/>
			</div>
			<div class="imgs_wrap col-md-12" align="center">
				<img id="img" align="middle"/>
			</div>
		</div>
		
		<div class="form-group">
			<label for="reviewDetail" class="col-md-1 control-label">후기내용</label>
			<div class="col-md-10">
				 
				<textarea rows="5" cols="30" class="form-control" id="reviewDetail" name="reviewDetail"></textarea>
				 
				<!-- <textarea rows="5" cols="30" class="ckeditor" id="ckeditor"></textarea> ckEditor 사용-->
				<span id="helpBlock" class="help-block">
					<strong class="text-danger">후기내용은 반드시 입력해야 합니다.</strong>
				</span>
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="reviewVideo" class="col-md-offset-1 col-md-3 control-label">동영상</label>
			<div class="col-md-4">
				<input type="file" class="form-control" id="uploadReviewVideoList" name="uploadReviewVideoList"/>			
			</div>
		</div>
		
		<div class="form-group">
			<label for="toBeHashtag" class="col-md-offset-1 col-md-3 control-label">해시태그를 입력</label>
			<div class="col-md-4">
				<input type="text" class="form-control" id="toBeHashtag" name="toBeHashtag" value="">
				<span id="helpBlock" class="help-block">
					<strong class="text-danger">해시태그를 입력한 후 스페이스 혹은 엔터 키를 누르세요</strong>
				</span>
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="reviewHashtag" class="col-md-offset-1 col-md-3 control-label">등록예정 해시태그</label>
			<div class="col-md-4">
				<input type="text" class="form-control" id="reviewHashtag" name="reviewHashtag">
				<button type="button" class="btn btn-primary">삭제</button>
			</div>
		</div>
		
		<hr/>
				
		<div class="form-group">
			<div class="col-md-offset-4 col-md-4 text-center">
				<button type="button" class="btn btn-primary">등록</button>
				<button type="button" class="btn btn-primary">취소</button>
			</div>
		</div>
	
	
	</form>
	<!-- form End -->

</div>
<!-- ////////// 화면구성 div End ////////// -->
</body>
</html>