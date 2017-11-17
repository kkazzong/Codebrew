<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name = "viewport" content = "width = device-width, height = device-height, initial-scale = 1">
	
	<title>채팅 클라이언트 01</title>
	
	<!-- <link href = "./semantic.min.css" rel = "stylesheet"> -->
	
	 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.js"></script>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.0.3/socket.io.js"></script>
	<!-- <script src = "semantic.min.js"></script> -->
	<script>
	
		///////////////////////////시간
		function printClock() {
			//alert("시간");
			var currentDate = new Date(); // 현재시간
			var amPm = 'AM'; // 초기값 AM
			var currentHours = addZeros(currentDate.getHours(), 2);
			var currentMinute = addZeros(currentDate.getMinutes(), 2);
			var currentSeconds = addZeros(currentDate.getSeconds(), 2);
	
			if (currentHours >= 12) { // 시간이 12보다 클 때 PM으로 세팅, 12를 빼줌
				amPm = 'PM';
				currentHours = addZeros(currentHours - 12, 2);
			}
			
			var innerHTML = currentHours + ":" + currentMinute +
			":" + amPm; //날짜를 출력해 줌
			console.log(innerHTML);
			$("#dataInputTime").val(innerHTML);
	
			//setTimeout("printClock()", 1000); // 1초마다 printClock() 함수 호출
		}
		
		function printDate() {
			var currentDate = new Date(); // 현재시간
			var calendar = currentDate.getFullYear() + "-"
			+ (currentDate.getMonth() + 1) + "-" + currentDate.getDate() // 현재 날짜
			
			$("#currentDate").html(calendar);
		}

		function addZeros(num, digit) { // 자릿수 맞춰주기
			var zero = '';
			num = num.toString();
			if (num.length < digit) {
				for (i = 0; i < digit - num.length; i++) {
					zero += '0';
				}
			}
			return zero + num;
		}
		
		
		var host;
		var port;
		var socket;
		
		//문서 로딩 후 실행
		$(function(){
			
			//alert("chat/chatting.jsp");
			//////////////////////////////////////////////스크롤/////////////////////////////////////////////////////////////
			//console.log($(document).height());
			//$("body").scrollTop($(document).height());
			
			
			//alert("여기로 포워딩왓음");
			//$("#scrollDiv").scrollTop($("#scrollDIv")[0].scrollHeight);
			//alert("chat/chatting3.jsp");
			//////오늘 날짜 출력
			printDate();
			
			//$("#connectButton").on('click', function(event){
				//println('connectButton이 클릭되었습니다.');
				host = $('#hostInput').val();
				port = $('#portInput').val();
				
				connectToServer();
			//});
			
			
			//메세지 전송
			$("#sendButton").on('click', function(event){
				
				printClock();
				
				var sender = $('#senderInput').val();
				var recipient = $('#recipientInput').val();
				var senNick = $('#senNick').val(); //////////senNick추가////////////////////
				var recNick = $('#recNick').val();
				var data = $('#dataInput').val();
				var time = $('#dataInputTime').val();
				
				if(data == '' || data == null) {
					alert("대화내용을 입력하세요");
					return;
				}
				
				var output = {sender : sender, recipient : recipient, senNick : senNick,
						recNick : recNick, command : 'chat', type  : 'text', data : data, time : time};
				//alert('서버로 보낼 데이터 : ' + JSON.stringify(output));
				
				if(socket == undefined){
					alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
					return;
				}
				
				socket.emit('message', output);
				//==> 변경
				//addToDiscussion('self',data,time,"");
			});
			
			$("#dataInput").on('keydown',function(event){
				if(event.keyCode ==13){
					
					printClock();
					
					var sender = $('#senderInput').val();
					var recipient = $('#recipientInput').val();
					var senNick = $('#senNick').val(); //////////senNick추가////////////////////
					var recNick = $('#recNick').val();
					var data = $('#dataInput').val();
					var time = $('#dataInputTime').val();
					
					if(data == '' || data == null) {
						alert("대화내용을 입력하세요");
						return;
					}
					
					var output = {sender : sender, recipient : recipient, senNick : senNick,
							recNick : recNick, command : 'chat', type  : 'text', data : data, time : time};
					//alert('서버로 보낼 데이터 : ' + JSON.stringify(output));
					
					if(socket == undefined){
						alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
						return;
					}
					
					socket.emit('message', output);
					
					//==> 변경
					//addToDiscussion('self',data,time,"");
				}
			});
			
			
			//==> 일대일 채팅방 입장시 변경
			//$("#loginButton").on('click', function(event){
				//alert('로그인 버튼 클릭!!')
				var senderId = $('#senderInput').val();
				var recipientId = $('#recipientInput').val();
				
				var output = {senderId : senderId, recipientId : recipientId};
				console.log('서버로 보낼 데이터 : '+ JSON.stringify(output));
				
				if(socket == undefined){
					alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
					return;
				}
				
				socket.emit('admit', output);
				
				
			//});
			
			
			
				var sender = $('#senderInput').val();
				var recipient = $('#recipientInput').val();
				var senNick = $('#senNick').val(); //////////senNick추가////////////////////
				var data = $('#dataInput').val();
				var time = $('#dataInputTime').val();
				
				var output2 = {
						sender : sender,
						recipient : recipient,
						senNick : senNick,
				};
				
				console.log('서버로 보낼 데이터 : ' + JSON.stringify(output2));
				
				if(socket == undefined){
					alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
					return;
				}
				
				socket.emit('findChat', output2);
				//addToDiscussion('self',data,time);
				
				//채팅방 입장시 이벤트 발생
				//socket.emit('admit', output3);
		});	
	 
		
		
		
		// 서버에 연결하는 함수 정의
		function connectToServer(){
			
			var options = {'forceNew' : true};
			var url = 'http://' + host + ':' + port;
			// 연결 요청
			socket = io.connect(url, options);
			
			socket.on('connect', function(){
				println('웹 소켓 서버에 연결되었습니다. : '+ url);
				
				////////////////////////////실시간 채팅//////////////////////////////////
				socket.on('message', function(message){
					console.log(JSON.stringify(message));
					
					println('<p>수신 메세지 : ' + message.sender + ', ' + message.recipient + ', '
							+ message.command + ', ' + message.type + ', ' + message.data +','+message.time+','+message.flag+'</p>');
					
					//addToDiscussion('other', message.data, message.time, message.flag);
					//==>변경
					var sessionId = "${user.userId}";
					//alert(sessionId+','+message.sender);
					
					if(sessionId == message.sender) {
						addToDiscussion('self', message.data, message.time, message.flag);
					} else if(message.sender == "${recipient.userId}"){ /////추가
						addToDiscussion('other', message.data, message.time, message.flag);
					}
					$("html").scrollTop($(document).height());
				});
				
				
				////////////////////////////DB에서 검색한 지난 채팅//////////////////////////////////
				socket.on('findChat', function(message){
					
					console.log("FROM DB"+JSON.stringify(message));
					
					var sessionId = "${user.userId}"; //세션아이디
					
					for(var i = 0; i < message.length; i++) {
						println('<p>디비에서 가져온 채팅 : ' +message[i].sender+ ', ' + message[i].recipient + ', '+ message[i].data +','+message[i].time+'</p>');
						//addToDiscussion('self', message[i].message, message[i].time);
						
						//alert(message[i].sender)
						if(sessionId == message[i].sender) {
							addToDiscussion('self', message[i].data, message[i].time, message[i].flag);
						} else {
							addToDiscussion('other', message[i].data, message[i].time, message[i].flag);
						}
						
					}
					
					console.log($(document).height()+",,"+$(window).height());
					$("html").scrollTop($(document).height());
					
				});
				
				//==> 메세지 읽음 이벤트 추가
				////////////////////////////상대방이 메세지 읽음 확인//////////////////////////////////
				socket.on('msgConfirm', function(admit){
					console.log('[msgConfirm] 상대방이 메세지 읽음');
					
					println('<p>수신 메세지 : ' + admit.senderId +'님이 메세지 읽음</p>');
					
					console.log('플래그 제대로 받아오는지 확인==> '+$("#flag").val());
					
					//if($('#flag').val() == "1"){
						//println('<p>안읽음 표시 사라짐!</p>');
						$('.flag').html("");
					//}
				});
				
				
			});
			
			
			/* socket.on('disconnect', function(){
				println('웹 소켓 연결이 종료되었습니다.');
			}); */
			
			socket.on('response', function(response){
				console.log(JSON.stringify(response));
				println('응답 메세지를 받았습니다. : ' + response.command + ', ' + response.code + ', ' + response.message);
			});
			
			socket.on('disconnect',function(userList){
				console.log(JSON.stringify(userList));
				println('user list를 받았습니다. : ' + userList);
				println('웹 소켓 연결이 종료되었습니다.');
			});
		}
		
		
		function println(data) {
			console.log(data);
			$('#result').append('<p>'+data+'</p>');
		}
		
		
		function addToDiscussion(writer, msg, time, flag){
			println("addToDiscussion 호출됨 : " + writer + ", " + msg + ", " + flag);
			var img;
			var contents;
			var recipient;
			var sender;
			
			//==>추가
			if(flag == '0'){
				flag = "";
			}
			
			if(writer == 'other'){
				
				
				img = '${recipient.profileImage}';
				recipient = '${recipient.nickname}';
			
				/* contents = "<li class = '"+writer+"'>"
							+"<div>"+recipient+"</div>"
							+"<div class = 'avatar'>"
							+"<img class = 'ui avatar image' src = '/resources/uploadFile/" + img + "'width='40' length='40'/>"
							+"</div>"
							+"<div class = 'message'>"
							+"<p>" + msg + "</p>"
							+"<p>" + flag + "</p>"
							/* +"<time datetime='2017-10-05 13:52'>"+time+"</time>" 
							+"<div id=time>"
							+"<time datetime='yyyy-mm-ddThh:mm:ss:Z'>"+time+"</time>"
							+"</div>"
							+"</div>"
							+"</li>"; */
				
				contents = "<li class = '"+writer+"'>"
							+"<a class = 'avatar'>"
							+"<img class = 'ui avatar image' src = '/resources/uploadFile/" + img + "'width='40' length='40'/>"
							+"</a>"
							+"<div class = 'message'>"
							+"<div class='nickname'>"+recipient+"</div>" 
							/* +"<div class='ui segment other'>" + msg + "</div>" */
							+"<div class='ui left pointing label other'>" + msg + "</div>"
							+"<p>" + flag + "</p>"
							+"</div>"
							/* +"<time datetime='2017-10-05 13:52'>"+time+"</time>" */
							+"<div id='time'>"
							+"<time datetime='yyyy-mm-ddThh:mm:ss:Z'>"+time+"</time>"
							+"</div>"
							+"</li>";
								
				println("추가할 HTML : " + contents);
				$(".discussion").append(contents);
			
			}else{
				
				img = '${sender.profileImage}';
				sender = '${sender.nickname}';
				
				/* contents = 
							"<li class = '"+writer+"'>"
							+"<div>"+sender+"</div>"
							+"<div class = 'avatar'>"
							/* +"<img class = 'img-circle' src = '/resources/uploadFile/" + img + "'width='40' length='40'/>" 
							+"<img class = 'ui avatar image' src = '/resources/uploadFile/" + img + "'width='40' length='40'/>"
							+"</div>"
							+"<div class = 'message'>"
							+"<p>" + msg + "</p>"
							+"<p class='flag'>" + flag + "</p>"
							+"<time datetime='yyyy-mm-ddThh:mm:ss:Z'>"+time+"</time>"
							+"</div>"
							+"</li>"; */
							
					contents = 
								"<li class = '"+writer+"'>"
								+"<div class='flag'>"+flag+"</div>"
								+"<div id='selfTime'>"
								+"<time datetime='yyyy-mm-ddThh:mm:ss:Z'>"+time+"</time>"
								+"</div>"
								+"<div class = 'message'>"
								/* +"<p class='nickname self'>"+sender+"</p>" */
								/* +"<div class='ui segment self'>" + msg + "</div>" */
								+"<div class='ui right pointing label'>" + msg + "</div>"
								+"</div>"
								+"<a class = 'avatar'>"
								/* +"<img class = 'img-circle' src = '/resources/uploadFile/" + img + "'width='40' length='40'/>" */
								+"<img class = 'ui avatar image' src = '/resources/uploadFile/" + img + "'width='40' length='40'/>"
								+"</a>"
								+"</li>";
								
				println("추가할 HTML : " + contents);
				$(".discussion").append(contents);
				$("#dataInput").val("");
				
			}
		}
			
		
		//채팅방 나갔을 때 이벤트 발생
		function exit() {
			
			//$(this).unload(function() {
				
				//alert('Handler for .unload() called.');
				//return 'Handler for .unload() called.';
	
				 var sender = $('#senderInput').val();
				var recipient = $('#recipientInput').val();
				//var senNick = $('#senNick').val(); //////////senNick추가////////////////////
				//var data = $('#dataInput').val();
				//var time = $('#dataInputTime').val();
				
				var output3 = {
						sender : sender,
						recipient : recipient
				};
				
				console.log('서버로 보낼 데이터 : ' + JSON.stringify(output3));
				socket.emit('exit', output3) ;
			//});
		}
		
		
	</script>
	
	<style>
	
		 body { 
	    	/* font: 13px Helvetica, Arial; */
	    	background-color: #99b8d366;
	    	padding:0px;
	    	margin:0px;
	    	width:100%;
	    	height:100%;
	    }
	    
	    
		.nickname {
			font-size: 0.8em;
			color : rgb(111, 113, 114);
			padding-left: 10px;
		}
		
		.nickname.self {
			font-size: 0.8em;
			color :rgb(111, 113, 114);
		}
		
		.flag {
			font-size: 0.8em;
			color : rgb(225, 216, 104);
			margin-top : 12px;
			margin-right : 4px;
		}
		
		/*다른사람시간*/
		#time {
			font-size: 0.7em;
			color : rgb(111, 113, 114);
			margin-left : 3px;
			margin-top : 24px;
		}
		
		#selfTime {
			font-size: 0.7em;
			color : rgb(111, 113, 114);
			margin-right : 3px;
			margin-top : 12px;
		}
		
		/* .ui.segment.other{
			position: relative;
			background-color:#eeeded;
		    box-shadow: 0 0 0 1px rgba(39,41,43,.15), 0 1px 2px 0 rgba(0,0,0,.05);
		    padding : 0.4rem;
		    border-radius: .2857rem;
		    border: none;
		} */
		
	/* 	///다른사람 메시지창 */
		.ui.left.pointing.label.other {
			    background-color: #f0f0f0;
			    border-color: #f0f0f0;
			    color: rgba(0,0,0,.85);
			    font-weight: 100;
			   /*  margin-top: 9px; */
		}
		.ui.left.pointing.label.other:before {
			    background-color: #f0f0f0;
		}
		
		
		/* .ui.segment.self {
		    position: relative;
		    background-color: #000000;
		    color : #fff;
		    box-shadow: 0 0 0 1px rgba(39,41,43,.15), 0 1px 2px 0 rgba(0,0,0,.05);
		     margin-right: 10px;
   		 	margin-top: -10px;
		    padding : 0.4rem;
		    border-radius: .2857rem;
		    border: none;
		} */
		
		/* //내꺼 메시지창 */
		.ui.label {
			background-color: #1b1c1d;
    		border-color: #1b1c1d;
    		color: #f0f0f0;
    		font-weight: 100;
		}
		.ui.pointing.label:before {
			 background-color: #1b1c1d;
		}
		
		/* //상단타이틀 */
		.ui.basic.image.label.title {
			background-color:#1b0d06cc;
			border-color: #1b0d06cc; 
			width : 100%!important;
		}
		
		.ui.image.label {
			    width: 100%!important;
			    height: 37px;
			        background: #c1c9d1;
		}
		
		/* //상단이미지 */
		#iconImage {
			margin-top : auto;
			margin-left : auto;
		   /*  width: 10px;*/
		}
		
		/* //상단이름 */
		#otherTitle {
			margin-top : auto;
			margin-left : auto;
			font-weight: 700;
			color: black;
		}
		
		/* //상단박스 */
		#labelbox {
			position: fixed;
			z-index: 3333;
		}
		
		/* //채팅메시지전체 */
		 #message {
			position: fixed;
			bottom: 0;
			width: 100%;
			height: 50px;
			z-index: 3333;
			background-color: #f0f0f0;
		} 
		
		/* //컨테이너 */
		#container {

			min-height: 100%; 
			position: relative;
		
		}
		
		html,body { height: 100%; margin: 0; padding: 0; }

		/* //메시지 오 */
		.discussion {
			padding-top: 18px;
			padding-bottom: 50px;
			padding-left: inherit;
		}
		
		.field {
			padding-top: 7px;
    		padding-left: 5px;
		}
		
		///////////////////////////////////////////////////////////////////////
		#titleText{
			font-size : 1.4em;
			font-weight : bold;
			color : #777;
		}
		
		#contentsText{
			color : #999;
		}
		
		#result{
			height : 10em;
			overflow : auto;
		}
		
		////////////////////////////////////////////////////////////////////
		
		.discussion{
  			list-style : none;
  			background : #ededed;
  			margin : 0;
  			/* padding : 0 0 50px 0; */
  			padding : 0 0 0 0;
  		}
  		
  		.discussion li{
  			padding : 0.5em;
  			overflow : hidden;
  			display : flex;
  		}
  		
  		.discussion .avator{
  			width : 40px;
  			position : relative;
  		}
  		
  		.discussion .avator img {
  			display : block;
  			width : 100%;
  		}
  		
  		.self{
  			justify-content : flex-end;
  			align-item : flex-end;
  		}
  		
  		///////////////////////////////////////////////////////////////////////////
  		 #message { background: #ffffff; padding: 3px; position: fixed; bottom: 0; width: 100%; }
	      
	    #message input { border: none; padding: 10px; width: 73%;/*  margin-right: 5%; */ }
	       
	  #message button { width: 23%;  border: none; /* padding: 10px; */ } 
	</style>
