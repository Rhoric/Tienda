<%-- 
    Document   : carrito
    Created on : 15/11/2019, 12:49:40 PM
    Author     : 66918
--%>

<%@page import="Utils.RequestUtils"%>
<%@page import="Models.Users"%>
<%@page import="Models.Products"%>
<%@page import="Models.Categories"%>
<%@page import="java.util.List"%>

<%
    int userLogged = 0;
    if(request.getSession().getAttribute("currentUser") == null){
        userLogged = 0;
    } else {
        userLogged = 1;
    }
    int cartExists = 0;
        if (request.getSession().getAttribute(RequestUtils.KEY_CART) == null) {
            cartExists = 0;
        } else {
            cartExists = 1;
        }
    List<Categories> categories = Categories.GetCategories();
    //List<Products> products = Products.GetProductListPublished("none", "none");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Espadotas el tripas</title>

  <link href="plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="css/homepage.css" rel="stylesheet">
  <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>-->
  <script src="plugins/jquery/jquery.min.js"></script>
  <!--<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>-->
  <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
</head>

<body>

  <!-- Navigation -->
    <%@ include file="template.jsp"%>


  <!-- Page Content -->
  <div class="container-fluid" id="doce">

    <div class="row">

      <div class="col-lg-3">

        <!--<h1 class="my-4">Departamentos</h1>-->
        <div class="list-group">
            <br><br>
            <% 
                for(Categories category : categories){
            %>
            <a href="GetProductListPublished?search=<%= category.getCategoryName()%>&filtering=Categoria" class="list-group-item"><%= category.getCategoryName() %></a>
            <% 
                }
            %>
            
        </div>

      </div>
      <!-- /.col-lg-3 -->

      <div class="col-lg-9">
    
          <div class="content-header">
              <h2>Carrito de compras</h2>
          </div>

            <div class="busqueda-articles" style="max-width: 500px;">
                <%
                    if (cartExists == 1) {
                %>
                
                <a href="PurchaseProducts" class="btn btn-lg btn-dark">COMPRAR</a>
                <hr>
                <div class="row"style="padding-left:10px;">
                <%
                    List<Products> products = (List<Products>) request.getSession().getAttribute(RequestUtils.KEY_CART);
                    for (Products product : products) {
                %>

  
                <!-- ---------------------------------------- -->
                    <div class="card mb-6 text-white" style="max-width: 410px; height: 200px;background-color:#03b1fc;">
                        <div class="row no-gutters">
                            <div class="col-md-4">
                                <img src="GetImage?imgId=<%= product.getProductImage()%>" class="card-img" alt="..." style="height:198px">
                            </div>
                            <div class="col-md-8  btn-outline-success">
                                <div class="card-body" >
                                    <h5 class="card-title"><%= product.getProductName()%></h5>
                                    <!--<p class="busqueda-article-user">admin</p>-->
                                    <p class="busqueda-article-rating">Cantidad: 1</p>
                                    <p class="card-text text-white"><a href="RemoveCartProduct?productId=<%= product.getProductId()%>" class="cart-remove text-white"><b>Remover</b></a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                <%
                    }
                    %>
                </div>
                    <%
                } else {
                %>
                <div class="content-header">
                    <p style="color: #e45430">no tienes articulos en el carrito</p>
                </div>
                <%
                    }
                %>

        </div>
        <!-- /.row -->

      </div>
      <!-- /.col-lg-9 -->
      <div class="col align-items-end">
          <% if (userLogged == 1) {
                  Users user = (Users) request.getSession().getAttribute("currentUser");
          %>
          <br>
          <a class="btn btn-sm btn-light btn-block signup-btn" href="LogoutUser">Salir</a>
          <%
              int role = user.getUserRole();
              if (role == 1) {
          %>
          <a href="addProduct.jsp" class="btn btn-sm btn-light btn-block signup-btn">Agregar Producto</a>
          <a href="GetProductList?search=none&filtering=none" class="btn btn-sm btn-light btn-block signup-btn">Lista de productos</a>

          <%
                  }
              }
          %>
      </div>
    </div>
    <!-- /.row -->

  </div>
  <!-- /.container -->

  <!-- Footer -->
  <footer class="py-5 bg-dark">
    <div class="container">
      <!--<p class="m-0 text-center text-white">Copyright &copy; Your Website 2019</p>-->
      
    </div>
    <!-- /.container -->
  </footer>

  <!-- Bootstrap core JavaScript -->

</body>

</html>
