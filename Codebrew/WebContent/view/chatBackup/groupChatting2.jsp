<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name = "viewport" content = "width = device-width, height = device-height, initial-scale = 1">
	
	<title>채팅 클라이언트 02</title>
	
	<link href = "./semantic.min.css" rel = "stylesheet">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.0.3/socket.io.js"></script>
	<script src = "semantic.min.js"></script>
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
			
			//////오늘 날짜 출력
			printDate();
			
			//$("#connectButton").on('click', function(event){
				//println('connectButton이 클릭되었습니다.');
				host = $('#hostInput').val();
				port = $('#portInput').val();
				
				connectToServer();
			//});
			
			
			/////////////////////그룹톡 전송/////////////////////
			$("#sendButton").on('click', function(event){
				
					printClock();

					var chatType = $("#chatType").val(); ///////////////채팅 타입 : 그룹톡인지 그냥 톡인지
					var roomId = $("#roomIdInput").val();
					var sender = $('#senderInput').val();
					//var recipient = $("input:hidden[name='roomRecipient']").val(); ///////////////그룹방에 참여한 사람한테
					var recipient = "ALL";
					var senNick = $('#senNick').val(); //////////senNick추가////////////////////
					var recNick = $('#recNick').val();
					var data = $('#dataInput').val();
					var time = $('#dataInputTime').val();
					
					
					var output = {
							command : chatType,
							roomId : roomId,
							sender : sender,
							recipient : recipient, 
							senNick : senNick,
							recNick : recNick,
							type  : 'text',
							data : data,
							time : time,
							
					}
					
					console.log("서버로 보낼 데이터 : "+JSON.stringify(output));
					
					if(socket == undefined){
						alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
						return;
					}
					
					socket.emit('message', output);
					//addToDiscussion('self',data,time);
					addToGroupDiscussion('self',output);
				
			});
			
			$("#dataInput").on('keydown',function(event){
				if(event.keyCode ==13){
					
					printClock();

					var chatType = $("#chatType").val(); ///////////////채팅 타입 : 그룹톡인지 그냥 톡인지
					var roomId = $("#roomIdInput").val();
					var sender = $('#senderInput').val();
					//var recipient = $("input:hidden[name='roomRecipient']").val(); ///////////////그룹방에 참여한 사람한테
					var recipient = "ALL";
					var senNick = $('#senNick').val(); //////////senNick추가////////////////////
					var recNick = $('#recNick').val();
					var data = $('#dataInput').val();
					var time = $('#dataInputTime').val();
					
					
					var output = {
							command : chatType,
							roomId : roomId,
							sender : sender,
							recipient : recipient, 
							senNick : senNick,
							recNick : recNick,
							type  : 'text',
							data : data,
							time : time
					}
					
					console.log("서버로 보낼 데이터 : "+JSON.stringify(output));
					
					if(socket == undefined){
						alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
						return;
					}
					
					socket.emit('message', output);
					//addToDiscussion('self',data,time);
					addToGroupDiscussion('self',output);
					
				}
			});
			
			
			//$("#loginButton").on('click', function(event){
				//alert('로그인 버튼 클릭!!')
				
				//==> 변경
				//var id = $('#idInput').val();
				//var alias = $('#senNick').val();
				var senderId = $('#senderInput').val();
				var recipientId = $('#recipientInput').val();
				
				//var output = {id : id};
				var output = {senderId : senderId, recipientId : recipientId};
				
				console.log('서버로 보낼 데이터 : '+ JSON.stringify(output));
				
				if(socket == undefined){
					alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
					return;
				}
				
				//==> 변경
				//socket.emit('login', output);
				socket.emit('admit', output);
			//});
			
			
				var roomId = $("#roomIdInput").val();
				var sender = $('#senderInput').val();
				/*var recipient = $('#recipientInput').val();
				var senNick = $('#senNick').val(); //////////senNick추가////////////////////
				var data = $('#dataInput').val();
				var time = $('#dataInputTime').val(); */
				
				var output2 = {
						roomId : roomId,
						sender : sender
				};
				console.log('findChat >>> 서버로 보낼 데이터 : ' + JSON.stringify(output2));
				
				if(socket == undefined){
					alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
					return;
				}
				
				socket.emit('findChat', output2);
				//addToDiscussion('self',data,time);
		
		
				/////////////////////채팅방만들기///////////////////// ==> 문서로딩 후 sender 아이디와 host 아이디를 비교
				//$(function(){
					
					//$("#createRoomBtn").on("click", function(){ 
						
						var senderId = $("#idInput").val(); //sender 아이디
						var senNick = "${user.nickname}"; /////////////////////새로추가 센닉
						var hostId = "${party.user.userId}"; //party host 아이디
						//alert("senderId ==> "+senderId);
						//alert("hostId ==> "+hostId);
						
						if(senderId == hostId){
							
							//alert("[방만들기] 호스트");
							var roomId = $("#roomIdInput").val();
							var roomName = $("#roomNameInput").val();
							var id = $("#idInput").val();
							
							var output = {
									command : 'create',
									roomId : roomId,
									roomName : roomName,
									roomOwner : id
							}
							
							console.log("서버로 보낼 데이터 : "+JSON.stringify(output));
							
							if(socket == undefined){
								alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
								return;
							}
							
							socket.emit('room', output);
							
						}else{
							
							/////////////////////방입장/////////////////////
							//$(function(){
								
								//$("#joinRoomBtn").on("click", function(){
									
									//alert("[방참여] 게스트");
									var roomId = $("#roomIdInput").val();
									
									var output = {
											command : 'join',
											roomId : roomId,
											senderId : senderId, //////새로추가 !!
											senNick : senNick
									}
									
									console.log("서버로 보낼 데이터 : "+JSON.stringify(output));
									
									if(socket == undefined){
										alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
										return;
									}
									
									socket.emit('room', output);
									
								//})
								
								
							//});
						}
						
					//})
				//});
		});	
	 
		
		
		
		
		//==> 추가
		var flag;
		// 서버에 연결하는 함수 정의
		function connectToServer(){
			
			var options = {'forceNew' : true};
			var url = 'http://' + host + ':' + port;
			var senderId = $("#idInput").val();
			
			
			
			// 연결 요청
			socket = io.connect(url, options);
			
			socket.on('connect', function(){
				println('웹 소켓 서버에 연결되었습니다. : '+ url);
				
				socket.on('message', function(message){
					
					console.log("groutdiscussion"+JSON.stringify(message));
					
					println('<p>수신 메세지 : ' + message.sender + ', ' + message.recipient + ', '
							+ message.command + ', ' + message.type + ', ' + message.data +','+message.time+ '</p>');
					
					var id = $('#idInput').val();
					
					if(senderId != message.sender){
						
						//addToDiscussion('other', message.data, message.time);
						addToGroupDiscussion('other', message);
					}
					
				});
				
				
				////////////////////////////채팅내용찾은거//////////////////////////////////
				socket.on('findChat', function(message){
					
					console.log("FROM DB"+JSON.stringify(message));
					
					var sessionId = $('#idInput').val(); //세션아이디
					
					for(var i = 0; i < message.length; i++) {
						println('<p>디비에서 가져온 채팅 : ' +message[i].sender+ ', ' + message[i].recipient + ', '+ message[i].data +','+message[i].time+'</p>');
						//addToDiscussion('self', message[i].message, message[i].time);
						
						//alert(message[i].sender)
						if(sessionId == message[i].sender) {
							//addToDiscussion('self', message[i].message, message[i].time);
							addToGroupDiscussion('self', message[i]);
						} else {
							//addToDiscussion('other', message[i].message, message[i].time);
							addToGroupDiscussion('other', message[i]);
						}
						
					}
					
				});
				
				/////////////////////////////////그룹 방 리스트 받음////////////////////////////////////
				/* socket.on('room', function(message){
					
					console.log("서버에서 받은 룸 데이터 : "+JSON.stringify(message));
					
					println('<p>방 이벤트 : ' +message.command+ '</p>');
					println('<p>방 리스트를 받았습니다 </p>');
					
					//방리스트
					if(message.command == 'list') {
						
						var roomCount = message.rooms.length;
						
						$("#roomList").html('<p>방 리스트 '+roomCount+'개</p>');
						
						for(var i = 0; i < roomCount; i++) {
							$("#roomList").append('<p>방 #'+i+' : '+message.rooms[i].id+', '+message.rooms[i].name+', '+message.rooms[i].owner+'</p>');
						}
						
					}
					
				}); */
				
				
				socket.on('room', function(message){
					
					console.log("서버에서 받은 룸 데이터 : "+JSON.stringify(message));
					
					println('<p>room 이벤트 : ' +message.command+ '</p>');
					println('<p>room 정보를 받았습니다 </p>');
					println('<p>room 안에 client 수 : '+message.count+'</p>');
					println('<p>파티 인원 수 : ${currentMemberCount} </p>');
					//==> 추가
					var partyMemberCount = message.count;
					var partyMemberLimit = "${currentMemberCount}";
					flag = partyMemberLimit;
					
					flag = flag-partyMemberCount;
					
					$('.flag').html(flag);
					
				});
				
				///////////////////////////////////새로들어온사람 정보받기////////////////////
				socket.on('join', function(message){
				
					console.log("서버에서 받은 룸 데이터 : "+JSON.stringify(message));
					
					println('<p>방 이벤트 : ' +message.command+ '</p>');
					println('<p>새로운 사람을 받았습니다 </p>');
					println('<p>room 안에 client 수 : '+message.count+'</p>');
					//==> 추가
					partyMemberCount = message.count;
					var partyMemberLimit = ${party.partyMemberLimit};
					flag = partyMemberLimit;
					flag = flag-partyMemberCount;
					
					$('.flag').html(flag);
					
					//방리스트
					if(message.command == 'join') {
						
						 addToJoin(message);						
					}
				});
					
				//////////////////////////////////호스트입장에서 다시 들어올때 //////////////////////
				socket.on('duplicate', function(message){
				
					console.log("[그룹채팅] 서버에서 받은 룸 데이터 : "+JSON.stringify(message));
					
					println('<p>방 이벤트 : ' +message.command+ '</p>');
					
					var roomId = $("#roomIdInput").val();
					
					var output = {
							command : 'join',
							roomId : roomId,
							senderId : senderId, //////새로추가 !!
							senNick : senNick
					}
					
					console.log("서버로 보낼 데이터 : "+JSON.stringify(output));
					
					if(socket == undefined){
						alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
						return;
					}
					
					socket.emit('room', output);
				
				});
				
				
			socket.on('disconnect', function(){
				println('웹 소켓 연결이 종료되었습니다.');
			});
			
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
		
		
		function addToDiscussion(writer, msg, time){
			println("addToDiscussion 호출됨 : " + writer + ", " + msg);
			var img;
			var contents;
			var recipient;
			var sender;
			
			
			if(writer == 'other'){
				//alert(msg);
				//img = '${recipient.profileImage}';
				//recipient = '${recipient.nickname}';
				///////////////recipient는 서버에서 받은걸로
				img = 'default_profile_image.jpg';
				recipient = msg.sender;
			
				contents = "<li class = '"+writer+"'>"
							+"<div>"+recipient+"</div>"
							+"<div class = 'avatar'>"
							+"<img class = 'img-circle' src = '/resources/uploadFile/" + img + "'width='40' length='40'/>"
							+"</div>"
							+"<div class = 'message'>"
							+"<p>" + msg + "</p>"
							/* +"<time datetime='2017-10-05 13:52'>"+time+"</time>" */
							+"<time datetime='yyyy-mm-ddThh:mm:ss:Z'>"+time+"</time>"
							+"</div>"
							+"</li>";
								
				println("추가할 HTML : " + contents);
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
		
		
		/////////////////그룹채팅///////////////////////////////////////////////////////////////////
		function addToGroupDiscussion(writer, message){
			println("addToGroupDiscussion 호출됨 : " + writer + ", " + msg);
			var img;
			var msg = message.data;
			var contents;
			var recipient;
			var sender;
			var time = message.time;
			
			
			if(writer == 'other'){
				//img = '${recipient.profileImage}';
				//recipient = '${recipient.nickname}';
				///////////////recipient는 서버에서 받은걸로
				img = 'default_profile_image.jpg';
				recipient = message.senNick;
				console.log("other임!!!!!!!!!!!!!!!!!!!!!!!!!!"+msg+recipient);
			
				contents = "<li class = '"+writer+"'>"
							+"<div>"+recipient+"</div>"
							+"<div class = 'avatar'>"
							+"<img class = 'img-circle' src = '/resources/uploadFile/" + img + "'width='40' length='40'/>"
							+"</div>"
							+"<div class = 'message'>"
							+"<p>" + msg + "</p>"
							+"<p class='flag'>" + flag + "</p>"
							/* +"<time datetime='2017-10-05 13:52'>"+time+"</time>" */
							+"<time datetime='yyyy-mm-ddThh:mm:ss:Z'>"+time+"</time>"
							+"</div>"
							+"</li>";
								
				println("추가할 HTML : " + contents);
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
							+"<p class='flag'>" + flag + "</p>"
							+"<time datetime='yyyy-mm-ddThh:mm:ss:Z'>"+time+"</time>"
							+"</div>"
							+"</li>";
								
				println("추가할 HTML : " + contents);
				$(".discussion").append(contents);
				$("#dataInput").val("");
				
			}
		}
		
		/* function addToJoin(message){
			println("addToGroupDiscussion 호출됨 : " +  msg);
			
				img = '${sender.profileImage}';
				sender = '${sender.nickname}';
				
				contents = "<li class = '"+writer+"'>"
							+"<div class = 'message'>"
							+"<p>" + msg.senNick + "님 입장!</p>"
							+"</div>"
							+"</li>";
								
				println("추가할 HTML : " + contents);
				$(".discussion").append(contents);
				$("#dataInput").val("");
				
		} */
			
		
		//////////////////////////입장시 알림/////////////////////////////////////
		 function addToJoin(message){
			println("addToJoin 호출됨 : " +  message);
			
				//img = '${sender.profileImage}';
				//sender = '${sender.nickname}';
				
				contents = "<ol class='join'><li>"
							+"<div class = 'message'>"
							+"<p>" + message.senNick + "님 입장!</p>"
							+"</div>"
							+"</li>"
							+"</ol>";
								
				println("추가할 HTML : " + contents);
				$(".discussion").append(contents);
				$("#dataInput").val("");
				
		} 
		
		//////////////////////////입장시 방 없을때/////////////////////////////////////
		 function addToAlert(){
			println("addToAlert 호출됨 : " +  message);
			
				//img = '${sender.profileImage}';
				//sender = '${sender.nickname}';
				
				contents = "<ol class='alert'><li>"
							+"<div class = 'message'>"
							+"<p>방이 아직 개설되지 않았슴다ㅠㅠ</p>"
							+"</div>"
							+"</li>"
							+"</ol>";
								
				println("추가할 HTML : " + contents);
				$(".alert").append(contents);
				$("#dataInput").val("");
				
		}
		
		
	</script>
	
	<style>
	
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
	      
	    #message button { width: 15%; background: #ff5959; border: none; padding: 10px; }
	      
	    /* #messages { list-style-type: none; margin: 0; padding: 0; }
	      
	    #messages li { padding: 5px 10px; }
	      
	    #messages li:nth-child(odd) { background: #eee; } */
	</style>
</head>
<body>
	
	<!-- chatting form -->
	<form name="form">
		
		<!--//////////////// 그룹방방방방방 ////////////////-->
		<%-- <input type="text" id="roomIdInput" value="${ party.partyNo }">
		<input type="text" id="roomNameInput" value="${ party.partyName }">
		<button id="createRoomBtn" type='button' class='btn-sm btn-default'>방만들기</button>
		<input type="hidden" name="roomRecipient" value="ALL">
		<button id="joinRoomBtn" type="button" class=" btn-default">방 입장</button>
		<button id="leaveRoomBtn" type="button" class=" btn-default">방 나가기</button> --%>
	</form>
	
	<!-- <input type="hidden" id="chatType" value="groupChat">
	그룹방 전용 메시지 : <input type="text" id="groutDataInput">
	<button id="groupBtn" type="button" class=" btn-default">전송</button> -->
	
	
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


	</div>
	
</body>
</html>