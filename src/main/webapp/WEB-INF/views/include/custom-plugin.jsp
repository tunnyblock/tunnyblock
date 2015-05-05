<%@ page contentType="text/html;charset=UTF-8" %>
<div class="ibox float-e-margins">
<div class="ibox-content">
	<center>
		<h4>你好，${fns:getUser().name}</h4>
		<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
		<span class="">今天是<fmt:formatDate value="${now}" pattern="EEEE"/>，<fmt:formatDate value="${now}" pattern="yyyy年MM月dd日"/></span>
	</center>
	<hr class="hr-divider"/>
	<div class="row">
		<div class="col-lg-3" style="border-right: 1px solid #e1e1e1;">
			<center>
				<a href="${ctx}/process/workbench/customService">
					<span class="badge badge-warning">42</span><br/>
					<span>我的工作台</span>
				</a>
			</center>
		</div>
		<div class="col-lg-3" style="border-right: 1px solid #e1e1e1;">
			<center>
				<a href="${ctx}/process/assignment">
					<span class="badge badge-warning">42</span><br/>
					<span style="padding: 10px 0;">待分配流程</span>
				</a>
			</center>
		</div>
		<div class="col-lg-3" style="border-right: 1px solid #e1e1e1;">
			<center>
				<a href="${ctx}/process/workbench/customService/charge">
					<span class="badge badge-warning">42</span><br/>
					<span style="padding: 10px 0;">待确认账单</span>
				</a>
			</center>
		</div>
		<div class="col-lg-3">
			<center>
				<a href="#">
					<span class="badge badge-success">42</span><br/>
					<span style="padding: 10px 0;">已完成流程</span>
					</a>
				</center>
			</div>
		</div>
	</div>
</div>