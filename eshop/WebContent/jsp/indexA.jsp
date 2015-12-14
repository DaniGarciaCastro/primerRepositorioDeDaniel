<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>Welcome to Daniel e-Shop 2</title>
  <link rel="stylesheet" href="/eshop/css/eshop.css" type="text/css"/>
  </head>
<body>
<jsp:include page="TopMenu.jsp" flush="true"/>
<jsp:include page="LeftMenu.jsp" flush="true"/>
<div class="content">
  <h1>Welcome to e-Shop Admin</h1>
  	<fieldset>
  	<legend>Pedido</legend>
  		<form action="">
  			<input type="hidden" name="action" value="searchOrder" />
  			Order ID: <input type="text" name="pedido"/><br/><br/>
  			<input type="submit" value="Buscar" />
  		</form>
 	 </fieldset>
 	 </br>
 	 <c:choose>
 	 <c:when test="${requestScope.librosPedido != null && !requestScope.librosPedido.isEmpty() }">
 	 <table border="1px">
 	 <tr>
 	 	<th>Titulo</th>
 	 	<th>Autor</th>
 	 	<th>Cantidad</th>
 	 	<th>Precio</th>
 	 </tr>
 	 <c:forEach var="libro" items="${requestScope.librosPedido }">
 	 <tr>
 	 	<td>${libro.title}</td>
 	 	<td>${libro.author}</td>
 	 	<td>${libro.quantity}</td>
 	 	<td>${libro.price}</td>
 	 </tr>
 	  </c:forEach>
 	 </table>
 	 </c:when>
 	 <c:otherwise>
 	 	<p>No se ha encontrado ninguna Orden</p>
 	 </c:otherwise>
 	 </c:choose>
  </div>
</body>
</html>
