<%@page language="java" contentType="text/html"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@page import="eshop.beans.Book"%>
<%@page import="eshop.beans.CartItem"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="dataManager" scope="application"
  class="eshop.model.DataManager"/>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>Shopping Cart</title>
  <link rel="stylesheet" href="/eshop/css/eshop.css" type="text/css"/>
  </head>
<body>
<jsp:include page="TopMenu.jsp" flush="true"/>
<jsp:include page="LeftMenu.jsp" flush="true"/>
  <c:choose>
  	<c:when test="${!sessionScope.carrito.isEmpty()}">
    <div class="content">
      <h2>Shopping Cart</h2>
      <table>
      
        <tr>
          <th>Title</th>
          <th>Author</th>
          <th>Price</th>
          <th>Quantity</th>
          <th>Subtotal</th>
          <th>Delete</th>
          </tr>
 	<c:set var="totalPrice" value="0"/>
  	<c:forEach var="libro" items="${sessionScope.carrito }">
  		<c:set var="total" value="${total + libro.value.price * libro.value.quantity }"/>
          <tr>
            <td>${libro.value.title}</td>
            <td>${libro.value.author }</td>
            <td>${libro.value.price }</td>
            <td><form>
              <input type="hidden" name="action" value="updateItem"/>
              <input type="hidden" name="bookId"
                value="${libro.value.bookID }"/>
              <input type="text" size="2" name="quantity" 
                value="${libro.value.quantity }"/>
              <input type="submit" value="Update"/>
              </form></td>
            <td>
              <fmt:formatNumber minFractionDigits="2" maxFractionDigits="2" value="${libro.value.quantity * libro.value.price }"/>
                </td>
            <td><form>
              <input type="hidden" name="action" value="deleteItem"/>
              <input type="hidden" name="bookId" 
                value="${libro.value.bookID }"/>
              <input type="submit" value="Delete"/>
              </form></td>
            </tr>
           </c:forEach>
        <tr>
          <td colspan="5" id="total">Total: <fmt:formatNumber value="${total}"/></td>
          <td class="total">&nbsp;</td>
          </tr>
        <tr>
          <td colspan="6" class="center"><a class="link1"
            href="${applicationScope.base }?action=checkOut">Check Out</a></td>
          </tr>
        </table>
      </div>
      </c:when>
      	<c:otherwise>
      		<p class="info"> El carrito está vacío!</p>
      	</c:otherwise>
      </c:choose>
</body>
</html>
