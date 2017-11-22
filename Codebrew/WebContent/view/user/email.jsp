<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> --%>
	


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>Demystifying Email Design</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>








<!--   <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">  
	 

 ///////////////////////// Bootstrap, jQuery CDN //////////////////////////
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
       -->
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	  
<title>마이페이지</title>
</head>
<style>
body {
    padding: 0;
    margin: 0;
}

html { -webkit-text-size-adjust:none; -ms-text-size-adjust: none;}
@media only screen and (max-device-width: 680px), only screen and (max-width: 680px) { 
    *[class="table_width_100"] {
		width: 96% !important;
	}
	*[class="border-right_mob"] {
		border-right: 1px solid #dddddd;
	}
	*[class="mob_100"] {
		width: 100% !important;
	}
	*[class="mob_center"] {
		text-align: center !important;
	}
	*[class="mob_center_bl"] {
		float: none !important;
		display: block !important;
		margin: 0px auto;
	}	
	.iage_footer a {
		text-decoration: none;
		color: #929ca8;
	}
	img.mob_display_none {
		width: 0px !important;
		height: 0px !important;
		display: none !important;
	}
	img.mob_width_50 {
		width: 40% !important;
		height: auto !important;
	}
}
.table_width_100 {
	width: 680px;
}
</style>
<body>
<!--
Responsive Email Template by @keenthemes
A component of Metronic Theme - #1 Selling Bootstrap 3 Admin Theme in Themeforest: http://j.mp/metronictheme
Licensed under MIT
-->

<div id="mailsub" class="notification" align="center">

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="min-width: 320px;"><tr><td align="center" bgcolor="#eff3f8">


<!--[if gte mso 10]>
<table width="680" border="0" cellspacing="0" cellpadding="0">
<tr><td>
<![endif]-->

