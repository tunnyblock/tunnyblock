]<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>角色管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<ul class="nav nav-tabs">
			<li class="active"><a href="${ctx}/sys/role/">角色列表</a></li>
			<shiro:hasPermission name="sys:role:edit"><li><a href="${ctx}/sys/role/form">角色添加</a></li></shiro:hasPermission>
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
		
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<tr><th>角色名称</th><th>归属机构</th><th>数据范围</th><shiro:hasPermission name="sys:role:edit"><th>操作</th></shiro:hasPermission></tr>
			<c:forEach items="${list}" var="role">
				<tr>
					<td><a href="form?id=${role.id}">${role.name}</a></td>
					<td>${role.office.name}</td>
					<td>${fns:getDictLabel(role.dataScope, 'sys_data_scope', '无')}</td>
					<shiro:hasPermission name="sys:role:edit"><td>
						<%-- <a href="${ctx}/sys/role/assign?id=${role.id}">分配</a> --%>
						<a href="${ctx}/sys/role/form?id=${role.id}">修改</a>
						<a rel="${ctx}/sys/role/delete?id=${role.id}" class="btn-delete" href="#confirmModal" dialog-content="确认要删除该角色吗？" data-toggle="modal" role="button">删除</a>
					</td></shiro:hasPermission>	
				</tr>
			</c:forEach>
		</table>
		
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
	
	  <footer>
        <p>&copy; 罐联科技</p>
      </footer>
	</div>
</body>
</html>