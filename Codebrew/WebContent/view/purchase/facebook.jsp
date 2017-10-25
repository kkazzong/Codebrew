<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Your Website Title</title>
    <!-- You can use Open Graph tags to customize link previews.
    Learn more: https://developers.facebook.com/docs/sharing/webmasters -->
  <meta property="og:url"           content="http://www.your-domain.com/your-page.html" />
  <meta property="og:type"          content="website" />
  <meta property="og:title"         content="Your Website Title" />
  <meta property="og:description"   content="Your description" />
  <meta property="og:image"         content="http://www.your-domain.com/path/image.jpg" />
  <script src="http://connect.facebook.net/ko_KR/all.js"></script>
  <script>
document.getElementById('shareBtn').onclick = function() {
  FB.ui({
    method: 'share',
    display: 'popup',
    href: 'https://developers.facebook.com/docs/',
  }, function(response){});
}
</script>
</head>
<body>

 <div class="page-header">
  <h1>Share Dialog</h1>
</div>

<p>Click the button below to trigger a Share Dialog</p>

<div id="shareBtn" class="btn btn-success clearfix">Share</div>

<p style="margin-top: 50px">
  <hr />
  <a class="btn btn-small"  href="https://developers.facebook.com/docs/sharing/reference/share-dialog">Share Dialog Documentation</a>
</p>



</body>
</html>