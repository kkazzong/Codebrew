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
				var data = $('#dataInput').val();
				var time = $('#dataInputTime').val();
				
				var output = {sender : sender, recipient : recipient, senNick : senNick, command : 'chat', type  : 'text', data : data, time : time};
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
					} else{
						addToDiscussion('other', message.data, message.time, message.flag);
					}
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
			
				contents = "<li class = '"+writer+"'>"
							+"<div>"+recipient+"</div>"
							+"<div class = 'avatar'>"
							+"<img class = 'img-circle' src = '/resources/uploadFile/" + img + "'width='40' length='40'/>"
							+"</div>"
							+"<div class = 'message'>"
							+"<p>" + msg + "</p>"
							+"<p>" + flag + "</p>"
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
		
		var me = {};
		me.avatar = "https://lh6.googleusercontent.com/-lr2nyjhhjXw/AAAAAAAAAAI/AAAAAAAARmE/MdtfUmC0M4s/photo.jpg?sz=48";

		var you = {};
		you.avatar = "https://a11.t26.net/taringa/avatares/9/1/2/F/7/8/Demon_King1/48x48_5C5.jpg";

		function formatAMPM(date) {
		    var hours = date.getHours();
		    var minutes = date.getMinutes();
		    var ampm = hours >= 12 ? 'PM' : 'AM';
		    hours = hours % 12;
		    hours = hours ? hours : 12; // the hour '0' should be '12'
		    minutes = minutes < 10 ? '0'+minutes : minutes;
		    var strTime = hours + ':' + minutes + ' ' + ampm;
		    return strTime;
		}            

		//-- No use time. It is a javaScript effect.
		function insertChat(who, text, time = 0){
		    var control = "";
		    var date = formatAMPM(new Date());
		    
		    if (who == "me"){
		        
		        control = '<li style="width:100%">' +
		                        '<div class="msj macro">' +
		                        '<div class="avatar"><img class="img-circle" style="width:100%;" src="'+ me.avatar +'" /></div>' +
		                            '<div class="text text-l">' +
		                                '<p>'+ text +'</p>' +
		                                '<p><small>'+date+'</small></p>' +
		                            '</div>' +
		                        '</div>' +
		                    '</li>';                    
		    }else{
		        control = '<li style="width:100%;">' +
		                        '<div class="msj-rta macro">' +
		                            '<div class="text text-r">' +
		                                '<p>'+text+'</p>' +
		                                '<p><small>'+date+'</small></p>' +
		                            '</div>' +
		                        '<div class="avatar" style="padding:0px 0px 0px 10px !important"><img class="img-circle" style="width:100%;" src="'+you.avatar+'" /></div>' +                                
		                  '</li>';
		    }
		    setTimeout(
		        function(){                        
		            $("ul").append(control);

		        }, time);
		    
		}

		function resetChat(){
		    $("ul").empty();
		}

		$(".mytext").on("keyup", function(e){
		    if (e.which == 13){
		        var text = $(this).val();
		        if (text !== ""){
		            insertChat("me", text);              
		            $(this).val('');
		        }
		    }
		});

		//-- Clear Chat
		resetChat();

		//-- Print Messages
		insertChat("me", "Hello Tom...", 0);  
		insertChat("you", "Hi, Pablo", 1500);
		insertChat("me", "What would you like to talk about today?", 3500);
		insertChat("you", "Tell me a joke",7000);
		insertChat("me", "Spaceman: Computer! Computer! Do we bring battery?!", 9500);
		insertChat("you", "LOL", 12000);


		//-- NOTE: No use time on insertChat.
		
	</script>
	
	<style>
	.mytext{
    border:0;padding:10px;background:whitesmoke;
}
.text{
    width:75%;display:flex;flex-direction:column;
}
.text > p:first-of-type{
    width:100%;margin-top:0;margin-bottom:auto;line-height: 13px;font-size: 12px;
}
.text > p:last-of-type{
    width:100%;text-align:right;color:silver;margin-bottom:-7px;margin-top:auto;
}
.text-l{
    float:left;padding-right:10px;
}        
.text-r{
    float:right;padding-left:10px;
}
.avatar{
    display:flex;
    justify-content:center;
    align-items:center;
    width:25%;
    float:left;
    padding-right:10px;
}
.macro{
    margin-top:5px;width:85%;border-radius:5px;padding:5px;display:flex;
}
.msj-rta{
    float:right;background:whitesmoke;
}
.msj{
    float:left;background:white;
}
.frame{
    background:#e0e0de;
    height:450px;
    overflow:hidden;
    padding:0;
}
.frame > div:last-of-type{
    position:absolute;bottom:5px;width:100%;display:flex;
}
ul {
    width:100%;
    list-style-type: none;
    padding:18px;
    position:absolute;
    bottom:32px;
    display:flex;
    flex-direction: column;

}
.msj:before{
    width: 0;
    height: 0;
    content:"";
    top:-5px;
    left:-14px;
    position:relative;
    border-style: solid;
    border-width: 0 13px 13px 0;
    border-color: transparent #ffffff transparent transparent;            
}
.msj-rta:after{
    width: 0;
    height: 0;
    content:"";
    top:-5px;
    left:14px;
    position:relative;
    border-style: solid;
    border-width: 13px 13px 0 0;
    border-color: whitesmoke transparent transparent transparent;           
}  
input:focus{
    outline: none;
}        
::-webkit-input-placeholder { /* Chrome/Opera/Safari */
    color: #d4d4d4;
}
::-moz-placeholder { /* Firefox 19+ */
    color: #d4d4d4;
}
:-ms-input-placeholder { /* IE 10+ */
    color: #d4d4d4;
}
:-moz-placeholder { /* Firefox 18- */
    color: #d4d4d4;
}   
	</style>
</head>
<body>
        <div class="col-sm-3 col-sm-offset-4 frame">
            <ul></ul>
            <div>
                <div class="msj-rta macro" style="margin:auto">                        
                    <div class="text text-r" style="background:whitesmoke !important">
                        <input class="mytext" placeholder="Type a message"/>
                    </div> 
                </div>
            </div>
        </div>        
    </body>
</html>