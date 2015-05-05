<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">.table td i{margin:0 2px;}</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#treeTable').treegrid({
				expanderExpandedClass: 'fa fa-angle-down',
                expanderCollapsedClass: 'fa fa-angle-right'
			});
		});
    	function updateSort() {
			loading('正在提交，请稍等...');
	    	$("#listForm").attr("action", "${ctx}/sys/menu/updateSort");
	    	$("#listForm").submit();
    	}
	</script>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<ul class="nav nav-tabs">
			<li class="active"><a href="${ctx}/sys/menu/">菜单列表</a></li>
			<shiro:hasPermission name="sys:menu:edit"><li><a href="${ctx}/sys/menu/form">菜单添加</a></li></shiro:hasPermission>
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
		<form id="listForm" method="post">
			<table id="treeTable" class="table table-striped table-bordered table-condensed">
				<tr><th>名称</th><th>链接</th><th style="text-align:center;">排序</th><th>可见</th><th>权限标识</th><shiro:hasPermission name="sys:menu:edit"><th>操作</th></shiro:hasPermission></tr>
				<c:forEach items="${list}" var="menu">
					<tr id="${menu.id}" class="treegrid-${menu.id} <c:if test="${menu.parent.id ne '1' }">treegrid-parent-${menu.parent.id}</c:if>">
						<td><i class="icon-${not empty menu.icon?menu.icon:' hide'}"></i><a href="${ctx}/sys/menu/form?id=${menu.id}">${menu.name}</a></td>
						<td>${menu.href}</td>
						<td style="text-align:center;">
							<shiro:hasPermission name="sys:menu:edit">
								<input type="hidden" name="ids" value="${menu.id}"/>
								<input name="sorts" type="text" value="${menu.sort}" style="width:50px;margin:0;padding:0;text-align:center;">
							</shiro:hasPermission><shiro:lacksPermission name="sys:menu:edit">
								${menu.sort}
							</shiro:lacksPermission>
						</td>
						<td>${menu.isShow eq '1'?'显示':'隐藏'}</td>
						<td>${menu.permission}</td>
						<shiro:hasPermission name="sys:menu:edit"><td>
							<a href="${ctx}/sys/menu/form?id=${menu.id}">修改</a>
							<a rel="${ctx}/sys/menu/delete?id=${menu.id}"  class="btn-delete" href="#confirmModal" dialog-content="要删除该菜单及所有子菜单项吗？" data-toggle="modal" role="button">删除</a>
							<a href="${ctx}/sys/menu/form?parent.id=${menu.id}">添加下级菜单</a> 
						</td></shiro:hasPermission>
					</tr>
				</c:forEach>
			</table>
			<shiro:hasPermission name="sys:menu:edit">
				<div class="form-actions pagination-left">
					<input id="btnSubmit" class="btn btn-primary btn-sm" type="button" value="保存排序" onclick="updateSort();"/>
				</div>
			</shiro:hasPermission>
		 </form>
		 
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
