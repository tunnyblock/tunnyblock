<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>服务详情</title>
<meta name="decorator" content="default" />
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<div style="margin-top: 10px;"></div>
		<div class="row">
			<div class="col-lg-6">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>服务日志</h5>
					</div>
					<div class="ibox-content inspinia-timeline">
						<c:forEach items="${processList}" var="process" varStatus="varStatus">
							<div class="timeline-item">
								<div class="row">
									<div class="col-xs-3 date">
										<i class="fa fa-briefcase"></i> <fmt:formatDate value="${process.endTime}" pattern="yyyy/MM/dd" />
									</div>
									<div class="col-xs-9 content no-top-border">
										<p class="m-b-xs">
											<strong>${process.task.taskName}</strong>
										</p>
										<p>${process.remarks}</p>
										<p>操作人: ${process.endUser.name} 操作时间： <fmt:formatDate value="${process.endTime}" pattern="yyyy/MM/dd" /></p>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			
			<div class="col-lg-6">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>罐箱历史记录</h5>
					</div>
					<div class="ibox-content inspinia-timeline">
						<c:forEach items="${tankOperationLogList}" var="tankOperationLog" varStatus="varStatus">
							<div class="timeline-item">
								<div class="row">
									<div class="col-xs-3 date">
										<i class="fa fa-file-text"></i><fmt:formatDate value="${tankOperationLog.operationTime}" pattern="yyyy/MM/dd" />
									</div>
									<c:if test="${varStatus.first}">
										<div class="col-xs-9 content no-top-border">
											<p class="m-b-xs">
												<strong>${tankOperationLog.operator.name}对罐箱${tankOperationLog.tank.tankCode}</strong>
											</p>
											<p>${tankOperationLog.operationLog}</p>
										</div>
									</c:if>
									<c:if test="${not varStatus.first}">
										<div class="col-xs-9 content">
											<p class="m-b-xs">
												<strong>${tankOperationLog.operator.name}对罐箱${tankOperationLog.tank.tankCode}</strong>
											</p>
											<p>${tankOperationLog.operationLog}</p>
										</div>
									</c:if>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<div class="pull-right">
					<input id="btnCancel" class="btn btn-default btn-sm" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</div>
		<%@include file="/WEB-INF/views/include/footer.jsp"%>
	</div>
</body>
</html>
