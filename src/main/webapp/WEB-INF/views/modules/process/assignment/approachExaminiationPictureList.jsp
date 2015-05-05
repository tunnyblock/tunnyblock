<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ page import="java.util.Date"%>
<html>
<head>
	<title>箱检照片列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("a[rel=example_group]").fancybox({
				'transitionIn':'none',
				'transitionOut':'none',
				'titlePosition':'over',
				'titleFormat':function(title, currentArray, currentIndex, currentOpts) {
					return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
				}
			});
		});
	</script>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		
		<div style="margin-top: 10px;"></div>
		
		<form:form id="inputForm" modelAttribute="approachExamination" action="${ctx}/process/approachExamination/save" method="post" class="form-horizontal">
			<div class="row">
				<div class="col-lg-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>箱子进场照片信息</h5>
						</div>
						<div class="ibox-content">
							 <c:if test="${not empty  approachExamination.tankLeftPicture}">
								<a class="fancybox" href="${baseCtx}${approachExamination.tankLeftPicture}" title="箱子左边照片" rel="example_group">
		                            <img alt="image"  src="${baseCtx}${approachExamination.tankLeftPicture}" />
		                        </a>
	                        </c:if>
	                        <c:if test="${not empty  approachExamination.tankRightPicture}">
		                        <a class="fancybox" href="${baseCtx}${approachExamination.tankRightPicture}" title="箱子右边照片" rel="example_group">
		                            <img alt="image"  src="${baseCtx}${approachExamination.tankRightPicture}" />
		                        </a>
	                        </c:if>
	                        <c:if test="${not empty  approachExamination.tankTopPicture}">
		                        <a class="fancybox" href="${baseCtx}${approachExamination.tankTopPicture}" title="箱子顶部照片" rel="example_group">
		                            <img alt="image"  src="${baseCtx}${approachExamination.tankTopPicture}" />
		                        </a>
	                        </c:if>
	                        <c:if test="${not empty  approachExamination.tankBottomPicture}">
		                        <a class="fancybox" href="${baseCtx}${approachExamination.tankBottomPicture}" title="箱子底部照片" rel="example_group">
		                            <img alt="image"  src="${baseCtx}${approachExamination.tankBottomPicture}" />
		                        </a>
	                        </c:if>
	                        <c:if test="${not empty  approachExamination.tankFrontPicture}">
		                        <a class="fancybox" href="${baseCtx}${approachExamination.tankFrontPicture}" title="箱子前部照片" rel="example_group">
		                            <img alt="image"  src="${baseCtx}${approachExamination.tankFrontPicture}" />
		                        </a>
	                        </c:if>
	                        <c:if test="${not empty  approachExamination.tankBackPicture}">
		                        <a class="fancybox" href="${baseCtx}${approachExamination.tankBackPicture}" title="箱子后部照片" rel="example_group">
		                            <img alt="image"  src="${baseCtx}${approachExamination.tankBackPicture}" />
		                        </a>
		                    </c:if>
		                    <c:if test="${not empty  approachExamination.tankEntryHolePicture}">
		                        <a class="fancybox" href="${baseCtx}${approachExamination.tankEntryHolePicture}" title="箱子入孔阀照片" rel="example_group">
		                            <img alt="image"  src="${baseCtx}${approachExamination.tankEntryHolePicture}" />
		                        </a>
	                       </c:if>
	                       <c:if test="${not empty  approachExamination.tankAirValvePicture}">
		                        <a class="fancybox" href="${baseCtx}${approachExamination.tankAirValvePicture}" title="箱子空气阀照片" rel="example_group">
		                            <img alt="image"  src="${baseCtx}${approachExamination.tankAirValvePicture}" />
		                        </a>
	                        </c:if>
	                        <c:if test="${not empty  approachExamination.tankBottomValvePicture}">
		                       	<a class="fancybox" href="${baseCtx}${approachExamination.tankBottomValvePicture}" title="箱子底阀照片" rel="example_group">
		                            <img alt="image"  src="${baseCtx}${approachExamination.tankBottomValvePicture}" />
		                        </a>
	                        </c:if>
	                        
	                        <c:if test="${not empty  approachExamination.damagePicturePackage}">
	                        	<c:set var="damagePictureList" value="${fn:split(approachExamination.damagePicturePackage, ',')}"/>
	                        	<c:forEach items="${damagePictureList }" var="picture" varStatus="varStatus">
	                        		 <a class="fancybox" href="${baseCtx}${picture}" title="箱子损坏照片${varStatus.index+1}" rel="example_group">
			                            <img alt="image"  src="${baseCtx}${picture}" />
			                        </a>
	                        	</c:forEach>
	                        </c:if>
	                        
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2"></label>
				<div class="col-sm-3 col-sm-offset-8 col-lg-2">
					<input id="btnCancel" class="btn btn-default btn-sm pull-right" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</form:form>
		<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>
