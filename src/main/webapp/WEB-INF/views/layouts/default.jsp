<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<html>
<head>
<title>Tankplus</title>
<%@include file="/WEB-INF/views/include/head.jsp"%>

<!-- metisMenu -->
<script src="${ctxStatic}/jquery-metisMenu/jquery.metisMenu.js"></script>
<!-- slimscroll -->
<script src="${ctxStatic}/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- Init menu -->
<script src="${ctxStatic}/js/menuInit.js"></script>

<sitemesh:head />
</head>
<body>
	<div id="wrapper">
		<div id="page-wrapper" class="gray-bg">
			<div class="row border-bottom">
				<nav class="navbar navbar-default navbar-static-top white-bg" style="margin-bottom: 0px;">
					<div class="container-fluid">
						<div class="navbar-header">
							<a class="navbar-brand" href="#">罐界</a>
						</div>
						<div id="navbar" class="navbar-collapse collapse">
							<ul class="nav navbar-top-links navbar-right">
								<li ><a href="${ctx}/process/workbench/customService"><i class="fa fa-dashboard"></i> 我的工作台</a></li>
								<li class="dropdown"><a class="dropdown-toggle count-info" data-toggle="dropdown" href="#"> <i class="fa fa-plus"></i> 新建</a>
									<ul class="dropdown-menu dropdown-alerts">
										<li><a href="${ctx}/process/preorder/form">
												<div>
													<i class="fa fa-plus fa-fw"></i> 新建进场预录单
												</div>
										</a></li>
										<li class="divider"></li>
										<li><a href="${ctx}/emergency/emergencyMaintenance/form">
												<div>
													<i class="fa fa-plus fa-fw"></i> 新建应急维修单
												</div>
										</a></li>
									</ul>
								</li>
	
								<li class="dropdown">
									<a href="#" data-toggle="dropdown"
										class="dropdown-toggle count-info"> <i
											class="fa fa-user fa-fw"></i> ${fns:getUser().loginName}
									</a>
									<ul class="dropdown-menu dropdown-messages">
										<c:set var="menuList" value="${fns:getMenuList()}" />
										<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
											<c:if test="${menu.parent.id eq '1' }">
												<li>
													<h5>${menu.name }</h5>
													<ul>
														<c:forEach items="${menuList}" var="menuChild">
															<c:if test="${menu.id eq menuChild.parent.id }">
																<li><a href="${ctx}${menuChild.href}"><i class="fa fa-cube fa-fw"></i> ${menuChild.name }</a></li>
															</c:if>
														</c:forEach>
													</ul>
												</li>
												<li class="divider"></li>
											</c:if>
										</c:forEach>
									</ul>
								</li>
								<li><a href="${ctx}/logout"><i class="fa fa-sign-out"></i> 退出</a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>

			<sitemesh:body />
		</div>
	</div>
</body>
</html>
