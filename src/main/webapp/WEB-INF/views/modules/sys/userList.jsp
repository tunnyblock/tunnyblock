<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">.sort{color:#0663A2;cursor:pointer;}</style>
	<script type="text/javascript">
		$(document).ready(function() {
			// 表格排序
			tableSort({callBack : page});
			
			//导出功能
			$("#btnExport").click(function(){
				BootstrapDialog.show({
		            title: '确认要导出用户数据吗？',
		            buttons: [{
		                label: '确定',
		                cssClass: 'btn-primary',
		                action: function(dialog) {
		                    $("#searchForm").attr("action","${ctx}/sys/user/export").submit();
		                    dialog.close();
		                }
		            }, {
		                label: '取消',
		                action: function(dialog) {
		                    dialog.close();
		                }
		            }]
		        });
			});
		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/sys/user/").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<!-- Tab页 -->
		<ul class="nav nav-tabs">
			<li class="active"><a href="${ctx}/sys/user/">用户列表</a></li>
			<shiro:hasPermission name="sys:user:edit"><li><a href="${ctx}/sys/user/form">用户添加</a></li></shiro:hasPermission>
		</ul>
		
		<div style="margin-top: 10px;"></div>
	
		<!-- 系统提示 -->
		<c:if test="${not empty message}">
			<c:if test="${not empty type}"><c:set var="ctype" value="${type}"/></c:if><c:if test="${empty type}"><c:set var="ctype" value="${fn:indexOf(content,'失败') eq -1?'success':'danger'}"/></c:if>
			<div id="messageBox" class="alert alert-${ctype}">
				<button data-dismiss="alert" class="close">×</button>
				${message}
			</div>
			<script type="text/javascript">
				$(document).ready(function(){
					setInterval('$("#messageBox").remove()',3000);
				});
			</script>
		</c:if>
		
		<!-- 查询框 -->
		<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/" method="post" class="breadcrumb form-inline" cssStyle="margin-bottom:10px;">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}"/>
			<div class="form-group">
				<form:input type="text" class="form-control input-sm" maxlength="50" id="loginName" path="loginName" placeholder="登录名"/>
			</div>
			<div class="form-group">
				<form:input type="text" class="form-control input-sm" maxlength="50" id="name" path="name" placeholder="姓名"/>
			</div>
			<div class="form-group">
				<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="查询" onclick="return page();"/>
				<input id="btnExport" class="btn btn-primary btn-sm" type="button" value="导出"/>
			</div>
		</form:form>

		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>归属公司</th>
					<th>归属部门</th>
					<th class="sort loginName">登录名</th>
					<th class="sort name">姓名</th>
					<th>电话</th>
					<th>手机</th>
					<th>角色</th>
					<shiro:hasPermission name="sys:user:edit"><th>操作</th></shiro:hasPermission>
				</tr>
				</thead>
			<tbody>
			<c:forEach items="${page.list}" var="user">
				<tr>
					<td>${user.company.name}</td>
					<td>${user.office.name}</td>
					<td><a href="${ctx}/sys/user/form?id=${user.id}">${user.loginName}</a></td>
					<td>${user.name}</td>
					<td>${user.phone}</td>
					<td>${user.mobile}</td>
					<td>${user.roleNames}</td>
					<shiro:hasPermission name="sys:user:edit"><td>
	    				<a href="${ctx}/sys/user/form?id=${user.id}">修改</a>
						<a rel="${ctx}/sys/user/delete?id=${user.id}" class="btn-delete" href="#confirmModal" dialog-content="确认要删除该用户吗？" data-toggle="modal" role="button">删除</a>
					</td></shiro:hasPermission>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	
		<!-- 分页 -->
	  	${page}
	  
		<!-- Delete Confirm -->
		<div class="modal" id="confirmModal" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
		    <div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4><span class="fa fa-exclamation-triangle fa-2" style="color:red;"></span> 系统提示</h4>
					</div>
					<div class="modal-body">
						<p id='dialog-content'>确定要进行该操作吗?</p>
					</div>
					<div class="modal-footer">
						<a href="#" class="btn btn-primary btn-confirm btn-sm" >确定</a>
						<a href="#" class="btn btn-default btn-sm" data-dismiss="modal">取消</a>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$(function(){
				$('.btn-delete').click(function(){
					if($(this).attr('dialog-content')){
						$("#dialog-content").html($(this).attr('dialog-content'));
					}
					$('#confirmModal .btn-confirm').attr('href', $(this).attr('rel') );
				});
			});
		</script>
	</div>
</body>
</html>