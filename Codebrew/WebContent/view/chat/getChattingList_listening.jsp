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
		var partyNo;
		var partyName;
		var roomName;
		var userImg;
		
		function getMyPartyList() {
			
			$.ajax({
				
				url : "/partyRest/json/getMyPartyList",
				method : "POST",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					searchCondition : 4
				}),
				dataType : "json",
				success : function(JSONData) {
					//console.log(JSON.stringify(JSONData.list));
					var partyList = JSONData.list;
					for(var i = 0; i < partyList.length; i++) {
						//console.log(partyList[i].partyNo+","+partyList[i].partyName);
						partyNo = partyList[i].partyNo;
						partyName = partyList[i].partyName;
						
						////////////////////////////그룹채팅 리스트 조회 //////////////////////////////////////////////
						output = {
								roomId : partyNo,
								sender : "${user.userId}"
						};
						
						//console.log('[그룹채팅 찾기] 서버로 보낼 데이터 : ' + JSON.stringify(output));
						
						if(socket == undefined){
							alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
							return;
						}
						
						socket.emit('findGroupChatList', output);
						
					}
				}				
			});
			
		}
		
		function getPartyAjax(partyNo, message) {
			
			$.ajax({
				
				url : "/partyRest/json/getParty/"+partyNo,
				method : "GET",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				dataType : "json",
				success : function(JSONData) {
					console.log("겟파티!!!!"+JSON.stringify(JSONData.partyName));
					roomName =  JSONData.partyName;
				}				
				
			});
			//addToGroupDiscussion(message, roomName);
		}
		
		function getUser(userId) {
			var users;
			$.ajax({
				
				url : "/userRest/json/getUser",
				method : "POST",
				/* headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				}, */
				data : {
					userId : userId
				},
				dataType : "json",
				success : function(JSONData) {
					console.log(JSON.stringify(JSONData.profileImage));
					users = {
							nickName : JSONData.nickName
					}
				}				
			});
			return users;
			
		}
		
		/////////////////////============jQuery start================/////////////////////////
		$(function(){
			
			//////오늘 날짜 출력
			printDate();
			
			/////마이파티 리스트 ajax
			getMyPartyList();
			
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
			
			
			var senders = [];
			///////////////////////////////////connect////////////////////////////////
			socket.on('connect', function(){
				
				println('웹 소켓 서버에 연결되었습니다. : '+ url);
				console.log('웹 소켓 서버에 연결되었습니다. : '+ url);
				
				
				//////////////////////////////message////////////////////////////////
				socket.on('message', function(message){
					alert(JSON.stringify(message));
					
					//println('<p>수신 메세지 : ' + message.sender + ', ' + message.recipient + ', '
						//	+ message.command + ', ' + message.type + ', ' + message.data +','+message.time+ '</p>');
					
					//addToDiscussion('other', message.data, message.time, message.flag);
				});
				
				
				////////////////////////////findChat//////////////////////////////////
				socket.on('findChatList', function(message){
					
					console.log("FROM DB"+JSON.stringify(message));
					
					//var sessionId = $('#idInput').val(); //세션아이디
					
					var sessionId = "${user.userId}"; 
					
					//alert(message);
					
					var senNicks = [];
					
					alert("데이터!!"+JSON.stringify(message));
					for(var i = 0; i < message.length; i++) {
						
						console.log("메시지 주고받은 사람--> "+message[i].senders);
						senders = message[i].senders;
						
						
						
						//addToDiscussion(message[i]);
						
					} 
					
					for(var i = 0; i < senders.length; i ++) {
						
						//alert(senders[i]);
						//var user = getUser(senders[i]);
						//alert("에이작스유저"+JSON.stringify(user));
						//addToDiscussion(senders[i], senNicks[i]);
						
						addToDiscussion(senders[i]);
						
						////////////////////////////findChat//////////////////////////////////
						var output = {
								sender : sessionId,
								recipient : senders[i].sender
						};
						
						console.log('서버로 보낼 데이터 : ' + JSON.stringify(output));
						//socket.emit('findLastChat', output);
						
						/* var output = {
								sender : senders[i],
								recipient : '${user.userId}'
						};
						
						console.log('[findLastChat   ]서버로 보낼 데이터 : ' + JSON.stringify(output));
						
						if(socket == undefined){
							alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
							return;
						} */
						
						//socket.emit('findLastChat', output);
					}
					
					//var senders = message[i].senders;
					
				});
				
				////////////////////////////findChat//////////////////////////////////
				socket.on('findLastChat', function(message){
					
					alert("마지막FROM DB"+JSON.stringify(message));
					
					
					/* for(var i = 0; i < message.length; i++) {
						println('<p>디비에서 가져온 채팅 : ' +message[i].sender+ ', ' + message[i].recipient + ', '+ message[i].data +','+message[i].time+'</p>');
						
						
					} */
					//addToLastMessage(message.data); 
					addToDiscussion(senders[i], message.data);
				});
				
				
				////////////////////////////findGroupChat//////////////////////////////////
				socket.on('findGroupChatList', function(message){
					
					console.log("FROM DB"+JSON.stringify(message));
					
					//alert(JSON.stringify(message));
					for(var i = 0; i < message.length; i++) {
						var roomId = message[i].roomId;
						var members = message[i].members;
						alert(roomId+", "+members);
						//getPartyAjax(roomId);
						getPartyAjax(roomId, message[i]);
						//alert("에이작스에서 얻은 파티네임"+roomName);
						addToGroupDiscussion(message[i]);
					}
					
					
				});
				
				
				//추가
				function addToLastMessage(message){
					contents ='<div>'+message+'</div>';
							
									
					console.log("추가할 HTML : " + contents);
					$(".message").append(contents);
				
					
				}
				
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
		
		/////////////////////////////////////////일대일 채팅 리스트 html////////////////////////////////////////////
		function addToDiscussion(senders){
			/* var msg = message.data;
			var time = message.time;
			println("addToDiscussion 호출됨 : " + writer + ", " + msg);
			var img;
			var contents;
			var recipient; */
			
			 alert("에드투디스커션-"+JSON.stringify(senders));
				//alert("otehr");
				///////////////recipient는 서버에서 받은걸로
				img = '/resources/image/chat/chat.png';
				//recipient = message.sender;
				//sender = message.senNick;
				var sender = senders.sender+"";
				var senNick = senders.senNick;
				
				contents = '<div class="row">'
								+'<div class="col-md-offset-2 col-md-8">'
								+'<div class="panel panel-default chatting">'
								
								
								+'<div class="panel-body"'
								+"onclick=javascript:chatPopup('${user.userId}','"+sender+"');>"
								/* +'<form name="form">'
								+'<input type="hidden" name="recipient" value="'+sender+'">'
								+'<input type="hidden" name="sender" value="${user.userId}">' */
								/* +'<button type="button" class="btn btn-default pull-right" '
								+'onclick="javascript:chatPopup(this.form);">채팅하기</button>' */
								/* +'</form>' */
								+'<div class="col-md-2">'
								+"<div class = 'avatar'>"
								+'<img width="67px" height="67px" src="'+img+'">'
								+'</div>'
								+'</div>'
							   /*  +'<div class="col-md-10">'
								+'<div>'+sender+'</div>' */
								+'<div class="col-md-10">'
								+'<div>'+senNick+'</div>'
								+'<div class = "message">'
								 /* +'<p>' + data + '</p>' */
								/* +"<time datetime='2017-10-05 13:52'>"+time+"</time>" */
								/* +'<time datetime="yyyy-mm-ddThh:mm:ss:Z">'+time+'</time>' */
								+'</div>'
								+'</div>'
								+'</div>'
								+'</div>'
								+'</div>'
								+'</div> ';
								
				console.log("추가할 HTML : " + contents);
				
				$(".discussion").append(contents);
		}
		
		/////////////////////////////////////////그룹 채팅 리스트 html////////////////////////////////////////////
		function addToGroupDiscussion(message){
				
				var members = message.members;
				var roomId = message.roomId;
				var senNicks = message.senNicks;
				var img = "/resources/image/chat/group.png"; ///default 이미지
				//var roomName = partyName;
				
				contents = '<div class="row">'
								+'<div class="col-md-offset-2 col-md-8">'
								+'<div class="panel panel-default chatting">'
								+'<div class="panel-body"'
								+"onclick=javascript:chatGroupPopup('${user.userId}','"+roomId+"');>"
								+'<div class="col-md-2">'
								+"<div class = 'avatar'>"
								+'<img width="67px" height="67px" src="'+img+'">'
								+'</div>'
								+'</div>'
								/* +'<div class="col-md-10">'
								+'<div>'+members+'</div>' */
								+'<div class="col-md-10">'
								+'<div>'+senNicks+'</div>'
								/* +'<div class="col-md-10">'
								+'<div>'+roomName+'</div>' */
								+'<div class = "groupmessage">'
								 +'<p><h4>' + message.data + '</h4></p>' 
								+"<time datetime='2017-10-05 13:52'>"+message.time+"</time>" 
								+'</div>'
								+'</div>'
								+'</div>'
								+'</div>'
								+'</div>'
								+'</div> ';
								
				console.log("추가할 HTML : " + contents);
				
				//////////////////////////////////////클릭시 대화방 입장//////////////////////////////////////////////////////////
				$(".discussion").append(contents);
				
			
		}
		
		///////////////////////////////////////////////////////채팅 팝업 띄우기/////////////////////////////////////////////////////
		function chatPopup(sender, recipient) {
			alert("팝업");
			var url = "/chat/getChatting?sender="+sender+"&recipient="+recipient;
			var title = "chatPop";
			var status = "toolbar=no,directories=no,scrollbars=yes,resizable=no,status=no,menubar=no,width=440, height=520, top=0,left=20";
			window.open(url, title, status); //window.open(url,title,status); window.open 함수에 url을 앞에와 같이
		}
		
		function chatGroupPopup(sender, roomId) {
			alert("그룹팝업-"+sender+","+roomId);
			var url = "/chat/getGroupChatting?sender="+sender+"&roomId="+roomId;
			var title = "chatPop";
			var status = "toolbar=no,directories=no,scrollbars=yes,resizable=no,status=no,menubar=no,width=440, height=520, top=0,left=20";
			window.open(url, title, status); //window.open(url,title,status); window.open 함수에 url을 앞에와 같이
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
		
		<%-- 파티넘버
		<c:forEach var="party" items="${list}">
			${party.partyName}, ${party.partyNo}
		</c:forEach> --%>
		
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
	
	
	
	<!-- chatting form -->
	<%-- <form name="form">
		<input type="hidden" name="recipient" value="${party.user.userId}">
		<input type="hidden" name="sender" value="${user.userId}">
			<button type='button' class='btn-sm btn-default pull-right'
				onclick="javascript:chatPopup(this.form);">채팅하기</button>
		<br>
	</form> --%>




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