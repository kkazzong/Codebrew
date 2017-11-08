<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name = "viewport" content = "width = device-width, height = device-height, initial-scale = 1">
	
	<title>채팅 목록</title>
	
	<link href = "./semantic.min.css" rel = "stylesheet">
	
	<!-- Bootstrap, jQuery CDN -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<script src = "https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.0.3/socket.io.js"></script>
	<!-- <script src = "semantic.min.js"></script> -->
	<script>
	
		var host;
		var port;
		var socket;
		
		/////////////////////============jQuery start================/////////////////////////
		$(function(){
			
			//////오늘 날짜 출력
			printDate();
			
			host = $('#hostInput').val();
			port = $('#portInput').val();
				
			connectToServer();
			
			var sender = $('#sender').val();
			var senNick = $('#senNick').val();
			
			var output = {id : sender, alias : senNick};
			console.log('서버로 보낼 데이터 : '+ JSON.stringify(output));
			
			if(socket == undefined){
				alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
				return;
			}
			
			socket.emit('login', output);
			
			output = {
					sender : sender,
					senNick : senNick
			};
			
			console.log('서버로 보낼 데이터 : ' + JSON.stringify(output));
			
			if(socket == undefined){
				alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
				return;
			}
			
			socket.emit('findChatList', output);
			
		});	
		/////////////////////=============jQuery end================/////////////////////////
		
		
		/////////////////////=============Function start=============/////////////////////////
		// 서버에 연결하는 함수 정의
		function connectToServer(){
			
			var options = {'forceNew' : true};
			var url = 'http://' + host + ':' + port;
			var senderId = $("#idInput").val();
			// 연결 요청
			socket = io.connect(url, options);
			
			
			///////////////////////////////////connect////////////////////////////////
			socket.on('connect', function(){
				
				println('웹 소켓 서버에 연결되었습니다. : '+ url);
				console.log('웹 소켓 서버에 연결되었습니다. : '+ url);
				
				
				////////////////////////////findChat//////////////////////////////////
				socket.on('findChatList', function(message){
					
					console.log("FROM DB"+JSON.stringify(message));
					
					//var sessionId = $('#idInput').val(); //세션아이디
					
					var sessionId = "${user.userId}"; 
					
					for(var i = 0; i < message.length; i++) {
						println('<p>디비에서 가져온 채팅 : ' +message[i].sender+ ', ' + message[i].recipient + ', '+ message[i].data +','+message[i].time+'</p>');
						//addToDiscussion('self', message[i].message, message[i].time);
						
						//alert(message[i].sender)
						if(sessionId == message[i].sender) {
							//addToDiscussion('self', message[i]);
						} else {
							addToDiscussion('other', message[i]);
						}
						
					}
					
				});
				
				////////////////////////////disconnect//////////////////////////////////
				socket.on('disconnect', function(){
					println('웹 소켓 연결이 종료되었습니다.');
				});
				
				
				////////////////////////////response//////////////////////////////////
				socket.on('response', function(response){
					console.log(JSON.stringify(response));
					println('응답 메세지를 받았습니다. : ' + response.command + ', ' + response.code + ', ' + response.message);
				});
			
				
			});
		}
		
		function println(data) {
			console.log(data);
			$('#result').append('<p>'+data+'</p>');
		}
		
		
		function addToDiscussion(writer, message){
			var msg = message.data;
			var time = message.time;
			println("addToDiscussion 호출됨 : " + writer + ", " + msg);
			var img;
			var contents;
			var recipient;
			var sender;
			
			
			if(writer == 'other'){
				//alert("otehr");
				///////////////recipient는 서버에서 받은걸로
				img = 'default_profile_image.jpg';
				//recipient = message.sender;
				sender = message.senNick;
				
				
				contents = '<div class="row">'
							+'<div class="col-md-offset-2 col-md-8">'
							+'<div class="panel panel-default">'
							+'<div class="panel-body">'
							+'<div class="col-md-2">'
							+"<div class = 'avatar'>"
							+'<img width="100%" height="100%" src="/resources/image/chat/Messages-icon.png">'
							+'</div>'
							+'</div>'
							+'<div class="col-md-10">'
							+'<div>'+sender+'</div>'
							+'<div class = "message">'
							+'<p>' + msg + '</p>'
							/* +"<time datetime='2017-10-05 13:52'>"+time+"</time>" */
							+'<time datetime="yyyy-mm-ddThh:mm:ss:Z">'+time+'</time>'
							+"</div>"
							+'</div>'
							+'</div>'
							+'</div>'
							+'</div>'
							+'</div> ';
								
				console.log("추가할 HTML : " + contents);
				$(".discussion").append(contents);
			
			}else{
				
				img = '${sender.profileImage}';
				sender = '${sender.nickname}';
				
				contents = "<li class = '"+writer+"'>"
							+"<div>"+sender+"</div>"
							+"<div class = 'avatar'>"
							+"<img class = 'img-circle' src = '/resources/uploadFile/" + img + "'width='40' length='40'/>"
							+"</div>"
							+"<div class = 'message'>"
							+"<p>" + msg + "</p>"
							+"<time datetime='yyyy-mm-ddThh:mm:ss:Z'>"+time+"</time>"
							+"</div>"
							+"</li>";
								
				println("추가할 HTML : " + contents);
				$(".discussion").append(contents);
				$("#dataInput").val("");
				
			}
		}
		
		
		///////////////////////////시간////////////////////////////////////////////////////////////
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
		
		/////////////////////=============Function end=============/////////////////////////
		
	</script>
	
	<style>
	
		 body { 
	    	font: 13px Helvetica, Arial;
	    	background-color:  #f2f4f6;
	    	padding-top : 70px;
	    }
	    
		/* #titleText{
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
  			padding : 0 0 50px 0;
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
  		
  		////////////////////////////////////////////////////////////////////
  		* {
  			margin: 0; padding: 0; box-sizing: border-box; 
  		}
	    
	    body { 
	    	font: 13px Helvetica, Arial;
	    	background-color: #b4c9ed;
	    }
	      
	    #message { background: #ffffff; padding: 3px; position: fixed; bottom: 0; width: 100%; }
	      
	    #message input { border: none; padding: 10px; width: 70%; margin-right: 5%; }
	      
	    #message button { width: 15%; background: #ff5959; border: none; padding: 10px; } */
	      
	    /* #messages { list-style-type: none; margin: 0; padding: 0; }
	      
	    #messages li { padding: 5px 10px; }
	      
	    #messages li:nth-child(odd) { background: #eee; } */
	</style>
