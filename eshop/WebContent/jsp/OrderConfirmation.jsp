<%@page language="java" contentType="text/html"%>
<%@page import="java.util.Hashtable"%>
<%@page import="eshop.beans.CartItem"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Order</title>
<link rel="stylesheet" href="/eshop/css/eshop.css" type="text/css" />
</head>
<body>
	<jsp:include page="TopMenu.jsp" flush="true" />
	<jsp:include page="LeftMenu.jsp" flush="true" />
	<div class="content">
		<h2>Order</h2>
		<c:choose>
			<c:when test="${requestScope.orderId > 0}">
		<p class="info">
			Thank you for your purchase.<br /> Your Order Number is:
			${requestScope.orderId }
		</p>
		</c:when>
		<c:otherwise>
			<p class="error">Unexpected error processing the order!</p>
		</c:otherwise>
</c:choose>
	</div>
</body>
</html>
