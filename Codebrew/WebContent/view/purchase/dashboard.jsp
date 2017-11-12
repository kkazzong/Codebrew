<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:if test="${ !empty user }">
	<c:if test="${user.role != 'a' }">
		<jsp:forward page="/index.jsp"></jsp:forward>
	</c:if>
</c:if>
<!DOCTYPE html>
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	
	<!-- UI -->
	<link rel="apple-touch-icon" sizes="76x76" href="/resources/css/dashboard/assets/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="/resources/css/dashboard/assets/img/favicon.png">
	<!-- Animation library for notifications   -->
    <link href="/resources/css/dashboard/assets/css/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="/resources/css/dashboard/assets/css/paper-dashboard.css" rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="/resources/css/dashboard/assets/css/demo.css" rel="stylesheet" />


    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="/resources/css/dashboard/assets/css/themify-icons.css" rel="stylesheet">
    
    
    
	<title>getSaleList</title>
	
	
	<!-- Bootstrap, jQuery CDN -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!-- jQuery ui -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>
	
	<link rel="stylesheet" href="/resources/css/badge.css">
	
	<!-- 자바스크립트 -->
	<script type="text/javascript">
	
		function fncGetList(currentPage) {
			console.log("페이지클릭 : "+currentPage);
			var arrange = $("input:hidden[name='arrange']").val();
			//alert(arrange);
			if(arrange != '' && arrange != null) {
				//alert("정렬");
				$("#currentPageSort").val(currentPage);
				$("#sortForm").attr("method", "POST").attr("action", "/purchase/getSaleList").submit();
			} else {
				//alert("검색");
				$("#currentPage").val(currentPage);
				$("#searchForm").attr("method", "POST").attr("action", "/purchase/getSaleList").submit();
			}
		}
		
		function fncSearchList() {
			$("#currentPage").val("1");
			$("#searchForm").attr("method", "POST").attr("action", "/purchase/getSaleList").submit();
		}
		
		function fncSortList(arrange) {
			//alert(arrange);
			$("#currentPageSort").val("1");
			$("input:hidden[name='arrange']").val(arrange);
			//alert($("#sortForm").serialize());
			$("#sortForm").attr("method", "POST").attr("action", "/purchase/getSaleList").submit();
		}
		
		$(function(){
			
			//page header 클릭(판매목록)
			$(".page-header").on("click", function(){
				self.location = "/purchase/getSaleList";
			})
			
			//enter key 검색
			$("#searchKeyword").on("keydown", function(event){
				
				if(event.keyCode == '13') {
					if($("#searchKeyword").val() == '') {
						event.preventDefault();
						alert("검색어를 입력해주세요");
						return;
					}
					event.preventDefault();
					fncGetList(1);
				}
	
			});
			
			//검색버튼
			$(".btn:contains('검색')").on("click", function(){
				
				if($("#searchKeyword").val() == '') {
					alert("검색어를 입력해주세요");
					return;
				}
				fncGetList(1);
				
			});
			
			//정렬 모달창에서 클릭한 모든 버튼
			$(".modal-content .btn").each(function(){}).on("click", function(){
				fncSortList($(this).val());
			});
			
			//검색조건 바꿀때
			$("#searchCondition").on("change", function(){
				
				if($(this).val() == '3') {
					$("#searchKeyword").attr("placeholder", "구매번호 입력");
				} else if($(this).val() == '4') {
					$("#searchKeyword").attr("placeholder", "회원아이디 입력");
				} else if($(this).val() == '5') {
					$("#searchKeyword").attr("placeholder", "티켓명 입력");
				} else if($(this).val() == ''){
					$("#searchKeyword").attr("placeholder", "검색조건 선택");
				}
				
			});
			
			//autocomplete
			$("#searchKeyword").autocomplete({
				source: function( request, response ) {
			        $.ajax( {
			          url: "/purchaseRest/json/getSaleList",
			          method : "POST",
			          headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
					  },
			          dataType: "json",
			          data: JSON.stringify({
			        	currentPage : "1",
			            searchKeyword : $("#searchKeyword").val(),
			            searchCondition : $("#searchCondition").val()
			          }),
			          success: function( JSONData ) {
			        		  
			        	console.log("server data =>"+JSON.stringify(JSONData));
			        	var searchCondition = $("#searchCondition").val();
			            response($.map(JSONData, function(value, key){
			            	console.log(value.user.userId);
			            	console.log("key(autocomplete : value)====>"+key);
			            	//아이디 검색 시
			            	if(searchCondition == 4) {
				        		return {
				        			label : value.user.userId,
				        			value : value.user.userId //원래는 key,, 선택시를 위해
				        		}
			            	} else if(searchCondition == 5) { //티켓명 검색 시
			            		return {
			            			label :  value.itemName,
			            			value : value.itemName
			            		}
			            	}
			        	}));
			          }
			        } );
			    }
			});
			
		});
		
	</script>
	
	<!-- CSS -->
	<style type="text/css">
	
		body {
			font-family: "Helvetica Neue", Helvetica, Arial;
		  font-size: 14px;
		  line-height: 20px;
		  font-weight: 400;
		  color: #3b3b3b;
		  padding-top : 70px;
		  -webkit-font-smoothing: antialiased;
		  font-smoothing: antialiased;
		  background-color: #f2f4f6;
	    }
	    
	     .text-info {
	    	color: #333333; 
	    }
	    
	    .page-header {
	    	border-bottom : 1px solid #f2f4f6;
	    }
	    
	    * {
			box-sizing: border-box;
		}
		 
		.navbar-brand > img {
				padding-bottom: 15px;
		}
		
		.navbar-default {
		    background-image: linear-gradient(to bottom,black 0,black 100%)!important;
		    box-shadow: inset 0 1px 0 rgba(255,255,255,.15), 0 1px 5px rgba(0,0,0,.075);
		}
		
		.dropdown-menu {
			background-color: black;
			color: white;
		}
		 
		.dropdown-menu {
			background-color: black;
			color: white;
		}
		 
		.dropdown-menu li a {
			color: #eee;
		}
		
		.navbar-nav>li>a {
			line-height: 35px;
			padding-top: 10px;
			padding-bottom: 10px;
		}
		
		.navbar-toggle {
			margin-top: 20px;
		}
		
		.navbar-default .navbar-nav>li>a {
			color: #cecece;
		}
	    
	   /*  .table {
	    	margin-top: 70px;
	    }
	    
	    .table>thead>tr>th {
	    	font-weight: 900;
			color: #ffffff;
			background: #ea6153;
	    	text-align: center;
	    }
	    
	    .table>tbody>tr>td {
	    	font-size: 17px;
	    }
	    
	    .thead-dark th{color:#fff;background-color:#212529;border-color:#32383e} */
	    /* div {
			border : 3px solid #D6CDB7;
			margin0top : 10px;
		} */
	
	</style>