</head>
<body>

	<!-- 툴바 -->
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	
	
	<!-- 채팅목록 -->
	<div class="container">
	
		<div class="row">
			<div class="col-md-offset-2 col-md-6">
				<h1>Chatting List</h1>
				<small> ${sender.nickname}의 채팅목록</small>
			</div>
		</div>
		
		
		<%-- <div class="row">
			<div class="col-md-offset-2 col-md-8">
				<!-- 채팅목록 -->
					<div class="panel panel-default">
						<div class="panel-body">
							<!-- 썸네일 이미지 -->
							<div class="col-md-2">
									<input type="hidden" name="referNo" value="${stat.referNo}">
									<img width="100%" height="100%" src="/resources/image/chat/Messages-icon.png">
									<!-- <div class="avatar"></div> -->
							</div>
							<div class="col-md-10">							
								<!-- 썸네일 설명 -->
								<!-- <div class="caption"> -->
									<!-- <div class="sender">
										<strong>까죵</strong> 
									</div>
									<div class="discussion">
										뭐라고
									</div>
									<div class="time">
										<small>몇시에</small>
									</div> -->
									<div class="discussion"></div>
								</div>
														
								</div>
							</div>
					</div>
				</div> --%>
				
				<div class="discussion"></div>
			</div>
	
	<!-- </div> -->
	
	<!-- 로그인시 서버에 보낼 정보 -->
	<input type = "hidden" id = "hostInput" value = "localhost">
	<input type = "hidden" id = "portInput" value = "3000">
	<!-- 보낼 유저 정보 -->
	<input type = "hidden" id = "sender" value="${sender.userId}">
	<input type = "hidden" id = "senNick" value="${sender.nickname}">
	<%-- <input type = "hidden" id = "recNick" value="${recipient.nickname}"> --%>
	
	
	
	
	
	<!-- 채팅창 -->
	<div id="chatList"></div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- chatting form -->
	<%-- <form name="form">
		
		<!--//////////////// 그룹방방방방방 ////////////////-->
		<input type="text" id="roomIdInput" value="${ party.partyNo }">
		<input type="text" id="roomNameInput" value="${ party.partyName }">
		<button id="createRoomBtn" type='button' class='btn-sm btn-default'>방만들기</button>
		<input type="hidden" name="roomRecipient" value="ALL">
		<button id="joinRoomBtn" type="button" class=" btn-default">방 입장</button>
		<button id="leaveRoomBtn" type="button" class=" btn-default">방 나가기</button>
	</form>
	
	<input type="hidden" id="chatType" value="groupChat">
	그룹방 전용 메시지 : <input type="text" id="groutDataInput">
	<button id="groupBtn" type="button" class=" btn-default">전송</button>
	
	
	<div id="roomList"></div>
	
	
	<div class = "container">
		<div id = "cardbox" class = "ui blue fluid card">
			<div class = "content">
				<div class = "left floated author">
					<img id = "iconImage" class = "ui avatar image" src = "/resources/image/chat/Messages-icon.png" width="45px" height="45px">
				</div>
				<div>
					<div id = "titleText" class = "header">MOANA</div>
					<div id = "contentsText" class = "description">
						${ sender.nickname } 님 채팅
					</div>
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
	
	
	
	<hr/>
	
	<!-- 채팅 확인창 -->
	<div id="currentDate"></div>
	<hr/>
	<h4 class = "ui horizontal divider header">메세지</h4>
	
	<div class = "ui segment" id = "result"></div>

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