<table border="0" cellspacing="0" cellpadding="0" class="table_width_100" width="100%" style="max-width: 680px; min-width: 300px;">
    <tr><td>
	<!-- padding --><div style="height: 80px; line-height: 80px; font-size: 10px;"> </div>
	</td></tr>
	<!--header -->
	<tr><td align="center" bgcolor="#ffffff">
		<!-- padding --><div style="height: 30px; line-height: 30px; font-size: 10px;"> </div>
		<table width="90%" border="0" cellspacing="0" cellpadding="0">
			<tr><td align="left"><!-- 

				Item --><div class="mob_center_bl" style="float: left; display: inline-block; width: 115px;">
					<table class="mob_center" width="115" border="0" cellspacing="0" cellpadding="0" align="left" style="border-collapse: collapse;">
						<tr><td align="left" valign="middle">
							<!-- padding --><div style="height: 20px; line-height: 20px; font-size: 10px;"> </div>
							<table width="115" border="0" cellspacing="0" cellpadding="0" >
								<tr><td align="left" valign="top" class="mob_center">
									<a href="#" target="_blank" style="color: #596167; font-family: Arial, Helvetica, sans-serif; font-size: 13px;">
									<font face="Arial, Helvetica, sans-seri; font-size: 13px;" size="3" color="#596167">
									<img src="http://artloglab.com/metromail/images/logo.gif" width="115" height="19" alt="Metronic" border="0" style="display: block;" /></font></a>
								</td></tr>
							</table>						
						</td></tr>
					</table></div><!-- Item END--><!--[if gte mso 10]>
			
			</tr>
		</table>
		<!-- padding --><div style="height: 50px; line-height: 50px; font-size: 10px;"> </div>
	</td></tr>
	<!--header END-->

	<!--content 1 -->
	<tr><td align="center" bgcolor="#fbfcfd">
		<table width="90%" border="0" cellspacing="0" cellpadding="0">
			<tr><td align="center">
				<!-- padding --><div style="height: 60px; line-height: 60px; font-size: 10px;"> </div>
				<div style="line-height: 44px;">
					<font face="Arial, Helvetica, sans-serif" size="5" color="#57697e" style="font-size: 34px;">
					<span style="font-family: Arial, Helvetica, sans-serif; font-size: 34px; color: #57697e;">
						Awesome User Expierence
					</span></font>
				</div>
				<!-- padding --><div style="height: 40px; line-height: 40px; font-size: 10px;"> </div>
			</td></tr>
			<tr><td align="center">
				<div style="line-height: 24px;">
					<font face="Arial, Helvetica, sans-serif" size="4" color="#57697e" style="font-size: 15px;">
					<span style="font-family: Arial, Helvetica, sans-serif; font-size: 15px; color: #57697e;">
						Lorem ipsum dolor sit amet consectetuer sed<br> diam nonumy nibh elit dolore.
					</span></font>
				</div>
				<!-- padding --><div style="height: 40px; line-height: 40px; font-size: 10px;"> </div>
			</td></tr>
			<tr><td align="center">
				<div style="line-height: 24px;">
					<a href="#" target="_blank" style="color: #596167; font-family: Arial, Helvetica, sans-serif; font-size: 13px;">
						<font face="Arial, Helvetica, sans-seri; font-size: 13px;" size="3" color="#596167">
							<img src="http://artloglab.com/metromail/images/trial.gif" width="193" height="43" alt="30-DAYS FREE TRIAL" border="0" style="display: block;" /></font></a>
				</div>
				<!-- padding --><div style="height: 60px; line-height: 60px; font-size: 10px;"> </div>
			</td></tr>
		</table>		
	</td></tr>
	<!--content 1 END-->

	<!--content 2 -->
	<tr><td align="center" bgcolor="#ffffff" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #eff2f4;">
		<table width="94%" border="0" cellspacing="0" cellpadding="0">
			<tr><td align="center">
				<!-- padding --><div style="height: 40px; line-height: 40px; font-size: 10px;"> </div>

				<div class="mob_100" style="float: left; display: inline-block; width: 33%;">
					<table class="mob_100" width="100%" border="0" cellspacing="0" cellpadding="0" align="left" style="border-collapse: collapse;">
						<tr><td align="center" style="line-height: 14px; padding: 0 27px;">
							<!-- padding --><div style="height: 40px; line-height: 40px; font-size: 10px;"> </div>
							<div style="line-height: 14px;">
								<font face="Arial, Helvetica, sans-serif" size="3" color="#4db3a4" style="font-size: 14px;">
								<strong style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: #4db3a4;">
									<a href="#1" target="_blank" style="color: #4db3a4; text-decoration: none;">UNLIMITED LAYOUTS</a>
								</strong></font>
							</div>
							<!-- padding --><div style="height: 18px; line-height: 18px; font-size: 10px;"> </div>
							<div style="line-height: 21px;">
								<font face="Arial, Helvetica, sans-serif" size="3" color="#98a7b9" style="font-size: 14px;">
								<span style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: #98a7b9;">
									Lorem ipsum dolor sit amet consectetuer sed et diam noumy elit dolore 
								</span></font>
							</div>
						</td></tr>
					</table>
				</div>
				<div class="mob_100" style="float: left; display: inline-block; width: 33%;">
					<table class="mob_100" width="100%" border="0" cellspacing="0" cellpadding="0" align="left" style="border-collapse: collapse;">
						<tr><td align="center" style="line-height: 14px; padding: 0 27px;">
							<!-- padding --><div style="height: 40px; line-height: 40px; font-size: 10px;"> </div>
							<div style="line-height: 14px;">
								<font face="Arial, Helvetica, sans-serif" size="3" color="#4db3a4" style="font-size: 14px;">
								<strong style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: #4db3a4;">
									<a href="#2" target="_blank" style="color: #4db3a4; text-decoration: none;">GREAT SUPPORT</a>
								</strong></font>
							</div>
							<!-- padding --><div style="height: 18px; line-height: 18px; font-size: 10px;"> </div>
							<div style="line-height: 21px;">
								<font face="Arial, Helvetica, sans-serif" size="3" color="#98a7b9" style="font-size: 14px;">
								<span style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: #98a7b9;">
									Lorem ipsum dolor sit amet consectetuer sed et diam noumy elit dolore 
								</span></font>
							</div>
						</td></tr>
					</table>
				</div>
				<div class="mob_100" style="float: left; display: inline-block; width: 33%;">
					<table class="mob_100" width="100%" border="0" cellspacing="0" cellpadding="0" align="left" style="border-collapse: collapse;">
						<tr><td align="center" style="line-height: 14px; padding: 0 27px;">
							<!-- padding --><div style="height: 40px; line-height: 40px; font-size: 10px;"> </div>
							<div style="line-height: 14px;">
								<font face="Arial, Helvetica, sans-serif" size="3" color="#4db3a4" style="font-size: 14px;">
								<strong style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: #4db3a4;">
									<a href="#3" target="_blank" style="color: #4db3a4; text-decoration: none;">CLEAN CODE</a>
								</strong></font>
							</div>
							<!-- padding --><div style="height: 18px; line-height: 18px; font-size: 10px;"> </div>
							<div style="line-height: 21px;">
								<font face="Arial, Helvetica, sans-serif" size="3" color="#98a7b9" style="font-size: 14px;">
								<span style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: #98a7b9;">
									Lorem ipsum dolor sit amet consectetuer sed et diam noumy elit dolore 
								</span></font>
							</div>
						</td></tr>
					</table>
				</div>								
			</td></tr>
			<tr><td><!-- padding --><div style="height: 80px; line-height: 80px; font-size: 10px;"> </div></td></tr>
		</table>		
	</td></tr>
	<!--content 2 END-->

	

	
	
	<tr><td>
	<!-- padding --><div style="height: 80px; line-height: 80px; font-size: 10px;"> </div>
	</td></tr>
</table>
<!--[if gte mso 10]>
</td></tr>
</table>
<![endif]-->
 
</td></tr>
</table>
			
</div> 

<br>
<br>
<center>
<strong>Powered by <a href="http://j.mp/metronictheme" target="_blank">MOANA</a></strong>
</center>
<br>
<br>
</body>
</html>