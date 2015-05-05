<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
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
       		<li  class="active"><a href="${ctx }/sys/wash/list">产品列表</a></li>
			<li><a href="${ctx }/sys/wash/addUI">产品添加</a></li>
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
		
       <form:form  modelAttribute="washInfo" id="searchForm" action="${ctx}/sys/wash/" class="breadcrumb form-inline" >
      		 <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<div class="form-group">
				<form:input placeholder="请输入产品名称" id="goodsChineseName" path="goodsChineseName" htmlEscape="false" maxlength="50" class="form-control input-sm"/> 
			</div>
			<div class="form-group">
				<button  class="btn" >确认</button>
			</div>
        </form:form>
		<table id="contentTable" class="table table-striped table-condensed">
			<thead>
				<tr>
					<th>货物名称</th>
					<th>产品类别</th>
					<th>参考清洗费率</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach  items="${page.list}" var="wash">
				<tr>
					<td>${wash.goodsChineseName}</td>
					<td>
						<c:forEach var="item" items="${fns:getDictList('sys_wash')}">
							<c:if test="${wash.type == item.value}">
								${item.label }
							</c:if>
						</c:forEach>
					</td>
					<td>${wash.referenceCleanPrice}</td>
					<td>
	    				<a   href="${ctx}/sys/wash/editUI?id=${wash.id}"><i class="fa  fa-edit" ></i></a>
						<a rel="${ctx}/sys/wash/delete?id=${wash.id}" class="btn-delete" href="#confirmModal" dialog-content="确认要删除该清洗产品吗？" data-toggle="modal" role="button"><i class="fa  fa-times" ></i></a>
					</td>
				</tr>
	        </c:forEach>
			</tbody>
		</table>
		${page }
		<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
	
	
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
</body>
</html>