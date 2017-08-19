<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): wang
  - Date: 2015-11-20 15:29:25
  - Description:
-->
<head>

<base target="_self">

<title>agency</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<a id="show" href="http://www.baidu.com" target="_self">百度</a>
	<a id="show2" href="http://www.baidu.com" target="_self">百度</a>
</body>

<script type="text/javascript">
    	nui.parse();
    	
    	$(function(){
    		debugger;
    		document.getElementById('show').click();
    		//document.getElementById('show').click();
    	});
</script>

</html>