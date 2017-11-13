<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript">
jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
    return this;
}
showPopup = function() {
$("#popLayer").show();
$("#popLayer").center();
}
</script>
<style>
.layer {
    position: fixed;
    width: 40%;
    left: 50%;
    margin-left: -20%; /* half of width */
    height: 300px;
    top: 50%;
    margin-top: -150px; /* half of height */
    overflow: auto;

    /* decoration */
    border: 1px solid #000;
    background-color: #eee;
    padding: 1em;
    box-sizing: border-box;
}
.hidden {
    display: none;
}
@media (max-width: 600px) {
    .layer {
        width: 80%;
        margin-left: -40%;
    }
}
</style>
</head>
<body>
<a href="javascript:;" onclick="javascript:showPopup()">팝업띄우기</a>
<div id="popLayer" class="js-layer  layer  hidden" style="display:none;">
<div id="kakaoUrl"></div>
</div>
</body>
