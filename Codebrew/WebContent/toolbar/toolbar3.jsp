<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Volton Free Responsive Template</title>
        <meta name="description" content="">
        <!-- 
    	Volton Template
    	http://www.templatemo.com/tm-441-volton
        -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <link rel="stylesheet" href="/resources/css/toolbar3/normalize.css">
        <link rel="stylesheet" href="/resources/css/toolbar3/font-awesome.css">
        <!-- <link rel="stylesheet" href="/resources/css/toolbar3/bootstrap.min.css"> -->
        <link rel="stylesheet" href="/resources/css/toolbar3/templatemo-style.css">
        <script src="/resources/css/toolbar3/js/vendor/modernizr-2.6.2.min.js"></script>
<title>Insert title here</title>
</head>
<style>

.image {
		display: inline-block;
		border: 0;
	}

		.image img {
			display: block;
			width: 100%;
		}

		.image.avatar48 {
			width: 48px;
			height: 48px;
			/* background: #f00; */
		}

			.image.avatar48 img {
				width: 48px;
				height: 48px;
				
				/* border: 3px solid gold; */
				border-radius: 30px;
				-moz-border-radius: 30px;
				-khtml-border-radius: 30px;
				-webkit-border-radius: 30px;
			}
			
			#logo h1 {
			position: relative;
			color: #fff;
			font-weight: 600;
			font-size: 1em;
			line-height: 1em;
		}

		#logo p {
			position: relative;
			display: block;
			font-size: 0.6em;
			color: rgba(255, 255, 255, 0.5);
			line-height: 1.25em;
			margin: 0.5em 0 0 0;
		}

		#logo .image {
			position: absolute;
			left: 0;
			top: 0;
		}
</style>
<!-- <div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew"> -->
<!-- SIDEBAR -->
        <div class="sidebar-menu hidden-xs hidden-sm collapse navbar-collapse"  id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
            <div class="top-section">
                <div class="image avatar48">
                    <img  class="image avatar48"src="/resources/uploadFile/default_profile_image.jpg" alt="profile image">
                </div>
                <h3 class="profile-title">${user.nickname }</h3>
                <p class="profile-description">${user.userId }</p>
            </div> <!-- top-section -->
            <div class="main-navigation">
                <ul class="navigation">
                    <li><a href="#top"><i class="fa fa-globe"></i>Welcome</a></li>
                    <li><a href="#about"><i class="fa fa-pencil"></i>About Me</a></li>
                    <li><a href="#projects"><i class="fa fa-paperclip"></i>My Gallery</a></li>
                    <li><a href="#contact"><i class="fa fa-link"></i>Contact Me</a></li>
                </ul>
            </div> <!-- .main-navigation -->
            <div class="social-icons">
                <ul>
                    <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                    <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                    <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                    <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                    <li><a href="#"><i class="fa fa-youtube"></i></a></li>
                    <li><a href="#"><i class="fa fa-rss"></i></a></li>
                </ul>
            </div> <!-- .social-icons -->
        </div> <!-- .sidebar-menu -->

<!-- </div> -->