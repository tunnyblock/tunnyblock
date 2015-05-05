<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#treeTable').treegrid({
				expanderExpandedClass: 'fa fa-angle-down',
                expanderCollapsedClass: 'fa fa-angle-right'
			});
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
		<ul class="nav nav-tabs">
			<li class="active"><a href="${ctx}/sys/office/">机构列表</a></li>
			<shiro:hasPermission name="sys:office:edit"><li><a href="${ctx}/sys/office/form">机构添加</a></li></shiro:hasPermission>
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
		
		<table id="treeTable" class="table table-striped table-bordered table-condensed">
			<tr><th>机构名称</th><th>归属区域</th><th>机构编码</th><th>机构类型</th><th>备注</th><shiro:hasPermission name="sys:office:edit"><th>操作</th></shiro:hasPermission></tr>
			<c:forEach items="${list}" var="office">
				<tr id="${office.id}" class="treegrid-${office.id} <c:if test="${office.id ne '1' }">treegrid-parent-${office.parent.id}</c:if>">
					<td><a href="${ctx}/sys/office/form?id=${office.id}">${office.name}</a></td>
					<td>${office.area.name}</td>
					<td>${office.code}</td>
					<td>${fns:getDictLabel(office.type, 'sys_office_type', '无')}</td>
					<td>${office.remarks}</td>
					<shiro:hasPermission name="sys:office:edit"><td>
						<a href="${ctx}/sys/office/form?id=${office.id}">修改</a>
						<a rel="${ctx}/sys/office/delete?id=${office.id}" class="btn-delete" href="#confirmModal" dialog-content="要删除该机构及所有子机构项吗？" data-toggle="modal" role="button">删除</a>
						<a href="${ctx}/sys/office/form?parent.id=${office.id}">添加下级机构</a> 
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
	</div>
</body>
</html>