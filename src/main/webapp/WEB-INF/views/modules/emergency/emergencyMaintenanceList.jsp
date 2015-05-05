<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>应急维修管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
		<div class="wrapper wrapper-content animated fadeInRight">
	
		<!--导航菜单-->
		<ul class="nav nav-tabs">
			<li class="active"><a href="${ctx}/emergency/emergencyMaintenance/">应急维修列表</a></li>
			<shiro:hasPermission name="emergency:emergencyMaintenance:edit"><li><a href="${ctx}/emergency/emergencyMaintenance/form">应急维修添加</a></li></shiro:hasPermission>
		</ul>
		
		<div style="margin-top: 10px;"></div>
		
		<!--查询框-->
		<form:form id="searchForm" modelAttribute="emergencyMaintenance" action="${ctx}/emergency/emergencyMaintenance/" method="post" class="breadcrumb form-inline" cssStyle="margin-bottom:10px;">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<div class="form-group">
				<form:input type="text" class="form-control input-sm" maxlength="50" id="name" path="name" placeholder="名称"/>
			</div>
			
			<div class="form-group">
				<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="查询" onclick="return page();"/>
				<input id="btnExport" class="btn btn-primary btn-sm" type="button" value="导出"/>
			</div>
		</form:form>
		
		<!--表单-->
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead><tr><th>名称</th><th>备注</th><shiro:hasPermission name="emergency:emergencyMaintenance:edit"><th>操作</th></shiro:hasPermission></tr></thead>
			<tbody>
			<c:forEach items="${page.list}" var="emergencyMaintenance">
				<tr>
					<td><a href="${ctx}/emergency/emergencyMaintenance/form?id=${emergencyMaintenance.id}">${emergencyMaintenance.name}</a></td>
					<td>${emergencyMaintenance.remarks}</td>
					<shiro:hasPermission name="emergency:emergencyMaintenance:edit"><td>
	    				<a href="${ctx}/emergency/emergencyMaintenance/form?id=${emergencyMaintenance.id}">修改</a>
						<a rel="${ctx}/emergency/emergencyMaintenance/delete?id=${emergencyMaintenance.id}" class="btn-delete" href="#confirmModal" dialog-content="确认要删除该应急维修吗？" data-toggle="modal" role="button">删除</a>
					</td></shiro:hasPermission>
				</tr>
			</c:forEach>
			</tbody>
		</table>
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
	
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>
