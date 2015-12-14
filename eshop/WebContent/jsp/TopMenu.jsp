<%@page language="java" contentType="text/html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="header">
  <div class="logo">

<p><a href="${applicationScope.base}?action=home">e-Shopping Center</a></p> 		
  		
  </div>
 
  <div class="cart">
    <a class="link2" href="${applicationScope.base }?action=showCart">Show Cart
      <img src="${applicationScope.imageURL}cart.gif" border="0"/></a>
    </div>
  </div>