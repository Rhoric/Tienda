<%-- 
    Document   : template
    Created on : 11/11/2019, 12:53:39 PM
    Author     : 66918
--%>
<%@page import="Utils.RequestUtils"%>
<%@page import="Models.Users"%>
<%@page import="Models.Products"%>
<%@page import="Models.Categories"%>
<%@page import="java.util.List"%>
<%
    int userLogged2 = 0;
    if(request.getSession().getAttribute("currentUser") == null){
        userLogged2 = 0;
    } else {
        userLogged2 = 1;
    }
%>

<html>
<body>

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" style="background-color:#035e82;">
      <div class="container">
          <img class="userimg" src="resources/escudo.png" alt="user" >
          <a class="navbar-brand" href="index.jsp">Espadotas el tripas</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarResponsive">
              <form method="POST" action="GetProductListPublished?search=none&filtering=none" id="searchbar-id" class="form-inline mt-2 mt-md-0">
                  <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
                  <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>

              </form>
              <ul class="navbar-nav ml-auto">
                  
                  <% if (userLogged2 == 0) { %>
                  <li class="nav-item">
                      <a class="nav-link" href="login.jsp">Iniciar sesión</a>
                  </li>
                  <li class="nav-item">
                      <a class="nav-link" href="signup.jsp">Registrarse!!</a>
                  </li>
                  <% } else {
                      Users userx = (Users) request.getSession().getAttribute("currentUser");
                  %>
                  <li class="nav-item"><!-- AGREGAR LINKS -->
                      <a class="nav-link" href="carrito.jsp">Carrito de compras</a>
                  </li>
                  <li class="nav-item"><!-- AGREGAR LINKS -->
                      <a class="nav-link" href="GetPurchaseList">Historial</a>
                  </li>
                  <li class="nav-item">
                      <a class="nav-link" href="GetUser?userId=<%= userx.getUserId()%>"><img class="userimg2" src="GetImage?imgId=<%= userx.getUserAvatar()%>"><%= userx.getUserName()%></a>
                  </li>
                  <% }%>

              </ul>
          </div>
      </div>
  </nav>
</body>
</html>
  <!-- Page Content -->
 