</head>
<body onbeforeunload="exit()">
	
	<div class = "container">
		<%-- <div id = "cardbox" class = "ui blue fluid card">
			<div class = "content">
				<span class = "left floated author col-xs-3">
					<img id = "iconImage" class = "ui avatar image" src = "/resources/image/chat/Messages-icon.png" width="45px" height="45px">
				</span>
				<span class="content-text col-xs-6">
					<span id = "titleText" class = "header col-xs-3">MOANA</span>
					<span id = "contentsText" class = "description col-xs-6">
						${ sender.nickname }님 채팅
					</span>
				</span>
			</div>
		</div> --%>
		
		<div id="labelbox" class = "ui image label title">
			<!-- <div class = "content"> -->
				<!-- <span class = "left floated author col-xs-3"> -->
					<img id="iconImage" src = "/resources/image/chat/Messages-icon.png" ><span id="otherTitle">${recipient.nickname}</span>
				<!-- </span> -->
				<!-- <span class="content-text col-xs-6">
					<span id = "titleText" class = "header col-xs-3">MOANA</span>
					<span id = "contentsText" class = "description col-xs-6"> -->
						<%-- ${ sender.nickname }님 채팅 --%>
					<!-- </span>
				</span> -->
			<!-- </div> -->
		</div>
	
	<div>
		<div class = "ui input">
			<input type = "hidden" id = "hostInput" value = "192.168.0.7">
		</div>
		<div class = "ui input">
			<input type = "hidden" id = "portInput" value = "3000">
		</div>
			<!-- <input type = "button" id = "connectButton" value = "연결하기"> -->
	</div>
	
	<div>
		<!-- 보낼 유저 정보 -->
		<input type = "hidden" id = "idInput" value="${sender.userId}">
		<input type = "hidden" id = "senNick" value="${sender.nickname}">
		<input type = "hidden" id = "recNick" value="${recipient.nickname}">
		<!-- <input type = "password" id = "passwordInput" value="1111"> -->
		<!-- <input type = "text" id = "todayInput" > -->
	</div>
	
	
	
	<!-- 채팅 확인창 -->
	<!-- <div id="currentDate"></div>
	<hr/>
	<h4 class = "ui horizontal divider header">메세지</h4>
	
	<div class = "ui segment" id = "result"></div> -->

	<!-- 채팅창 -->
	<div id="scrollDiv" style="overflow:auto;">
	<ol class="discussion">
		
	</ol>
	</div>
	
	<div>
		<div>
			<!-- <span>보내는 사람 아이디 : </span> -->
			<input type = "hidden" id = "senderInput" value="${sender.userId}">
		</div>
		<div>
			<!-- <span>받는 사람 아이디 : </span> -->
			<input type = "hidden" id = "recipientInput" value="${recipient.userId}">
		</div>
		<div id="message" class="ui form">
			<div class="field">
				<input type = "text" id = "dataInput"/>
				<button class="ui black button" type = "button" id = "sendButton">전송</button>
				<input type = "hidden" id = "dataInputTime">
			</div>
		</div>
		
	</div>


	</div>
	
	
	<%-- <div class = "container">
		<div id = "cardbox" class = "ui blue fluid card">
			<div class = "content">
				<div class = "left floated author col-xs-3">
					<img id = "iconImage" class = "ui avatar image" src = "/resources/image/chat/Messages-icon.png" width="45px" height="45px">
				</div>
				<div class="content-text col-xs-9">
					<span id = "titleText" class = "header col-xs-3">MOANA</span>
					<span id = "contentsText" class = "description col-xs-6">
						${ sender.nickname } 님 채팅
					</span>
				</div>
			</div>
		</div>
	
	<div>
		<div class = "ui input">
			<input type = "hidden" id = "hostInput" value = "localhost">
		</div>
		<div class = "ui input">
			<input type = "hidden" id = "portInput" value = "3000">
		</div>
		<br><br>
			<!-- <input type = "button" id = "connectButton" value = "연결하기"> -->
	</div>
	<br>
	
	<div>
		<!-- 보낼 유저 정보 -->
		<input type = "hidden" id = "idInput" value="${sender.userId}">
		<input type = "hidden" id = "senNick" value="${sender.nickname}">
		<input type = "hidden" id = "recNick" value="${recipient.nickname}">
		<!-- <input type = "password" id = "passwordInput" value="1111"> -->
		<!-- <input type = "text" id = "todayInput" > -->
	</div>
	
	
	
	<!-- 채팅 확인창 -->
	<!-- <div id="currentDate"></div>
	<hr/>
	<h4 class = "ui horizontal divider header">메세지</h4>
	
	<div class = "ui segment" id = "result"></div> -->

	<!-- 채팅창 -->
	<ol class="discussion">
		
	</ol>
	
	<div>
		<div>
			<!-- <span>보내는 사람 아이디 : </span> -->
			<input type = "hidden" id = "senderInput" value="${sender.userId}">
		</div>
		<div>
			<!-- <span>받는 사람 아이디 : </span> -->
			<input type = "hidden" id = "recipientInput" value="${recipient.userId}">
		</div>
		<div id="message">
			<input type = "text" id = "dataInput"/>
			<button type = "button" id = "sendButton">전송</button>
			<input type = "hidden" id = "dataInputTime">
		</div>
		<br>
		
	</div>


	</div> --%>
	
</body>
</html>