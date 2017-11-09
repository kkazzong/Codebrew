<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>


	<!-- ----------------------UI -->
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
        
    <link rel="stylesheet" href="/resources/css/index/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/index/css/font-awesome.css">
    <link rel="stylesheet" href="/resources/css/index/css/animate.css">
    <link rel="stylesheet" href="/resources/css/index/css/templatemo_misc.css">
    <link rel="stylesheet" href="/resources/css/index/css/templatemo_style.css">

    <script src="/resources/css/index/js/vendor/modernizr-2.6.1-respond-1.1.0.min.js"></script>

	<script type="text/javascript">
	
	
	    
	</script>


	<style type="text/css">
	
		body {
	            padding-top : 50px;
	            padding-left : 50px;
	            /* color: #3b3b3b; */
	            /* background-color: #E0E0F8; */
	    }
	
	
	</style>

	<title>Moana</title>
	
</head>

<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	

<body>

	<div class="site-main" id="sTop">
           
            <div class="site-slider">
                <div class="slider">
                    <div class="flexslider">
                        <ul class="slides">
                            <li>
                                <div class="overlay"></div>
                                <img src="/resources/css/index/images/slide1.jpg" alt="">
                                <div class="slider-caption visible-md visible-lg">
                                    <h2>Digital Marketing</h2>
                                    <p>more visitors to your website</p>
                                    <a href="#" class="slider-btn">Let us design!</a>
                                </div>
                            </li>
                            <li>
                                <div class="overlay"></div>
                                <img src="/resources/css/index/images/slide2.jpg" alt="">
                                <div class="slider-caption visible-md visible-lg">
                                    <h2>Responsive HTML CSS</h2>
                                    <p>Download and use it for your site</p>
                                    <a href="#" class="slider-btn">Go to Portfolio</a>
                                </div>
                            </li>
                            <li>
                                <div class="overlay"></div>
                                <img src="/resources/css/index/images/slide3.jpg" alt="">
                                <div class="slider-caption visible-md visible-lg">
                                    <h2>Pro Level Design</h2>
                                    <p>High standard work</p>
                                    <a href="#" class="slider-btn">Mobile Website</a>
                                </div>
                            </li>
                        </ul>
                    </div> <!-- /.flexslider -->
                </div> <!-- /.slider -->
            </div> <!-- /.site-slider -->
        </div> <!-- /.site-main -->


        <div class="content-section" id="services">
            <div class="container">
                <div class="row">
                    <div class="heading-section col-md-12 text-center">
                        <h2>Our Services</h2>
                        <p>We design mobile-first websites for you</p>
                    </div> <!-- /.heading-section -->
                </div> <!-- /.row -->
                <div class="row">
                    <div class="col-md-3 col-sm-6">
                        <div class="service-item" id="service-1">
                            <div class="service-icon">
                                <i class="fa fa-file-code-o"></i>
                            </div> <!-- /.service-icon -->
                            <div class="service-content">
                                <div class="inner-service">
                                   <h3>Party</h3>
                                   <p>오늘은 누구와 함께 놀까? 고민하지 말고 같이 놀자! 지금 열린 파티들 구경하러 가자</p> 
                                </div>
                            </div> <!-- /.service-content -->
                        </div> <!-- /#service-1 -->
                    </div> <!-- /.col-md-3 -->
                    <div class="col-md-3 col-sm-6">
                        <div class="service-item" id="service-2">
                            <div class="service-icon">
                                <i class="fa fa-paper-plane-o"></i>
                            </div> <!-- /.service-icon -->
                            <div class="service-content">
                                <div class="inner-service">
                                   <h3>Festival</h3>
                                   <p>우리나라에서 열리는 축제는 무엇이 있을꼬</p> 
                                </div>
                            </div> <!-- /.service-content -->
                        </div> <!-- /#service-1 -->
                    </div> <!-- /.col-md-3 -->
                    <div class="col-md-3 col-sm-6">
                        <div class="service-item" id="service-3">
                            <div class="service-icon">
                                <i class="fa fa-institution"></i>
                            </div> <!-- /.service-icon -->
                            <div class="service-content">
                                <div class="inner-service">
                                   <h3>Review</h3>
                                   <p>그 축제 함 가볼까 말까 고민될땐 후기를 보는 것이 정답</p> 
                                </div>
                            </div> <!-- /.service-content -->
                        </div> <!-- /#service-1 -->
                    </div> <!-- /.col-md-3 -->
                    <div class="col-md-3 col-sm-6">
                        <div class="service-item" id="service-4">
                            <div class="service-icon">
                                <i class="fa fa-flask"></i>
                            </div> <!-- /.service-icon -->
                            <div class="service-content">
                                <div class="inner-service">
                                   <h3>Ticket</h3>
                                   <p>가고싶은 파티나 축제 있으면 티켓 구매 함 해볼꽈</p> 
                                </div>
                            </div> <!-- /.service-content -->
                        </div> <!-- /#service-1 -->
                    </div> <!-- /.col-md-3 -->
                </div> <!-- /.row -->
            </div> <!-- /.container -->
        </div> <!-- /#services -->



        <div class="content-section" id="portfolio">
            <div class="container">
                <div class="row">
                    <div class="heading-section col-md-12 text-center">
                        <h2>Our Portfolio</h2>
                        <p>Amazing work for our clients</p>
                    </div> <!-- /.heading-section -->
                </div> <!-- /.row -->
                <div class="row">
                    <div class="portfolio-item col-md-3 col-sm-6">
                        <div class="portfolio-thumb">
                            <img src="images/gallery/p1.jpg" alt="">
                            <div class="portfolio-overlay">
                                <h3>New Walk</h3>
                                <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p>
                                <a href="images/gallery/p1.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                    <div class="portfolio-item col-md-3 col-sm-6">
                        <div class="portfolio-thumb">
                            <img src="images/gallery/p2.jpg" alt="">
                            <div class="portfolio-overlay">
                                <h3>Boat</h3>
                                <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p>
                                <a href="images/gallery/p2.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                    <div class="portfolio-item col-md-3 col-sm-6">
                        <div class="portfolio-thumb">
                            <img src="images/gallery/p7.jpg" alt="">
                            <div class="portfolio-overlay">
                                <h3>Urban</h3>
                                <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p>
                                <a href="images/gallery/p7.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                    <div class="portfolio-item col-md-3 col-sm-6">
                        <div class="portfolio-thumb">
                            <img src="images/gallery/p8.jpg" alt="">
                            <div class="portfolio-overlay">
                                <h3>Cycling</h3>
                                <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p>
                                <a href="images/gallery/p8.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                    <div class="portfolio-item col-md-3 col-sm-6">
                        <div class="portfolio-thumb">
                            <img src="images/gallery/p3.jpg" alt="">
                            <div class="portfolio-overlay">
                                <h3>Digital Era</h3>
                                <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p>
                                <a href="images/gallery/p3.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                    <div class="portfolio-item col-md-3 col-sm-6">
                        <div class="portfolio-thumb">
                            <img src="images/gallery/p4.jpg" alt="">
                            <div class="portfolio-overlay">
                                <h3>Horizon</h3>
                                <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p>
                                <a href="images/gallery/p4.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                    <div class="portfolio-item col-md-3 col-sm-6">
                        <div class="portfolio-thumb">
                            <img src="images/gallery/p5.jpg" alt="">
                            <div class="portfolio-overlay">
                                <h3>Aquatic City</h3>
                                <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p>
                                <a href="images/gallery/p5.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                    <div class="portfolio-item col-md-3 col-sm-6">
                        <div class="portfolio-thumb">
                            <img src="images/gallery/p6.jpg" alt="">
                            <div class="portfolio-overlay">
                                <h3>New Path</h3>
                                <p>Asperiores commodi illo fuga perferendis dolore repellendus sapiente ipsum.</p>
                                <a href="images/gallery/p6.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                </div> <!-- /.row -->
            </div> <!-- /.container -->
        </div> <!-- /#portfolio -->




        <div class="content-section" id="our-team">
            <div class="container">
                <div class="row">
                    <div class="heading-section col-md-12 text-center">
                        <h2>Our Team</h2>
                        <p>Our people are very united for your success</p>
                    </div> <!-- /.heading-section -->
                </div> <!-- /.row -->
                <div class="row">
                    <div class="team-member col-md-3 col-sm-6">
                        <div class="member-thumb">
                            <img src="images/member1.jpg" alt="">
                            <div class="team-overlay">
                                <h3>Tracy</h3>
                                <span>Designer</span>
                                <ul class="social">
                                    <li><a href="#" class="fa fa-facebook"></a></li>
                                    <li><a href="#" class="fa fa-twitter"></a></li>
                                    <li><a href="#" class="fa fa-linkedin"></a></li>
                                </ul>
                            </div> <!-- /.team-overlay -->
                        </div> <!-- /.member-thumb -->
                    </div> <!-- /.team-member -->
                    <div class="team-member col-md-3 col-sm-6">
                        <div class="member-thumb">
                            <img src="images/member2.jpg" alt="">
                            <div class="team-overlay">
                                <h3>Cindy</h3>
                                <span>Developer</span>
                                <ul class="social">
                                    <li><a href="#" class="fa fa-facebook"></a></li>
                                    <li><a href="#" class="fa fa-twitter"></a></li>
                                    <li><a href="#" class="fa fa-linkedin"></a></li>
                                </ul>
                            </div> <!-- /.team-overlay -->
                        </div> <!-- /.member-thumb -->
                    </div> <!-- /.team-member -->
                    <div class="team-member col-md-3 col-sm-6">
                        <div class="member-thumb">
                            <img src="images/member3.jpg" alt="">
                            <div class="team-overlay">
                                <h3>Mary</h3>
                                <span>Director</span>
                                <ul class="social">
                                    <li><a href="#" class="fa fa-facebook"></a></li>
                                    <li><a href="#" class="fa fa-twitter"></a></li>
                                    <li><a href="#" class="fa fa-linkedin"></a></li>
                                </ul>
                            </div> <!-- /.team-overlay -->
                        </div> <!-- /.member-thumb -->
                    </div> <!-- /.team-member -->
                    <div class="team-member col-md-3 col-sm-6">
                        <div class="member-thumb">
                            <img src="images/member4.jpg" alt="">
                            <div class="team-overlay">
                                <h3>Linda</h3>
                                <span>Chief Executive</span>
                                <ul class="social">
                                    <li><a href="#" class="fa fa-facebook"></a></li>
                                    <li><a href="#" class="fa fa-twitter"></a></li>
                                    <li><a href="#" class="fa fa-linkedin"></a></li>
                                </ul>
                            </div> <!-- /.team-overlay -->
                        </div> <!-- /.member-thumb -->
                    </div> <!-- /.team-member -->
                </div> <!-- /.row -->
                <div class="row">
                    <div class="col-md-12 text-center">
                        <div class="skills-heading">
                            <h3 class="skills-title">Design Skills</h3>
                            <p class="small-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                        </div>
                    </div> <!-- /.col-md-12 -->
                </div> <!-- /.row -->
                <div class="row">
                    <div class="col-md-8 col-sm-6">
                        <p>Aliquam faucibus in dolor sed vestibulum. Sed adipiscing malesuada luctus. Morbi tincidunt, tellus scelerisque scelerisque scelerisque, sapien dui pretium augue, at consectetur sapien tellus vitae nunc. Ut vitae metus quis nulla cursus adipiscing pretium vel dolor. Fusce lacinia accumsan arcu, quis porttitor nisi tincidunt ut. Nunc malesuada nunc eget nunc sollicitudin posuere. Maecenas vitae tortor quis odio hendrerit sagittis.<br><br>
						Etiam tincidunt, magna eu elementum tristique, sapien nisl venenatis lacus, nec sagittis lectus dui eget lorem. Donec in tempus mi. Aenean egestas interdum dolor, et mollis lectus consequat. Mauris ullamcorper, felis sit amet gravida malesuada, nisi sem rhoncus massa, non tempor est erat sit amet diam.<!-- spacing for mobile viewing --><br><br>
						</p>
                    </div> <!-- /.col-md-8 -->
                    <div class="col-md-4 col-sm-6">
                        <ul class="progess-bars">
                            <li>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100" style="width: 90%;">Photoshop 90%</div>
                                </div>
                            </li>
                            <li>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%;">HTML CSS 80%</div>
                                </div>
                            </li>
                            <li>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%;">Development 70%</div>
                                </div>
                            </li>
                            <li>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%;">Marketing 80%</div>
                                </div>
                            </li>
                        </ul>
                    </div> <!-- /.col-md-4 -->
                </div> <!-- /.row -->
            </div> <!-- /.container -->
        </div> <!-- /#our-team -->

        <div class="content-section" id="contact">
            <div class="container">
                <div class="row">
                    <div class="heading-section col-md-12 text-center">
                        <h2>Contact</h2>
                        <p>Send a message to us</p>
                    </div> <!-- /.heading-section -->
                </div> <!-- /.row -->
                <div class="row">
                    <div class="col-md-12">
                       <div class="googlemap-wrapper">
                            <div id="map_canvas" class="map-canvas"></div>
                        </div> <!-- /.googlemap-wrapper -->
                    </div> <!-- /.col-md-12 -->
                </div> <!-- /.row -->
                <div class="row">
                    <div class="col-md-7 col-sm-6">
                        <p>Flex is a Bootstrap v3.1.1 HTML CSS web template by <span class="blue">template</span><span class="green">mo</span>. Slider images and portfolio images are from <a rel="nofollow" href="http://unsplash.com" target="_parent">Unsplash</a> website. Thank you for visiting. Please tell your friends about templatemo.<br><br>
                        Hic, suscipit, praesentium earum quod ea distinctio impedit ullam deserunt minus dolore quibusdam quis saepe aliquam doloribus voluptatibus eum excepturi. Aenean semper erat neque. Nunc et scelerisque nunc, in adipiscing magna.<br><br>
				    Duis ullamcorper tortor tellus. Ut diam libero, ultricies non augue a, mollis congue risus. Fusce a quam eget nisi luctus imperdiet. Consectetur quod at aperiam corporis totam. Nesciunt minima laborum sapiente totam facere unde est cum quia. 
                    	</p>
                        <ul class="contact-info">
                            <li>Phone: 033-033-0660</li>
                            <li>Email: <a href="mailto:info@company.com">info@company.com</a></li>
                            <li>Address: 880 De Best Studio, Fork Street, San Francisco</li>
                        </ul>
                        <!-- spacing for mobile viewing --><br><br>
                    </div> <!-- /.col-md-7 -->
                    <div class="col-md-5 col-sm-6">
                        <div class="contact-form">
                            <form method="post" name="contactform" id="contactform">
                                <p>
                                    <input name="name" type="text" id="name" placeholder="Your Name">
                                </p>
                                <p>
                                    <input name="email" type="text" id="email" placeholder="Your Email"> 
                                </p>
                                <p>
                                    <input name="subject" type="text" id="subject" placeholder="Subject"> 
                                </p>
                                <p>
                                    <textarea name="comments" id="comments" placeholder="Message"></textarea>    
                                </p>
                                <input type="submit" class="mainBtn" id="submit" value="Send Message">
                            </form>
                        </div> <!-- /.contact-form -->
                    </div> <!-- /.col-md-5 -->
                </div> <!-- /.row -->
            </div> <!-- /.container -->
        </div> <!-- /#contact -->
            
        <div id="footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-xs-12 text-left">
                        <span>Copyright &copy; 2014 Company Name</span>
                  </div> <!-- /.text-center -->
                    <div class="col-md-4 hidden-xs text-right">
                        <a href="#top" id="go-top">Back to top</a>
                    </div> <!-- /.text-center -->
                </div> <!-- /.row -->
            </div> <!-- /.container -->
        </div> <!-- /#footer -->
        
        <script src="/resources/css/index/js/vendor/jquery-1.11.0.min.js"></script>
        <script>window.jQuery || document.write('<script src="/resources/css/index/js/vendor/jquery-1.11.0.min.js"><\/script>')</script>
        <script src="/resources/css/index/js/bootstrap.js"></script>
        <script src="/resources/css/index/js/plugins.js"></script>
        <script src="/resources/css/index/js/main.js"></script>

        <!-- Google Map -->
        <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
        <script src="/resources/css/index/js/vendor/jquery.gmap3.min.js"></script>
        
        <!-- Google Map Init-->
        <script type="text/javascript">
            jQuery(function($){
                $('#map_canvas').gmap3({
                    marker:{
                        address: '37.769725, -122.462154' 
                    },
                        map:{
                        options:{
                        zoom: 15,
                        scrollwheel: false,
                        streetViewControl : true
                        }
                    }
                });

                /* Simulate hover on iPad
                 * http://stackoverflow.com/questions/2851663/how-do-i-simulate-a-hover-with-a-touch-in-touch-enabled-browsers
                 --------------------------------------------------------------------------------------------------------------*/ 
                $('body').bind('touchstart', function() {});
            });
        </script>
        <!-- templatemo 406 flex -->
	
</body>

</html>