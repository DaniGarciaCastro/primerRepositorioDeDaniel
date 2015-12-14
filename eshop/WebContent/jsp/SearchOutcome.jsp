<%@page language="java" contentType="text/html"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="eshop.beans.Book"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="dataManager" scope="application"
  class="eshop.model.DataManager"/>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>Search Outcome</title>
  <link rel="stylesheet" href="/eshop/css/eshop.css" type="text/css"/>
  </head>
<body>
<jsp:include page="TopMenu.jsp" flush="true"/>
<jsp:include page="LeftMenu.jsp" flush="true"/>
    <div class="content">
      <h2>Search results</h2>
      <c:choose>
      <c:when test="${requestScope.keyword != null && !requestScope.keyword.trim().equals('')}">
      <c:choose>
      <c:when test="${!requestScope.searchBooks.isEmpty() }">
      <table>
      
        <tr>
          <th>Title</th>
          <th>Author</th>
          <th>Price</th>
          <th>Details</th>
          </tr>
          
  			<c:forEach var="book" items="${requestScope.searchBooks }">
          <tr>
            <td>${book.title}</td>
            <td>${book.author}</td>
            <td>${book.price}</td>
            <td><a class="link1"
              href="${applicationScope.base }?action=bookDetails&bookId=${book.id}">
		      Details</a></td>
	        </tr>
	        </c:forEach>
          </table>
           </c:when>
	        <c:otherwise>
	        	<p class="error">No se ha encontrado ningun libro</p>
	        </c:otherwise>
	        </c:choose>
	        </c:when>
        <c:otherwise>
        	<p class="error">El campo de búsqueda está vacío!</p>
        </c:otherwise>
        </c:choose>
        </div>
        
</body>
</html>
