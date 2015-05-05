<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
	<head>
		<title>我的工作台</title>
		<meta name="decorator" content="default" />
		<!-- iCheck -->
		<link href="${ctxStatic}/icheck/flat/green.css" rel="stylesheet">
		<script src="${ctxStatic}/icheck/icheck.js"></script>
		<script type="text/javascript" src="${ctxStatic}/js/simplejsmap.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				
			});
		</script>
	</head>
	<body>
		<div class="wrapper wrapper-content animated fadeInRight">
			<div class="row">
				<div class="col-lg-8">
				<div class="ibox float-e-margins">
						<div class="ibox-title">
                            <h5>任务列表</h5>
                        </div>
                        <div class="ibox-content">
                        	<div class="list-group">
						      <a class="list-group-item active" href="#">
						        <h4 class="list-group-item-heading">List group item heading</h4>
						        <p class="list-group-item-text">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
						      </a>
						      <a class="list-group-item" href="#">
						        <h4 class="list-group-item-heading">List group item heading</h4>
						        <p class="list-group-item-text">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
						      </a>
						      <a class="list-group-item" href="#">
						        <h4 class="list-group-item-heading">List group item heading</h4>
						        <p class="list-group-item-text">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
						      </a>
						    </div>
                        </div>
                </div>
				</div>
				
				<div class="col-lg-4">
					<div class="ibox float-e-margins">
						<div class="ibox-content">
							<center>
								<h4>你好，${fns:getUser().name}</h4>
								<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
								<span class="">今天是<fmt:formatDate value="${now}" pattern="EEEE"/>，<fmt:formatDate value="${now}" pattern="yyyy年MM月dd日"/></span>
							</center>
							<div style="margin-bottom: 10px;"></div>
							<div class="row">
								<div class="col-lg-3" style="border-right: 1px solid #e1e1e1;">
									<center>
										<a href="${ctx}/process/workbench/customService">
											<span class="badge badge-warning">42</span><br/>
											<span>待进场箱检</span>
										</a>
									</center>
								</div>
								<div class="col-lg-3">
									<center>
										<a href="#">
											<span class="badge badge-warning">42</span><br/>
											<span style="padding: 10px 0;">待出场箱检</span>
										</a>
									</center>
								</div>
							</div>
							<div style="margin-bottom: 10px;"></div>
							<hr class="hr-divider"/>
							<div class="row">
								<div class="col-lg-3" style="border-right: 1px solid #e1e1e1;">
									<center>
										<a href="#">
											<span class="badge badge-warning">42</span><br/>
											<span>待清洗</span>
										</a>
									</center>
								</div>
								<div class="col-lg-3" style="border-right: 1px solid #e1e1e1;">
									<center>
										<a href="#">
											<span class="badge badge-warning">42</span><br/>
											<span style="padding: 10px 0;">待翻新</span>
										</a>
									</center>
								</div>
								<div class="col-lg-3" style="border-right: 1px solid #e1e1e1;">
									<center>
										<a href="#">
											<span class="badge badge-warning">42</span><br/>
											<span style="padding: 10px 0;">待估价</span>
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
					<%@include file="/WEB-INF/views/include/messages.jsp" %>
				</div>
			</div>
		</div>
		<div class="footer">
			<div>
				<strong>Copyright</strong> ISO Tank&copy; 2014-2015
			</div>
		</div>
	</body>
</html>