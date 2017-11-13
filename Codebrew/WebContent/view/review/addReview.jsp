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
	
	<!-- 별점매기기 소스 start -->
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet">
	<link href="../../resources/javascript/kartik-v-bootstrap-star-rating/css/star-rating.min.css" media="all" rel="stylesheet" type="text/css" />
	<script src="../../resources/javascript/kartik-v-bootstrap-star-rating/js/star-rating.min.js" type="text/javascript"></script>
	<!-- 이건 위에 있어서 혹시몰라 남겨둠...
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	별점매기기 소스 end -->
	
	<!-- jQuery Image Upload하여 등록전 실시간으로 선택하여 업로드 가능 혹은 삭제 -->
	<!-- 
	<script src="../../resources/javascript/jquery.ui.widget.js" type="text/javascript"></script>
	<script src="../../resources/javascript/jquery.iframe-transport.js" type="text/javascript"></script>
	<script src="../../resources/javascript/jquery.fileupload.js" type="text/javascript"></script>
	 -->
	<!-- bootstrap은 위에서 cdn 처리 -->
	<!-- jQuery Image Upload하여 등록전 실시간으로 선택하여 업로드 가능 혹은 삭제 End-->
	
	
	<!-- 아래 테스트 중 sk editor 사용...안해 -->
	<!-- <script type = "text/javascript" src="../../resources/javascript/ckeditor/ckeditor.js"></script> -->
	
	<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
	<!-- <script src="js/vendor/jquery.ui.widget.js"></script> -->
	<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
	<!-- <script src="js/jquery.iframe-transport.js"></script> -->
	<!-- The basic File Upload plugin -->
	<!-- <script src="js/jquery.fileupload.js"></script> -->
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		/* body > div.container > .row{
			border: 3px solid #D6CDB7;
			margin-top: 10px;
		} */
    	
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
            background-color: #f2f4f6;
        }
        
        .imgs_wrap { 
        	/* border: 3px solid #333; */
        	/* width: 600px; */
        	/* height : 120px; */
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
		
		//reviewDetail.replace("\r\n", "<br>");
		alert("reviewDetail 입력확인 :: "+reviewDetail); //debugging 용
		
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
		$("button.btn.btn-info:contains('축제검색')").on("click", function(){
			window.open("/festival/getFestivalListDB?menu=pop", null, "height=450,width=600,status=yes,toolbar=no,menubar=no,location=no");
		});
		
		//등록예정인 해시태그들 삭제
		$("button.btn.btn-primary:contains('삭제')").on("click", function(){
			alert($('#reviewHashtag').val());
			$('#reviewHashtag').val("");
		});
		
		//축제평점 별점으로 start
		//initialize with defaults for star rating
		//$("#input-id").rating();
		
		/* 
		//initialize with plugin options for start rating
		$("#input-id").rating(
							{
								min:1, 
								max:5, 
								step:0.5, 
								data-size:'xs'
							}
						);
		 */
		 //축제평점 별점으로 end

		 
	});
	
	// 해시태그 등록
	$(document).ready(function(){
		$("input[name=toBeHashtag]").keydown(function(key){
			if(key.keyCode == 13){ //키 값이 13(enter)면 실행, 32(space)
				alert("hashtag로 등록됩니다.");
				console.log($(this).val());	
				var innerHtml = $("input:text[name=reviewHashtag]").val();
				innerHtml += "#"+$(this).val();
				
				$("input:text[name=reviewHashtag]").val(innerHtml);
				$(this).val("");
			}
			
		});
		
		/* $("#reviewDetail").keydown(function(key){
			if(key.keyCode == 13){
				var innerReviewDetail = $("textarea[name='reviewDetail']").val();
				//innerReviewDetail.replace("\r\n", "<br>");
				alert("innerReviewDetail :: "+innerReviewDetail); //debugging 용
			}
		}) */
	});
	
	
	// 다중 이미지 미리보기 and 삭제(미완...)
	// 이미지 정보를 담을 배열
	var sel_files = [];
	
	$(document).ready(function(){
		$("#uploadReviewImageList").on("change", handleImgsFilesSelect);
	});
	
	function fileUploadAction() {
		console.log("fileUploadAction");
		$("#uploadReviewImageList").trigger('click');
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
				return false;
			}else{
				sel_files.push(f);
			}
			
			var reader = new FileReader();
			reader.onload = function(e) {
				var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\"><img width='200px' height='200px' src=\"" + e.target.result + "\" data-file = '"+f.name+"' class='selProductFile' title='Click to remove'></a>";
				$(".imgs_wrap").append(html);
				index++;
				
			}
			reader.readAsDataURL(f);
		});
	}
	
	/* 파일 삭제 javascript : 배열에서는 삭제가 되는데...그래서 일단 주석*/
	/* 
	function deleteImageAction(index) {
		console.log("index : "+index);
		sel_files.splice(index, 1); //테스트 이미지 몇개 들어가는지 계속해서 확인 요망

		//sel_files.shift(index, 1); //테스트
		var img_id = "#img_id_"+index;
		$(img_id).remove();
		console.log(sel_files);
	}
	 */
	
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

	<!-- 모달 -->
	<%--  
	<jsp:include page="getFestivalListDBmodal.jsp"></jsp:include>
	 --%>

