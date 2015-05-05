<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {
		$("#inputForm").validate();
		$("#inputForm input").attr("disabled","");
		
		$("#edit").on("click",function(){
		
		$("#inputForm input").removeAttr("disabled","");
		
		});
		
	});
</script>
<style type="text/css">
.row {
	margin-top: 10px;
}
</style>
</head>
<body>

	<div class="container" style="margin-top: 10px">
		<ul class="nav nav-tabs">
			<li class="active"><a href="javascript:void(0);">+ 新增公司财务信息</a></li>
			<button id="edit"  class="btn pull-right" >编辑</button>
		</ul>
		<div class="text-info" style="margin-top: 10px; font-size: 20px">财务信息：</div>
		<hr style="margin-top: 0px;" />
		<div>
			<form:form id="inputForm" method="post" modelAttribute="companyFinanceInfo"  role="form" class="form-horizontal" action="${ctx }/sys/companyfinance/add">

               <form:hidden path="id"/>
				<div class="row">


					<div class="form-group col-sm-6">
						<label for="rmbAccount" class="control-lable col-sm-3">人民币账户：</label>
						<div class="col-sm-7">
							<form:input path="rmbAccount" class="form-control required" placeholder="输入文本..." id="rmbAccount"
								type="text"/>
						</div>
					</div>


					<div class="form-group col-sm-6">

						<label for="rmbDepositBank" class="control-lable col-sm-3">人民币开户行：</label>
						<div class="col-sm-7">
							<form:input path="rmbDepositBank" class="form-control required" placeholder="输入文本..."
								id="rmbDepositBank" type="text"/>
						</div>

					</div>
				</div>


				<div class="row">

					<div class="form-group col-sm-6">

						<label for="usdAccount" class="control-lable col-sm-3">美金账户：</label>
						<div class="col-sm-7">
							<form:input path="usdAccount" class="form-control required" placeholder="输入文本..." id="usdAccount"
								type="text"/>
						</div>

					</div>
					<div class="form-group col-sm-6">

						<label for="usdDepositBank" class="control-lable col-sm-3">美金开户行：：</label>
						<div class="col-sm-7">
							<form:input path="usdDepositBank" class="form-control required" placeholder="输入文本..."
								id="usdDepositBank" type="text"/>
						</div>

					</div>
				</div>
				<div class="row">

					<div class="form-group col-sm-6">

						<label for="taxNum" class="control-lable col-sm-3">税号：</label>
						<div class="col-sm-7">
							<form:input path="taxNum" class="form-control required" placeholder="输入文本..." id="taxNum"
								type="text"/>
						</div>

					</div>

				</div>
				<div class="row">

					<div class="form-group col-sm-6">

						<label for="organizationCode" class="control-lable col-sm-3">组织机构代码证</label>
						<div class="col-sm-7">
							<form:input path="organizationCode" class="form-control required" placeholder="输入文本..."
								id="organizationCode" type="text"/>
						</div>

					</div>

				</div>
				<div class="row">

					<div class="form-group col-sm-6">

						<label for="usdAccount" class="control-lable col-sm-3">财务联系人：</label>
						<div class="col-sm-7">
                    <form:select path="finaceContacter" class="form-control input-sm required">
						<form:options items="${userList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
					</form:select>
							<%-- <select class="form-control">
								<c:forEach  items="${ userList}" var="user">
									<option value="${name.id }"  >${user.name}</option>
								</c:forEach>
							</select> --%>
						</div>

					</div>

				</div>

				<div class="text-info" style="margin-top: 10px; font-size: 20px">财务信息：</div>
				<hr style="margin-top: 0px;" />
				<div class="row">


					<div class="form-group col-sm-6">
						<label for="rmbAccount" class="control-lable col-sm-3">人民币账户：</label>
						<div class="col-sm-7">
							<input class="form-control " placeholder="输入文本..." id="rmbAccount"
								type="text">
						</div>
					</div>


				</div>
				<div class="row" style="margin-top: 0px">
					<div class="form-group col-sm-3">
						<div class="col-sm-6 checkbox checkbox-inline">
							<input id="type0" type="checkbox"> <label for="type0">
								DJF|吊机费</label>
						</div>
					</div>
					<div class="form-group col-sm-3">
						<div class="col-sm-6 checkbox checkbox-inline">
							<input id="type1" type="checkbox"> <label for="type1">
								QXF|清洗费</label>
						</div>
					</div>
				</div>

				<div class="row" style="margin-top: 0px">
					<div class="form-group col-sm-3">
						<div class="col-sm-6 checkbox checkbox-inline">
							<input id="type2" type="checkbox"> <label for="type2">
								PJF|配件费</label>
						</div>
					</div>
					<div class="form-group col-sm-3">
						<div class="col-sm-6 checkbox checkbox-inline">
							<input id="type3" type="checkbox"> <label for="type3">
								XLF|修理费</label>
						</div>
					</div>
				</div>

				<div class="row" style="margin-top: 0px">
					<div class="form-group col-sm-3">
						<div class="col-sm-6 checkbox checkbox-inline">
							<input id="type4" type="checkbox"> <label for="type4">
								GJF|改装费</label>
						</div>
					</div>
					<div class="form-group col-sm-3">
						<div class="col-sm-6 checkbox checkbox-inline">
							<input id="type5" type="checkbox"> <label for="type5">
								CDF|充氮费</label>
						</div>
					</div>
				</div>


				<div class="row" style="margin-top: 0px">
					<div class="pull-right">
						<button type="submit" class="btn">确定</button>
					</div>
				</div>


			</form:form>
		</div>





		<%@include file="/WEB-INF/views/include/footer.jsp"%>

	</div>
</body>
</html>