<%@page language="java" contentType="text/html"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="dataManager" scope="application"
  class="eshop.model.DataManager"/>
<div class="menu"> 
  <div class="box">
    <div class="title">Quick Search</div>
    <p>Book Title/Author:</p>
    <form style="border: 0px solid; padding: 0; margin: 0;">
      <input type="hidden" name="action" value="search"/>
      <input id="text" type="text" name="keyword" size="15"/>
      <input id="submit" type="submit" value="Search"/>
      </form>
    </div>
  <div class="box">
    <div class="title">Categorias</div>
    <c:forEach var="categoria" items="${requestScope.categorias}">
    	<p><a href="${applicationScope.base}?action=selectCatalog&id=${categoria.key}">${categoria.value}</a></p>
    </c:forEach>
    </div>
  </div>
