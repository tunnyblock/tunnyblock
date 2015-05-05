<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<ul id="side-menu" class="nav">
	<li class="nav-header">
         <div class="dropdown profile-element"> 
         	<center>
	         	<span>
	            	<img src="${ctxStatic}/image/index.png" class="img-rounded" alt="image" width="100"/>
	            </span>
            </center>
         </div>
         <div class="logo-element">Tank+</div>
     </li>
	<c:set var="menuList" value="${fns:getMenuList()}" />
	<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
		<c:if test="${menu.parent.id eq '1' }">
			<c:choose>
				<c:when test="${menu.firstLevelEmpty}">
					<li><a href="${baseCtx}${empty menu.href?'#':menu.href}"><i class="fa fa-th-large"></i> <span class="nav-label">${menu.name }</span></a></li>
				</c:when>
				<c:otherwise>
						<li>
							<a href="#"><i class="fa fa-edit"></i> <span class="nav-label">${menu.name }</span><span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<c:forEach items="${menuList}" var="menuChild">
									<c:if test="${menu.id eq menuChild.parent.id }">
										<li><a href="${ctx}${menuChild.href}">${menuChild.name }</a></li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
				</c:otherwise>
			</c:choose>
		</c:if>
	</c:forEach>
</ul>