</head>

<body>
	
	<!-- 툴바 -->
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>
	
	<!-- 모달 -->
	<jsp:include page="/view/purchase/filterModal.jsp"></jsp:include>
	
	<%-- 서치컨디션 ${search.searchCondition } <br>
	어레인지 ${search.arrange } --%>
	
	<!-- <div class="wrapper"> -->
   <!--  <div class="sidebar" data-background-color="white" data-active-color="danger"> -->

    <!--
		Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
		Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
	-->

    	<!-- <div class="sidebar-wrapper">
            <div class="logo">
                <a href="http://www.creative-tim.com" class="simple-text">
                    Creative Tim
                </a>
            </div>

            <ul class="nav">
                <li class="active">
                    <a href="dashboard.html">
                        <i class="ti-panel"></i>
                        <p>Dashboard</p>
                    </a>
                </li>
               
            </ul>
    	</div> -->
   <!--  </div> -->
	<div class="container">
		<div class="col-md-12">
    <div class="main-panel">
       

        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="content">
                                <div class="row">
                                    <div class="col-xs-5">
                                        <div class="icon-big icon-warning text-center">
                                            <i class="ti-server"></i>
                                        </div>
                                    </div>
                                    <div class="col-xs-7">
                                        <div class="numbers">
                                            <p>Sale</p>
                                            105GB
                                        </div>
                                    </div>
                                </div>
                                <div class="footer">
                                    <hr />
                                    <div class="stats">
                                        <i class="ti-reload"></i> Updated now
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="content">
                                <div class="row">
                                    <div class="col-xs-5">
                                        <div class="icon-big icon-success text-center">
                                            <i class="ti-wallet"></i>
                                        </div>
                                    </div>
                                    <div class="col-xs-7">
                                        <div class="numbers">
                                            <p>Party</p>
                                            $1,345
                                        </div>
                                    </div>
                                </div>
                                <div class="footer">
                                    <hr />
                                    <div class="stats">
                                        <i class="ti-calendar"></i> Last day
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="content">
                                <div class="row">
                                    <div class="col-xs-5">
                                        <div class="icon-big icon-danger text-center">
                                            <i class="ti-pulse"></i>
                                        </div>
                                    </div>
                                    <div class="col-xs-7">
                                        <div class="numbers">
                                            <p>Festival</p>
                                            23
                                        </div>
                                    </div>
                                </div>
                                <div class="footer">
                                    <hr />
                                    <div class="stats">
                                        <i class="ti-timer"></i> In the last hour
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="content">
                                <div class="row">
                                    <div class="col-xs-5">
                                        <div class="icon-big icon-info text-center">
                                            <i class="ti-twitter-alt"></i>
                                        </div>
                                    </div>
                                    <div class="col-xs-7">
                                        <div class="numbers">
                                            <p>Users</p>
                                            +45
                                        </div>
                                    </div>
                                </div>
                                <div class="footer">
                                    <hr />
                                    <div class="stats">
                                        <i class="ti-reload"></i> Updated now
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">

                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Moana's Sale</h4>
                                <p class="category">일간, 월간, 분기별로 판매량을 확인하세요.</p>
                            </div>
                            <div class="content">
                            	<jsp:include page="/view/statistics/getStatisticsTest.jsp"></jsp:include>
                               <!--  <div id="chartHours" class="ct-chart"></div> -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
    
    </div>
	</div>
<!-- </div>
			
	</div> -->
	
</body>
</html>