<!-- ////////// 화면구성 div Start ////////// -->
<div class="container">

	  
	<div class="row">
		<div class="col-md-12">
			<div class="page-header text-center">
			<h3 class="text-info"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span> 후기 등록</h3>
				<small>축제 후기를 공유해요.</small>
				<br>
				<br>
				<p>
					<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target=".bs-example-modal-sm">
						축제검색
					</button>
				</p>
			</div>
		</div>
	</div>
	<!-- ////////// form Start ////////// -->
		
			<form class="form-horizontal" method="post" name="detailForm" enctype="multipart/form-data">
		
				<!-- in the form group, should be there the hidden prodNo? -->
				<div class="form-group">
					<!-- 
					<label for="festivalName" class="col-md-offset-1 col-md-2 control-label">축제번호</label>
					 -->
					<label for="festivalName" class="col-md-3 control-label">축제번호</label>
					<div class="col-md-6">
						<input type="text" class="form-control" id="festivalNo" name="festivalNo" value="${festival.festivalNo }" readonly>
					</div>
				</div>
				
				<hr/>
				
				<div class="form-group">
					<label for="festivalName" class="col-md-3 control-label">축제명</label>
					<div class="col-md-6">
						<input type="text" class="form-control" id="festivalName" name="festivalName" value="${festival.festivalName}" readonly>
					</div>
				</div>
				
				<hr/>
				
				<div class="form-group">
					<label for="addr" class="col-md-3 control-label">축제위치</label>
					<div class="col-md-6">
						<input type="text" class="form-control" id="addr" name="addr" value="${festival.addr }" readonly>
					</div>
				</div>
				<!-- 위의 3항목은 festival에서 value 받아올 예정 -->
				
				<hr/>
				
				<div class="form-group">
					<label for="reviewTitle" class="col-md-3 control-label">후기제목</label>
					<div class="col-md-6">
						<input type="text" class="form-control" id="reviewTitle" name="reviewTitle"/>
					</div>
				</div>
				
				<hr/>
				
				<div class="form-group">
					<label for="userId" class="col-md-3 control-label">작성자</label>
					<div class="col-md-6">
						<input type="text" class="form-control" id="userId" name="userId" value="${sessionScope.user.userId }" readonly/>
					</div>
				</div>
				
				<hr/>
				
				<div class="form-group">
					<label for="reviewFestivalRating" class="col-md-3 control-label">축제평점</label>
					<div class="col-md-6">
						<!-- 되는거...근데 밋밋해 별점주기로 해보자
						<input type="number" class="form-control" id="reviewFestivalRating" name="reviewFestivalRating" min="1" max="10"> 
						-->
						<input type="number" id="reviewFestivalRating" class="form-control rating" name="reviewFestivalRating" value="5" data-min="0" data-max="5" data-step="1" data-size="xs" data-rtl="true">
					</div>
				</div>
				
				<hr/>
				
				<div class="form-group">
					<label for="reviewImageList" class="col-md-3 control-label">후기사진</label>
					<div class="col-md-6">
						<!-- 위에 js는 남겨둬서... 현재는 지워도...상관없음
						<a href="javascript:" onclick="fileUploadAction();" class="my_button">파일업로드</a>
						-->
						<button type="button" class="btn btn-primary" onclick="document.getElementById('uploadReviewImageList').click(); ">사진 업로드</button>
						<input type="file" class="form-control" id="uploadReviewImageList" accept="image/*" name="uploadReviewImageList" style="display:none;" multiple/>
						
					</div>
				</div>
				
				<div class="form-group text-center">
					<div class="imgs_wrap" align="center">
						<small class="text-danger">사진은 반드시 1장 이상 업로드해야 합니다</small><br>
						<small>이미지 미리보기</small>
						<img id="img" align="middle"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="reviewDetail" class="col-md-1 control-label">후기</label>
					<div class="col-md-10">
						<textarea rows="5" cols="30" class="form-control" id="reviewDetail" name="reviewDetail"></textarea>
						<!-- <textarea rows="5" cols="30" class="ckeditor" id="ckeditor"></textarea> ckEditor 사용-->
						<span id="helpBlock" class="help-block">
							<strong class="text-danger text-center">후기내용은 반드시 입력해야 합니다.</strong>
						</span>
					</div>
				</div>
				
				<hr/>
				
				<div class="form-group">
					<label for="reviewVideo" class="col-md-3 control-label">동영상</label>
					<div class="col-md-6">
						<input type="file" class="form-control" id="uploadReviewVideoList" accept="video/*" name="uploadReviewVideoList"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="toBeHashtag" class="col-md-3 control-label">해시태그 입력</label>
					<div class="col-md-6">
						<input type="text" class="form-control" id="toBeHashtag" name="toBeHashtag" value="">
						<span id="helpBlock" class="help-block">
							<strong class="text-danger">해시태그를 입력한 후 엔터 키를 누르세요</strong>
						</span>
					</div>
				</div>
				
				<hr/>
				
				<div class="form-group">
					<label for="reviewHashtag" class="col-md-3 control-label">등록 해시태그</label>
					<div class="col-md-6">
						<input type="text" class="form-control" id="reviewHashtag" name="reviewHashtag" readonly>
						<span>
							<button type="button" id="deleteAllHashtag" class="btn btn-primary">삭제</button>
						</span>
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