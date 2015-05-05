<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>我的工作台</title>
<%@include file="/WEB-INF/views/include/head.jsp"%>
<!-- metisMenu -->
<script src="${ctxStatic}/jquery-metisMenu/jquery.metisMenu.js"></script>
<!-- slimscroll -->
<script src="${ctxStatic}/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- Init menu -->
<script src="${ctxStatic}/js/menuInit.js"></script>
</head>
<body class="fixed-navigation">
	<div id="wrapper">
		<nav class="navbar-default navbar-static-side" role="navigation">
			<div class="sidebar-collapse">
				<%@include file="/WEB-INF/views/include/menu.jsp" %>
			</div>
		</nav>
		<div id="page-wrapper" class="gray-bg sidebar-content">
			<div class="row border-bottom">
				<nav class="navbar navbar-static-top white-bg" role="navigation" style="margin-bottom: 0">
					<div class="navbar-header">
						<a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
					</div>
					<ul class="nav navbar-top-links navbar-right">
						<li><span class="m-r-sm text-muted welcome-message">欢迎您， ${fns:getUser().loginName}</span></li>
						<li class="dropdown">
							<a class="dropdown-toggle count-info" data-toggle="dropdown" href="#"> <i class="fa fa-envelope"></i><span class="label label-warning">16</span></a>
							<ul class="dropdown-menu dropdown-messages">
								<li>
									<div class="dropdown-messages-box">
										<a href="profile.html" class="pull-left"> <img alt="image"class="img-circle" src="${ctxStatic}/image/ajax-loader.gif"/></a>
										<div>
											<small class="pull-right">46h ago</small> <strong>Mike Loreipsum</strong> started following <strong>Monica Smith</strong>. <br>
											<small class="text-muted">3 days ago at 7:58 pm - 10.06.2014</small>
										</div>
									</div>
								</li>
								<li class="divider"></li>
								<li>
									<div class="dropdown-messages-box">
										<a href="profile.html" class="pull-left"> <img alt="image"class="img-circle" src="${ctxStatic}/image/ajax-loader.gif"/>
										</a>
										<div>
											<small class="pull-right text-navy">5h ago</small> <strong>Chris Johnatan Overtunk</strong> started following <strong>Monica Smith</strong>. <br>
											<small class="text-muted">Yesterday 1:21 pm - 11.06.2014</small>
										</div>
									</div>
								</li>
								<li class="divider"></li>
								<li>
									<div class="dropdown-messages-box">
										<a href="profile.html" class="pull-left">  <img alt="image"class="img-circle" src="${ctxStatic}/image/ajax-loader.gif"/>
										</a>
										<div>
											<small class="pull-right">23h ago</small> <strong>Monica Smith</strong> love <strong>Kim Smith</strong>. <br> 
											<small class="text-muted">2 days ago at 2:30 am - 11.06.2014</small>
										</div>
									</div>
								</li>
								<li class="divider"></li>
								<li>
									<div class="text-center link-block">
										<a href="#"> <i class="fa fa-envelope"></i> <strong>Read All Messages</strong></a>
									</div>
								</li>
							</ul>
						</li>
						<li class="dropdown">
							<a class="dropdown-toggle count-info" data-toggle="dropdown" href="#"> <i class="fa fa-bell"></i> <span class="label label-primary">8</span></a>
							<ul class="dropdown-menu dropdown-alerts">
								<li><a href="mailbox.html">
										<div>
											<i class="fa fa-envelope fa-fw"></i> You have 16 messages <span class="pull-right text-muted small">4 minutes ago</span>
										</div>
								</a></li>
								<li class="divider"></li>
								<li><a href="profile.html">
										<div>
											<i class="fa fa-twitter fa-fw"></i> 3 New Followers <span class="pull-right text-muted small">12 minutes ago</span>
										</div>
								</a></li>
								<li class="divider"></li>
								<li><a href="grid_options.html">
										<div>
											<i class="fa fa-upload fa-fw"></i> Server Rebooted <span class="pull-right text-muted small">4 minutes ago</span>
										</div>
								</a></li>
								<li class="divider"></li>
								<li>
									<div class="text-center link-block">
										<a href="#"> <strong>See All Alerts</strong> <i class="fa fa-angle-right"></i></a>
									</div>
								</li>
							</ul>
						</li>
						<li><a href="${ctx}/logout"> <i class="fa fa-sign-out"></i> 退出</a></li>
					</ul>

				</nav>
			</div>
			<div class="sidebard-panel">
				<div>
					<h4>
						Messages <span class="badge badge-info pull-right">16</span>
					</h4>
					<div class="feed-element">
						<a href="#" class="pull-left"> <img alt="image"class="img-circle" src="${ctxStatic}/image/ajax-loader.gif"/>
						</a>
						<div class="media-body">
							There are many variations of passages of Lorem Ipsum available. <br>
							<small class="text-muted">Today 4:21 pm</small>
						</div>
					</div>
					<div class="feed-element">
						<a href="#" class="pull-left">  <img alt="image"class="img-circle" src="${ctxStatic}/image/ajax-loader.gif"/>
						</a>
						<div class="media-body">
							TIt is a long established fact that. <br> <small
								class="text-muted">Yesterday 2:45 pm</small>
						</div>
					</div>
					<div class="feed-element">
						<a href="#" class="pull-left">  <img alt="image"class="img-circle" src="${ctxStatic}/image/ajax-loader.gif"/>
						</a>
						<div class="media-body">
							Many desktop publishing packages. <br> <small
								class="text-muted">Yesterday 1:10 pm</small>
						</div>
					</div>
					<div class="feed-element">
						<a href="#" class="pull-left"> <img alt="image"class="img-circle" src="${ctxStatic}/image/ajax-loader.gif"/>
						</a>
						<div class="media-body">
							The generated Lorem Ipsum is therefore always free. <br> <small
								class="text-muted">Monday 8:37 pm</small>
						</div>
					</div>
					<div class="feed-element">
						<a href="#" class="pull-left"> <img alt="image"class="img-circle" src="${ctxStatic}/image/ajax-loader.gif"/>
						</a>
						<div class="media-body">
							The generated Lorem Ipsum is therefore always free. <br> <small
								class="text-muted">Monday 8:37 pm</small>
						</div>
					</div>
					<div class="feed-element">
						<a href="#" class="pull-left"> <img alt="image"class="img-circle" src="${ctxStatic}/image/ajax-loader.gif"/>
						</a>
						<div class="media-body">
							The generated Lorem Ipsum is therefore always free. <br> <small
								class="text-muted">Monday 8:37 pm</small>
						</div>
					</div>
					<div class="feed-element">
						<a href="#" class="pull-left"> <img alt="image"class="img-circle" src="${ctxStatic}/image/ajax-loader.gif"/>
						</a>
						<div class="media-body">
							The generated Lorem Ipsum is therefore always free. <br> <small
								class="text-muted">Monday 8:37 pm</small>
						</div>
					</div>
					<div class="feed-element">
						<a href="#" class="pull-left"> <img alt="image"class="img-circle" src="${ctxStatic}/image/ajax-loader.gif"/>
						</a>
						<div class="media-body">
							The generated Lorem Ipsum is therefore always free. <br> <small
								class="text-muted">Monday 8:37 pm</small>
						</div>
					</div>
				</div>
				<div class="m-t-md">
					<h4>Discussion</h4>
					<div>
						<ul class="list-group">
							<li class="list-group-item"><span
								class="badge badge-primary">16</span> General topic</li>
							<li class="list-group-item "><span class="badge badge-info">12</span>
								The generated Lorem</li>
							<li class="list-group-item"><span
								class="badge badge-warning">7</span> There are many variations</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="wrapper wrapper-content">
				<div class="row">
					<div class="col-lg-12">
						<div class="ibox float-e-margins">
							<div class="ibox-content">
								<div class="row">
									<div class="col-lg-8 col-md-8">
										<form id="searchForm" action="#" method="post" class="form-inline">
											<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
											<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
											<div class="input-group input-group-sm">
											  <input type="text" class="form-control" placeholder="罐箱号"/>
											  <span class="input-group-addon"><a href="#"><i class="fa fa-search"></i> 查询</a></span>
											</div>
										</form>
									</div>
									<div class="col-lg-4  col-md-4">
										<div class="btn-group btn-group-sm pull-right">
										  <button type="button" class="btn btn-white">前5条</button>
										  <button type="button" class="btn btn-white">后5条</button>
										</div>
									</div>
								</div>
								<hr class="hr-divider"/>
								<div class="assign-item">
									<div>
										<span class="pull-right text-right"> 
											<span>创建者: <strong> Yu Chao</strong></span> 
										</span>
										<h3 class="m-b-xs">
											罐箱 CBHU3202732
										</h3>
										<div>
											<p>
											<a href="#" class="custion-tooptip" data-toggle="tooltip" data-placement="top" title="" data-original-title="虚拟出场"><i class="fa fa-mail-forward"></i> 宁波远东 </a> 
											<i class="fa fa-user"></i> <i class="fa fa-phone"></i> <i class="fa fa-envelope"></i></p>
											<script type="text/javascript">
												$(document).ready(function(){
													$(".custion-tooptip").tooltip();
												});
											</script>
										</div>
									</div>
									<div class="row">
										<div class="col-xs-8 col-sm-8 col-lg-8">
											<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 进场</button>
							        		<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 清洗</button>
							        		<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 实验测试</button>
							        		<button type="button" class="btn btn-warning btn-sm"><span class="fa fa-spinner"></span> 估价</button>
							        		<button type="button" class="btn btn-default btn-sm">修理</button>
							        		<button type="button" class="btn btn-default btn-sm">清洁检验</button>
							        		<button type="button" class="btn btn-default btn-sm">出场</button>
						        		</div>
						        		<div class="col-xs-4 col-sm-4 col-lg-4">
						        			<p class="pull-right" style="margin:0;">
							        			<button type="button" class="btn btn-default btn-sm">服务详情</button>
			        							<button type="button" class="btn btn-default btn-sm">费用详情</button>
		        							</p>
						        		</div>
									</div>
	
									<div>
										<small class="pull-right"> 
											<i class="fa fa-clock-o"></i> 上次操作时间 2014/12/19
										</small> 
										<span> 截至今天，我们已经为您服务35天.</span>
									</div>
								</div>
								
								<hr class="hr-divider"/>
								
								<div class="assign-item">
									<div>
										<span class="pull-right text-right"> 
											<span>创建者: <strong> Yu Chao</strong></span> 
										</span>
										<h3 class="m-b-xs">
											罐箱 CBHU3202732
										</h3>
										<div>
											<p>
											<a href="#" class="custion-tooptip" data-toggle="tooltip" data-placement="top" title="" data-original-title="虚拟出场"><i class="fa fa-mail-forward"></i> 宁波远东 </a> 
											<i class="fa fa-user"></i> <i class="fa fa-phone"></i> <i class="fa fa-envelope"></i></p>
											<script type="text/javascript">
												$(document).ready(function(){
													$(".custion-tooptip").tooltip();
												});
											</script>
										</div>
									</div>
									<div class="row">
										<div class="col-xs-8 col-sm-8 col-lg-8">
											<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 进场</button>
							        		<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 清洗</button>
							        		<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 实验测试</button>
							        		<button type="button" class="btn btn-warning btn-sm"><span class="fa fa-spinner"></span> 估价</button>
							        		<button type="button" class="btn btn-default btn-sm">修理</button>
							        		<button type="button" class="btn btn-default btn-sm">清洁检验</button>
							        		<button type="button" class="btn btn-default btn-sm">出场</button>
						        		</div>
						        		<div class="col-xs-4 col-sm-4 col-lg-4">
						        			<p class="pull-right" style="margin:0;">
							        			<button type="button" class="btn btn-default btn-sm">服务详情</button>
			        							<button type="button" class="btn btn-default btn-sm">费用详情</button>
		        							</p>
						        		</div>
									</div>
									<div>
										<small class="pull-right"> 
											<i class="fa fa-clock-o"></i> 上次操作时间 2014/12/19
										</small> 
										<span> 截至今天，我们已经为您服务35天.</span>
									</div>
								</div>
								
								<hr class="hr-divider"/>
								
								<div class="assign-item">
									<div>
										<span class="pull-right text-right"> 
											<span>创建者: <strong> Yu Chao</strong></span> 
										</span>
										<h3 class="m-b-xs">
											罐箱 CBHU3202732
										</h3>
										<div>
											<p>
											<a href="#" class="custion-tooptip" data-toggle="tooltip" data-placement="top" title="" data-original-title="虚拟出场"><i class="fa fa-mail-forward"></i> 宁波远东 </a> 
											<i class="fa fa-user"></i> <i class="fa fa-phone"></i> <i class="fa fa-envelope"></i></p>
											<script type="text/javascript">
												$(document).ready(function(){
													$(".custion-tooptip").tooltip();
												});
											</script>
										</div>
									</div>
	
									<div class="row">
										<div class="col-xs-8 col-sm-8 col-lg-8">
											<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 进场</button>
							        		<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 清洗</button>
							        		<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 实验测试</button>
							        		<button type="button" class="btn btn-warning btn-sm"><span class="fa fa-spinner"></span> 估价</button>
							        		<button type="button" class="btn btn-default btn-sm">修理</button>
							        		<button type="button" class="btn btn-default btn-sm">清洁检验</button>
							        		<button type="button" class="btn btn-default btn-sm">出场</button>
						        		</div>
						        		<div class="col-xs-4 col-sm-4 col-lg-4">
						        			<p class="pull-right" style="margin:0;">
							        			<button type="button" class="btn btn-default btn-sm">服务详情</button>
			        							<button type="button" class="btn btn-default btn-sm">费用详情</button>
		        							</p>
						        		</div>
									</div>
	
									<div>
										<small class="pull-right"> 
											<i class="fa fa-clock-o"></i> 上次操作时间 2014/12/19
										</small> 
										<span> 截至今天，我们已经为您服务35天.</span>
									</div>
								</div>
								
								<hr class="hr-divider"/>
								
								<div class="assign-item">
									<div>
										<span class="pull-right text-right"> 
											<span>创建者: <strong> Yu Chao</strong></span> 
										</span>
										<h3 class="m-b-xs">
											罐箱 CBHU3202732
										</h3>
										<div>
											<p>
											<a href="#" class="custion-tooptip" data-toggle="tooltip" data-placement="top" title="" data-original-title="虚拟出场"><i class="fa fa-mail-forward"></i> 宁波远东 </a> 
											<i class="fa fa-user"></i> <i class="fa fa-phone"></i> <i class="fa fa-envelope"></i></p>
											<script type="text/javascript">
												$(document).ready(function(){
													$(".custion-tooptip").tooltip();
												});
											</script>
										</div>
									</div>
	
									<div class="row">
										<div class="col-xs-8 col-sm-8 col-lg-8">
											<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 进场</button>
							        		<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 清洗</button>
							        		<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 实验测试</button>
							        		<button type="button" class="btn btn-warning btn-sm"><span class="fa fa-spinner"></span> 估价</button>
							        		<button type="button" class="btn btn-default btn-sm">修理</button>
							        		<button type="button" class="btn btn-default btn-sm">清洁检验</button>
							        		<button type="button" class="btn btn-default btn-sm">出场</button>
						        		</div>
						        		<div class="col-xs-4 col-sm-4 col-lg-4">
						        			<p class="pull-right" style="margin:0;">
							        			<button type="button" class="btn btn-default btn-sm">服务详情</button>
			        							<button type="button" class="btn btn-default btn-sm">费用详情</button>
		        							</p>
						        		</div>
									</div>
	
									<div>
										<small class="pull-right"> 
											<i class="fa fa-clock-o"></i> 上次操作时间 2014/12/19
										</small> 
										<span> 截至今天，我们已经为您服务35天.</span>
									</div>
								</div>
								
								<hr class="hr-divider"/>
								
								<div class="assign-item">
									<div>
										<span class="pull-right text-right"> 
											<span>创建者: <strong> Yu Chao</strong></span> 
										</span>
										<h3 class="m-b-xs">
											罐箱 CBHU3202732
										</h3>
										<div>
											<p>
											<a href="#" class="custion-tooptip" data-toggle="tooltip" data-placement="top" title="" data-original-title="虚拟出场"><i class="fa fa-mail-forward"></i> 宁波远东 </a> 
											<i class="fa fa-user"></i> <i class="fa fa-phone"></i> <i class="fa fa-envelope"></i></p>
											<script type="text/javascript">
												$(document).ready(function(){
													$(".custion-tooptip").tooltip();
												});
											</script>
										</div>
									</div>
	
									<div class="row">
										<div class="col-xs-8 col-sm-8 col-lg-8">
											<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 进场</button>
							        		<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 清洗</button>
							        		<button type="button" class="btn btn-success btn-sm"><span class="fa fa-check"></span> 实验测试</button>
							        		<button type="button" class="btn btn-warning btn-sm"><span class="fa fa-spinner"></span> 估价</button>
							        		<button type="button" class="btn btn-default btn-sm">修理</button>
							        		<button type="button" class="btn btn-default btn-sm">清洁检验</button>
							        		<button type="button" class="btn btn-default btn-sm">出场</button>
						        		</div>
						        		<div class="col-xs-4 col-sm-4 col-lg-4">
						        			<p class="pull-right" style="margin:0;">
							        			<button type="button" class="btn btn-default btn-sm">服务详情</button>
			        							<button type="button" class="btn btn-default btn-sm">费用详情</button>
		        							</p>
						        		</div>
									</div>
	
									<div>
										<small class="pull-right"> 
											<i class="fa fa-clock-o"></i> 上次操作时间 2014/12/19
										</small> 
										<span> 截至今天，我们已经为您服务35天.</span>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="footer">
				<div>
					<strong>Copyright</strong> ISO Tank&copy; 2014-2015
				</div>
			</div>
		</div>
	</div>
</body>
</html>