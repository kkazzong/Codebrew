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
			//////////////////////////////로그인///////////////////////////////////
			var sender = $('#sender').val();
			var senNick = $('#senNick').val();
			
			var output = {id : sender, alias : senNick};
			console.log('서버로 보낼 데이터 : '+ JSON.stringify(output));
			
			if(socket == undefined){
				alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
				return;
			}
			
			socket.emit('login', output);
			
			//var recipientId = $('#recipientInput').val();
			
			var output = {senderId : sender};
			console.log('서버로 보낼 데이터 : '+ JSON.stringify(output));
			
			if(socket == undefined){
				alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
				return;
			}
			
			socket.emit('loginList', output);
			
			/////////////////////////////////////////////////////////////////////////////////
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
				
				
				////////////////////////////findChat//////////////////////////////////
				socket.on('findChatList', function(message){
					
					console.log("FROM DB"+JSON.stringify(message));
					
					//var sessionId = $('#idInput').val(); //세션아이디
					
					var sessionId = "${user.userId}"; 
					
					//alert(message);
					
					var senNicks = [];
					var data = "";
					var time = "";
					//alert("데이터!!"+JSON.stringify(message));
					for(var i = 0; i < message.length; i++) {
						
						console.log("메시지 주고받은 사람--> "+message[i].senders);
						senders = message[i].senders;
						
						data = message[i].data;
						time = message[i].time;
						//addToDiscussion(message[i]);
						
					} 
					
					for(var i = 0; i < senders.length; i ++) {
						
						addToDiscussion(senders[i], data, time);
						
						var output = {
								sender : senders[i].sender,
								recipient : '${user.userId}' ////////////////나!
						};
						
						console.log('[findLastChat   ]서버로 보낼 데이터 : ' + JSON.stringify(output));
						
						if(socket == undefined){
							alert('서버에 연결되어 있지 않습니다. 먼저 서버에 연결하세요.');
							return;
						} 
						
						socket.emit('findLastChat', output);
					}
					
				});
				
				////////////////////////////findChat//////////////////////////////////
				socket.on('findLastChat', function(message){
					
					//alert("마지막FROM DB"+JSON.stringify(message));
					addToDiscussion(senders[i], message.data, message.time);
					
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
				
				///////////////////////////listenMessage/////////////////////////////////
				socket.on('messageOnList', function(message){
					
					//alert("[messageOnList]"+JSON.stringify(message));
					
					var data = "<p><h4>"+message.data+"</h4><p>";
					data += "<time datetime='yyyy-mm-ddThh:mm:ss:Z'>"+message.time+"</time>"
					var sender = message.recipient+"";
					var sessionId = "${user.userId}";
					var senNick = "";
					
					if(message.command == 'chat') {
						
						if(sessionId == sender) {
							senNick = message.senNick;
						} else {
							senNick = message.recNick;
						}
						$("#"+senNick).html(data); 
						
					} else if(message.command == 'groupChat') {
						
						var roomId = message.roomId+"";
						$("#"+roomId).html(data);
						
					} else {
						
						if(sessionId == sender) {
							//alert("딴사람");
							senNick = message.senNick;
						} else {
							//alert("내가보낸고");
							senNick = message.recNick;
						}
						$("#"+senNick).html(data); 
						
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
		function addToDiscussion(senders, data, time){
				///////////////recipient는 서버에서 받은걸로
				img = '/resources/image/chat/chat.png';
				var sender = senders.sender+"";
				var senNick = senders.senNick;
				
				contents = '<div class="row">'
								+'<div class="col-md-offset-2 col-md-8">'
								+'<div class="panel panel-default chatting">'
								+'<div class="panel-body"'
								+"onclick=javascript:chatPopup('${user.userId}','"+sender+"');>"
								+'<div class="col-md-2">'
								+"<div class = 'avatar'>"
								+'<img width="67px" height="67px" src="'+img+'">'
								+'</div>'
								+'</div>'
								+'<div class="col-md-10">'
								+'<div>'+senNick+'</div>'
								+'<div id = "'+senNick+'">'
								 +'<p><h4>' + data + '</h4></p>' 
								+"<time datetime='2017-10-05 13:52'>"+time+"</time>" 
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
								+'<div class="col-md-10">'
								+'<div>'+senNicks+'</div>'
								+'<div id="'+roomId+'" class = "groupmessage">'
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
			//alert("팝업");
			var url = "/chat/getChatting?sender="+sender+"&recipient="+recipient;
			var title = "chatPop";
			var status = "toolbar=no,directories=no,scrollbars=yes,resizable=no,status=no,menubar=no,width=440, height=520, top=0,left=20";
			window.open(url, title, status); //window.open(url,title,status); window.open 함수에 url을 앞에와 같이
		}
		
		function chatGroupPopup(sender, roomId) {
			//alert("그룹팝업-"+sender+","+roomId);
			var url = "/chat/getGroupChatting?sender="+sender+"&roomId="+roomId;
			var title = "chatPop";
			var status = "toolbar=no,directories=no,scrollbars=yes,resizable=no,status=no,menubar=no,width=440, height=520, top=0,left=20";
			window.open(url, title, status); //window.open(url,title,status); window.open 함수에 url을 앞에와 같이
		}
		
		//채팅방 나갔을 때 이벤트 발생
		function exit() {
			
				
				alert('Handler for .unload() called.');
	
				 var sender = "${user.userId}";
				
				var output = {
						sender : sender
				};
				
				console.log('서버로 보낼 데이터 : ' + JSON.stringify(output));
				socket.emit('exitList', output) ;
			//});
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
	    
	</style>
</head>
<body onbeforeunload="exit()">

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

				
				<div class="discussion"></div>
			</div>
	
	
	<!-- 로그인시 서버에 보낼 정보 -->
	<input type = "hidden" id = "hostInput" value = "192.168.0.4">
	<input type = "hidden" id = "portInput" value = "3000">
	<!-- 보낼 유저 정보 -->
	<input type = "hidden" id = "sender" value="${sender.userId}">
	<input type = "hidden" id = "senNick" value="${sender.nickname}">

	<!-- 채팅창 -->
	<div id="chatList"></div>
	
</body>
</html>