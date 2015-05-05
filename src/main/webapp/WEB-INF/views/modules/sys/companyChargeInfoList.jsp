<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>公司收费管理</title>
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
			<li class="active"><a href="${ctx}/sys/companyChargeInfo/">公司收费列表</a></li>
			<shiro:hasPermission name="sys:companyChargeInfo:edit"><li><a href="${ctx}/sys/companyChargeInfo/form">公司收费添加</a></li></shiro:hasPermission>
		</ul>
		
		<div style="margin-top: 10px;"></div>
		
		<!--查询框-->
		<form:form id="searchForm" modelAttribute="companyChargeInfo" action="${ctx}/sys/companyChargeInfo/" method="post" class="breadcrumb form-inline" cssStyle="margin-bottom:10px;">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<div class="form-group">
				<form:input type="text" class="form-control input-sm" maxlength="50" id="chargeName" path="chargeName" placeholder="名称"/>
			</div>
			
			<div class="form-group">
				<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="查询" onclick="return page();"/>
				<input id="btnExport" class="btn btn-primary btn-sm" type="button" value="导出"/>
			</div>
		</form:form>
		
		<!--表单-->
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
			<th>公司</th>
			<th>收费名称</th>
			<th>收费名称缩写</th> 
			<th>任务</th>
			<th>单价</th>
			<th>计价单位</th>
			<th>描述信息</th>
			
			
			<shiro:hasPermission name="sys:companyChargeInfo:edit"><th>操作</th></shiro:hasPermission></tr></thead>
			<tbody>
			<c:forEach items="${page.list}" var="companyChargeInfo">
				<tr>
					<td>${companyChargeInfo.company.name}</td>
					<td><a href="${ctx}/sys/companyChargeInfo/form?id=${companyChargeInfo.id}">${companyChargeInfo.chargeName}</a></td>
					<td>${companyChargeInfo.chargeShortName}</td>
					<td>
					
					
					<c:forEach items="${companyChargeInfo.taskList}" var="task" >
					${task.taskName }
					</c:forEach>
					</td>
					<td>${companyChargeInfo.unitPrice}</td>
					<td>${companyChargeInfo.chargeUnit}</td>
					<td>${companyChargeInfo.description}</td>
					<shiro:hasPermission name="sys:companyChargeInfo:edit"><td>
	    				<a href="${ctx}/sys/companyChargeInfo/form?id=${companyChargeInfo.id}">修改</a>
						<a rel="${ctx}/sys/companyChargeInfo/delete?id=${companyChargeInfo.id}" class="btn-delete" href="#confirmModal" dialog-content="确认要删除该公司收费吗？" data-toggle="modal" role="button">删除</a>
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
