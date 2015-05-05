<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<style>
  	body {
	    background-color: #eee;
	    padding-bottom: 40px;
	    padding-top: 40px;
	}
  </style>
</head>
<body>
	<div class="container">
	  <div class="row">
	  <!--[if lte IE 6]><br/><div class='alert alert-block' style="text-align:left;padding-bottom:10px;"><a class="close" data-dismiss="alert">x</a><h4>温馨提示：</h4><p>你使用的浏览器版本过低。为了获得更好的浏览体验，我们强烈建议您 <a href="http://browsehappy.com" target="_blank">升级</a> 到最新版本的IE浏览器，或者使用较新版本的 Chrome、Firefox、Safari 等。</p></div><![endif]-->
	  	<div class="col-lg-4 col-xs-4"></div>
	  	<div class="col-lg-3 col-xs-3">
	  		<%String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);%>
			<div id="messageBox" class="alert alert-danger <%=error==null?"hide":""%>"><button data-dismiss="alert" class="close">×</button>
				<label id="loginError" class="error"><%=error==null?"":"com.thinkgem.jeesite.modules.sys.security.CaptchaException".equals(error)?"验证码错误, 请重试.":"用户或密码错误, 请重试." %></label>
			</div>
	  		<form role="form" class="form-horizontal" id="loginForm" action="${ctx}/login" method="post">
		        <div class="form-group">
		        	<div class="input-group">
					  <span class="input-group-addon"><i class="fa fa-user"></i></span>
					  <input type="text" class="form-control required" placeholder="用户名..." id="username" name="username">
					</div>
		        </div>
		        <div class="form-group">
		        	<div class="input-group">
					  <span class="input-group-addon"><i class="fa fa-lock"></i></span>
					  <input type="password" class="form-control required" placeholder="密码..."  id="password" name="password">
					</div>
		        </div>
		        
		        <c:if test="${isValidateCodeLogin}">
					<div class="form-group">
						<label for="validateCode">验证码：</label>
						<tags:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
					</div>
				</c:if>
					
		        <div class="form-group">
		        	<div class="row">
		        		<div class="col-lg-4 col-sm-4 col-xs-4">
			        		<div class="checkbox checkbox-inline">
		                        <input type="checkbox"  id="rememberMe" name="rememberMe"/>
		                        <label for="rememberMe"> 记住我 </label>
		                    </div>
                    </div>
		        		<div class="col-lg-4 col-sm-4 col-xs-4"><button type="submit" class="btn btn-default btn-block">登录</button></div>
		        		<div class="col-lg-4 col-sm-4 col-xs-4"><button type="button" class="btn btn-success btn-block">注册</button></div>
		        	</div>
		        </div>
		      </form>
	  	</div>
	  </div>
    </div>
  </body>
</html>