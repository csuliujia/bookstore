<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<jsp:include page="../static/head.html"/>

</head>
<body>
<div id="header" class="wrap">
	<div id="logo"><img src="<%=basePath %>images/logo.gif" /></div>
	<div class="help">
		<a href="cartPage.do" class="shopping">查看购物车</a>
		<c:if test="${sessionScope.user!=null}"><a href="userOrder.do?uid=${sessionScope.user.uid}">我的订单</a>&nbsp;用户:${sessionScope.user.uname}&nbsp;&nbsp;<a href="updateUserPage.do">更新个人信息</a><a href="updatePwdPage.do">修改密码</a><a href="logout.do">注销</a></c:if>
		<c:if test="${sessionScope.user==null}"><a href="login.do">登录</a><a href="reg.do">注册</a></c:if>
	</div>
	<div class="navbar">
		<ul class="clearfix">
			<li class="current"><a href="index.do">首页</a></li>
			<div class="search">
				<form method="post" action="productList.do">
					 查找书籍：<input type="text" class="text" name="key" placeholder="请输入商品关键字"  /> <label class="ui-blue"><input type="submit" name="submit" value="搜索" /></label>
				</form>
			</div>
		</ul>
	</div>
</div>
<div id="childNav">
	<div class="wrap">
		<ul class="clearfix">
			<c:forEach items="${bts}" var="bt">
			<li><a href="productList.do?type=${bt}" >${bt}</a></li>
			</c:forEach>
		</ul>
	</div>
</div>
<div id="main" class="wrap">
	<div class="main">
		<h2>我的订单</h2>
		<div class="manage">
			<div class="spacer"></div>
			<table class="list">
					<c:forEach items="${bookOrders}" var="bookOrder">
						<tr>
							<td class="first w4 c">订单号:${bookOrder.oid}</td>
							<td class="w1 c">${bookOrder.date}</td>
							<td class="w1 c">收货人:${bookOrder.oname}</td>
							<td>收货地址：${bookOrder.adress}</td>
							<td class="w1 c">状态</td>
							<td class="w1 c">评价</td>
						</tr>
							<c:forEach items="${orderDetails }" var="orderDetail">
							<c:if test="${bookOrder.oid==orderDetail.orderId}">
								<c:forEach items="${books }" var="book">
								<c:if test="${book.bid==orderDetail.bookId }">
										<tr>
											<td class="first w4 c"><a href="bookView.do?bid=${book.bid }">${book.bname }<a/></td>
											<td class="w1 c"><img height="80" width="80" src="<%=basePath %>images/product/${book.image}"></td>
											<td class="w1 c">数量：${orderDetail.bookNum }</td>
											<td>￥${book.pirce*orderDetail.bookNum }</td>
											<td class="w1 c">${bookOrder.status }</td>
											<c:if test="${orderDetail.status=='待评价' }">
											<td class="w1 c"><a href="commentPage.do?bid=${book.bid }&odid=${orderDetail.id }">待评价</a></td>
											</c:if>
											<c:if test="${orderDetail.status=='已评价' }">
											<td class="w1 c">已评价</td>
											</c:if>
										</tr> 
								</c:if>
								</c:forEach>
							</c:if>
							</c:forEach>
					</c:forEach>
				</table>
			<div class="pager">
					<ul class="clearfix">
						<c:choose>
							<c:when test="${pageInfo.hasPreviousPage}">
								<li><a href="userOrder.do?pageNum=1&uid=${sessionScope.user.uid }">首页</a></li>
								<li><a href="userOrder.do?pageNum=${pageInfo.prePage }&uid=${sessionScope.user.uid }">上一页</a></li>
							</c:when>
							<c:otherwise>
								<li>首页</li>
								<li>上一页</li>
							</c:otherwise>
						</c:choose>

						<c:forEach var="index" begin="1" end="${pageInfo.pages }">

							<li
								<c:if test="${index==pageInfo.pageNum}">class="current"</c:if>><a
								href="userOrder.do?pageNum=${index }&uid=${sessionScope.user.uid }">${index }</a></li>
						</c:forEach>

						<c:choose>
							<c:when test="${pageInfo.hasNextPage}">
								<li><a href="userOrder.do?pageNum=${pageInfo.nextPage }&uid=${sessionScope.user.uid }">下一页</a></li>
								<li><a href="userOrder.do?pageNum=${pageInfo.pages }&uid=${sessionScope.user.uid }">尾页</a></li>
							</c:when>
							<c:otherwise>
								<li>下一页</li>
								<li>尾页</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
		</div>
	</div>
	<div class="clear"></div>
</div>
<div id="footer">
	Copyright &copy; 2010 All Rights Reserved.
</div>
</body>
</html>
