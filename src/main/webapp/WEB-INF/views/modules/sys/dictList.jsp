<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
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
			<li class="active"><a href="${ctx}/sys/dict/">字典列表</a></li>
			<shiro:hasPermission name="sys:dict:edit"><li><a href="${ctx}/sys/dict/form?sort=10">字典添加</a></li></shiro:hasPermission>
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
		
		<form:form id="searchForm" modelAttribute="dict" action="${ctx}/sys/dict/" method="post" class="breadcrumb form-inline" cssStyle="margin-bottom:10px;">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<div class="form-group">
				<label class="control-label" for="type">类型：</label>
				<form:select id="type" path="type" class="form-control input-sm"><form:option value="" label="所有类型"/><form:options items="${typeList}" htmlEscape="false"/></form:select>
			</div>
			<div class="form-group">
				<label class="control-label" for="description">描述：</label>
				<form:input id="description" path="description" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
			</div>
			<div class="form-group">
				<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="查询"/>
			</div>
		</form:form>
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead><tr><th>键值</th><th>标签</th><th>类型</th><th>描述</th><th>排序</th><shiro:hasPermission name="sys:dict:edit"><th>操作</th></shiro:hasPermission></tr></thead>
			<tbody>
			<c:forEach items="${page.list}" var="dict">
				<tr>
					<td>${dict.value}</td>
					<td><a href="${ctx}/sys/dict/form?id=${dict.id}">${dict.label}</a></td>
					<td><a href="javascript:" onclick="$('#type').val('${dict.type}');$('#searchForm').submit();return false;">${dict.type}</a></td>
					<td>${dict.description}</td>
					<td>${dict.sort}</td>
					<shiro:hasPermission name="sys:dict:edit"><td>
	    				<a href="${ctx}/sys/dict/form?id=${dict.id}">修改</a>
						<a rel="${ctx}/sys/dict/delete?id=${dict.id}" class="btn-delete" href="#confirmModal" dialog-content="确认要删除该字典吗？" data-toggle="modal" role="button">删除</a>
	    				<a href="<c:url value='${fns:getAdminPath()}/sys/dict/form?type=${dict.type}&sort=${dict.sort+10}'><c:param name='description' value='${dict.description}'/></c:url>">添加键值</a>
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