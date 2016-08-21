<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>

<link rel="stylesheet" type="text/css" href="../css/theme.css">
<link rel="stylesheet" type="text/css" href="../css/premium.css">

<link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap-theme.min.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="../js/jquery.min.js">
</script>

</head>

<body class="theme">


	<div class="navbar navbar-default" role="navigation">
		<div class="navbar-header">
			<a href="index.jsp"><span
				class="navbar-brand glyphicon glyphicon-cloud">销售管理系统</span></a>
		</div>

		<div class="navbar-collapse collapse" style="height: 1px;">
			<ul id="main-menu" class="nav navbar-nav navbar-right">
				<li class="dropdown hidden-xs">
				<a href="#"
					class="dropdown-toggle" data-toggle="dropdown"> <span
						class="glyphicon glyphicon-user padding-right-small"
						style="position: relative; top: 3px;"></span> ${name}<i
						class="fa fa-caret-down"></i>
				</a>
					<ul class="dropdown-menu">
						<li><a tabindex="-1" href="/customer/logout">Logout</a></li>
					</ul></li>
			</ul>

		</div>
	</div>

	<div class="sidebar-nav">
		<ul>
			<li><a href="index.jsp" 
				class="nav-header "><span>Customer设置</span> </a></li>
			<li><a href="#" 
				class="nav-header " >Flim设置 </a></li>
		</ul>
	</div>
	<div class="content">
		<div class="header">
			<h1 class="page-title">客户管理</h1>
		</div>
	<div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading">客户列表		
		<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#customerDialog" onclick="addCustomer();" style="margin-left:200px;">新建</button>
		</div>
		
		<!-- Table -->
		<table class="table">
			<thead>
							<tr>
								<th>操作</th>
								<th>firstName</th>
								<th>lastName</th>
								<th>address</th>
								<th>email</th>
								<th>customerId</th>
								<th>lastUpdate</th>
							</tr>
							</thead>		
							<tbody>
							</tbody>
							
		</table>
			<nav>
		<ul class="pagination  pagination-sm">
				
		</ul>
		</nav>
		</div>
		
	</div>
<!-- Modal -->
<div class="modal fade" id="customerDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
          <h4 class="modal-title" id="myModalLabel">客户信息</h4>
        </div>
        <form action="/customer/saveOrUpdate" method="post">
        <div class="modal-body">
 			
          <div class="form-group">
            <label for="firstName">firstName</label>
            <input type="text" name="firstName" class="form-control" id="firstName" >
          </div>
          <div class="form-group">
            <label for="lastName">lastName</label>
            <input type="text" name="lastName" class="form-control" id="lastName" >
          </div>
          <div class="form-group">
            <label for="address">address</label>
            <select name="addressId" class="form-control" id="addressId">
            	
            </select>
          </div>
          <div class="form-group">
            <label for="email">email</label>
            <input type="text" name="email" class="form-control" id="email" >
          </div>
          <div class="form-group" hidden>
            <label for="customerId">customerId</label>
            <input type="text" name="customerId" class="form-control" id="customerId" >
          </div>
          
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
          <button type="submit" id="btn_submit" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>保存</button>
        </div>
        </form>
      </div>
    </div>
  </div>

<script type="text/javascript">
	listAddress();
	
	
	function listPage(pageNum) {
		$.ajax({
		url: '/customer/listPage?page='+pageNum,
		type: 'post',
		dataType: 'json',
		success: function(data){
			$(".pagination").children().remove();
			$("tbody").children().remove();
			var pageTotal = Math.ceil(data.total/10);
			$(".pagination").append('<li class="disabled"><a href="#" aria-label="Previous"><spanaria-hidden="true">&laquo;</span></a></li>');
			for( var i = 0; i < pageTotal; i++){
				if( i + 1 == pageNum )
					$(".pagination").append('<li class="active"><a href="javascript:listPage('+(i+1)+')">'+ (i+1) + ' <span class="sr-only">(current)</span></a></li>');
				else
					$(".pagination").append('<li><a href="javascript:listPage('+(i+1)+')">'+(i+1)+'</a></li>');
			}
			$(".pagination").append('<li class="disabled"><a href="#" aria-label="Next"><spanaria-hidden="true">&raquo;</span></a></li>');
			var rows = data.rows.length;
			for (var i = 0; i < data.rows.length; i++) {
				$("tbody").append("<tr>");
				$("tbody").append('<td><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#customerDialog" style="margin:5px" onclick="editCustomer('+data.rows[i].customerId+')">编辑</button><button type="button" class="btn btn-primary btn-sm" onclick="deleteCustomer('+data.rows[i].customerId+')" style="margin:5px">删除</button></td>');
				$("tbody").append("<td>"+data.rows[i].firstName+"</td>");
				$("tbody").append("<td>"+data.rows[i].lastName+"</td>");
				$("tbody").append("<td>"+getOptionById(data.rows[i].addressId)+"</td>");
				$("tbody").append("<td>"+data.rows[i].email+"</td>");
				$("tbody").append("<td>"+data.rows[i].customerId+"</td>");
				$("tbody").append("<td>"+data.rows[i].lastUpdate+"</td>");
				$("tbody").append("</tr>");
			}		
		}
	});
	}
	
	function listAddress(){
		$.ajax({
			url: '/address/list',
			type: 'post',
			dataType: 'json',
			success: function (data) {
				for (var i = 0; i < data.length; i++) {
					$('#addressId').append('<option value='+data[i].addressId+'>'+data[i].address+'</option>');				
				}
				listPage(1);
			}
		});		
	}
	
	function addCustomer(){
		$('#firstName').val(null);
		$('#lastName').val(null);
		$('#email').val(null);
		$('#customerId').val(null);
		$('#addressId').get(0).selectedIndex=0;		
	}
	
	function editCustomer(customerId) {
		$.ajax({
			url: '/customer/get?customerId='+customerId,
			type: 'post',
			dataType: 'json',
			success:function (customer) {
				$('#firstName').val(customer.firstName);
				$('#lastName').val(customer.lastName);
				$('#addressId option[value='+customer.addressId+']').attr("selected",true);
				$('#email').val(customer.email);
				$('#customerId').val(customer.customerId);
			}
		});
	}

	function deleteCustomer(customerId) {
		if( confirm("确定删除吗?") ){
			$.ajax({
				url: '/customer/delete?customerId='+customerId,
				type: 'post',
				dataType: 'json',
				success:function (data) {
					if( data.msg ){
						listPage(1);
					}
					else
						alert("无法删除");
				}	
			});	
		}	
	}
	function getOptionById(addressId) {
		return $('#addressId option[value='+addressId+']').text();
	}
</script>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</body>
</html>
