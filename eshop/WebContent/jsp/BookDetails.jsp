<%@page language="java" contentType="text/html"%>
<%@page import="eshop.beans.Book"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="dataManager" scope="application"
  class="eshop.model.DataManager"/>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>Book details</title>
  <link rel="stylesheet" href="/eshop/css/eshop.css" type="text/css"/>
  </head>
<body>
<jsp:include page="TopMenu.jsp" flush="true"/>
<jsp:include page="LeftMenu.jsp" flush="true"/>
<div class="content">
  <h2>Book details</h2>
      <table>
        <tr>
          <td>
            <img src="${applicationScope.imageURL}${book.id}.gif"/> 
            </td>
          <td>
            <b>${requestScope.book.title }</b><br/>
           ${requestScope.book.author }<br/>
            Price: ${requestScope.book.price}
            </td>
          </tr>
        <tr>
          <td colspan="2" align="right">
            <a class="link1"
              href="${applicationScope.base }?action=addItem&bookId=${book.id}">
              Add To Cart</a>
            </td>
          </tr>
        </table>
  </div>
</body>
</html>
