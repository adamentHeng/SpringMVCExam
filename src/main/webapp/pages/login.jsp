<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>演示系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/login.css" rel="stylesheet">

</head>
<body>
	<div class="navbar navbar-fixed-top" role="navigation">
        <div class="navbar-header">
         <h3><span class="glyphicon glyphicon-cloud">10992马衡</span></h3> 
        </div>
    </div>
	<div class="box">
		<h3>销售管理系统</h3>
		<hr>
		
		<form action="<%=path%>/customer/login" class="form-horizontal" method="post">
			<div class="form-group">
				<label class="col-sm-3 control-label">账号：</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="username" autocomplete="off">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">密码：</label>
				<div class="col-sm-9">
					<input type="password" class="form-control" name="password" autocomplete="off">
				</div>
			</div>			
			<button type="submit" class="btn btn-info btn-block">登 陆</button>
		</form>
	
	</div>
	
	<script src="js/jquery.min.js"></script>
</body>
</html>