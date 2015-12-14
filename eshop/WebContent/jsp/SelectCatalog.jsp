<%@page language="java" contentType="text/html"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="eshop.beans.Book"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="dataManager" scope="application"
  class="eshop.model.DataManager"/>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>Browse Catalog</title>
  <link rel="stylesheet" href="/eshop/css/eshop.css" type="text/css"/>
  </head>
<body>
<jsp:include page="TopMenu.jsp" flush="true"/>
<jsp:include page="LeftMenu.jsp" flush="true"/>

  <c:choose>
  	<c:when test="${requestScope.categoryName != null }">
    <div class="content">
      <h2>Select Catalog</h2>
      <p>Category: <strong>${requestScope.categoryName }</strong></p>
      <table>
        <tr>
          <th>Title</th>
          <th>Author</th>
          <th>Price</th>
          <th>Details</th>
          </tr>
          <c:forEach var="book" items="${requestScope.books }">
        	  <tr>
            	<td>${book.title }</td>
            	<td>${book.author }</td>
           	    <td>${book.price }</td>
           			 <td><a class="link1"
            	  href="${applicationScope.base }?action=bookDetails&bookId=${book.id}">
              Details</a></td>        
           	 </tr>
          </c:forEach>
           </table>
      </div>
     </c:when>
		<c:otherwise>	
			<p class="error">Invalid category!</p>
		</c:otherwise>
	</c:choose>
</body>
</html>
