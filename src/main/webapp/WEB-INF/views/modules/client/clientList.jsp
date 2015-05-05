<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户公司管理</title>
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
		<ul class="nav nav-tabs">
			<li class="active"><a href="${ctx}/client/client/">客户公司列表</a></li>
			<shiro:hasPermission name="client:client:edit">
				<li><a href="${ctx}/client/client/form">客户公司添加</a></li>
			</shiro:hasPermission>
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
		
		<form:form id="searchForm" modelAttribute="client" action="${ctx}/client/client/" method="post" class="breadcrumb form-inline" cssStyle="margin-bottom:10px;">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<div class="form-group">
				<form:input path="companyShortName" htmlEscape="false" maxlength="50" class="form-control input-sm" placeholder="客户公司名"/>
			</div>
			<div class="form-group">
				<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="查询" onclick="return page();"/>
			</div>
		</form:form>
		<table id="contentTable" class="table table-striped table-condensed">
			<thead>
			<tr>
				<th>客户公司中文名</th>
				<th>客户公司英文名</th>
				<th>客户公司名缩写</th>
				<th>客户公司电话</th>
				<th>客户公司传真</th>
				<shiro:hasPermission name="client:client:edit"><th>操作</th></shiro:hasPermission>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="client">
				<tr>
					<td><a href="${ctx}/client/client/form?id=${client.id}">${client.companyChineseName}</a></td>
					<td>${client.companyEnglishName}</td>
					<td>${client.companyShortName}</td>
					<td>${client.telephone}</td>
					<td>${client.fax}</td>
					<td>
						<shiro:hasPermission name="client:client:edit">
		    				<a href="${ctx}/client/client/form?id=${client.id}">修改</a>
							<a rel="${ctx}/client/client/delete?id=${client.id}" class="btn-delete" href="#confirmModal" dialog-content="确认要删除该客户管理吗？" data-toggle="modal" role="button">删除</a>
						</shiro:hasPermission>
							<a href="${ctx}/client/client/${client.id}/clientEmployeeList">员工列表</a>
							<a href="${ctx}/client/client/${client.id}/clientFinance">财务信息</a>
							<a href="#">报表设置</a>
					</td>
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
