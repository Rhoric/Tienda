<%-- 
    Document   : addProduct
    Created on : 11/11/2019, 12:54:58 PM
    Author     : 66918
--%>
<%@page import="javax.naming.Context"%>
<%@page import="Utils.RequestUtils"%>
<%@page import="Models.Users"%>
<%@page import="Models.Categories"%>
<%@page import="java.util.List"%>
<%
    int totalcat=1;
    int userLogged = 0;
    if(request.getSession().getAttribute("currentUser") == null){
        userLogged = 0;
    } else {
        userLogged = 1;
    }
    
    List<Categories> categories = Categories.GetCategories();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>

  <title>Espadotas el tripas</title>

  <!-- Bootstrap core CSS -->
  <link href="plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/signup.css" rel="stylesheet">
  <link href="css/signin.css" rel="stylesheet">
  <link href="css/homepage.css" rel="stylesheet">
  <script src="plugins/jquery/jquery.min.js"></script>
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
            <a href="GetProductListPublished?search=<%= category.getCategoryName()%>&filtering=Categoria" class="list-group-item"><%= category.getCategoryName()%></a>
            <% 
                }
            %>
            
        </div>

      </div>
      <!-- /.col-lg-3 -->

      <div class="col-lg-9" id="columna">

        <div class="form-signin" style="margin:2rem;">
            <form method="post" action="AddProduct" enctype="multipart/form-data" id="id-product-form" class="form-signin">

                    <div class="row">
                        <p class="signup-labels">Nombre</p>
                        <input class="form-control input-lg" type="text" name="product-name" placeholder="ingresa el nombre del producto" required>
                    </div>
                    <div class="row">
                        <p class="signup-labels">Descripción</p>
                        <input class="form-control input-lg" type="text" name="product-description" placeholder="agrega una descripción" required>
                    </div>
                    <div class="row">
                        <p class="signup-labels">Unidades</p>
                        <input class="form-control input-lg" type="text" name="product-units" required>
                    </div>
                    <div class="row product-categories">
                        <p class="signup-labels">CATEGORIAS</p>
                        <fieldset class="product-fieldset">
                            <%
                                for(Categories category : categories){
                                    
                            %>
                            <input type="checkbox" name="product-category" style=" margin-left: 35px;" class="product-checkbox" value="<%= category.getCategoryName()%>"><%= category.getCategoryName()%>
                            <%
                                if(totalcat%3==0){
                                    %>
                                    <br>
                            <% }
                                totalcat++;
                                }
                            %>
                        </fieldset>
                    </div><br><br>
                    <div class="row product-img-div">
                        <label for="product-video" class="signup-labels">agregar video</label>
                        <input type="file" name="product-video" id="product-video" class="btn btn-sm btn-info btn-block signup-btn">
                    </div><br>
                    <div class="row product-img-div">
                        <label for="product-img-1" class="signup-labels">agregar imagen</label>
                        <input type="file" name="product-img" id="product-img-1" class="btn btn-sm btn-info btn-block signup-btn" required>
                    </div><br>
                    <div class="row product-img-div">
                        <label for="product-img-2" class="signup-labels">agregar imagen</label>
                        <input type="file" name="product-img" id="product-img-2" class="btn btn-sm btn-info btn-block signup-btn">
                    </div><br>
                    <div class="row product-img-div">
                        <label for="product-img-3" class="signup-labels">agregar imagen</label>
                        <input type="file" name="product-img" id="product-img-3" class="btn btn-sm btn-info btn-block signup-btn">
                    </div><br>
                    <div class="product-enviar">
                        <input type="submit" value="Agregar producto" name="product-submit" id="id-product-enviar" class="btn btn-outline-dark">
                        <!--<button id="id-signup-enviar" onclick="validateForm()">agregar producto</button>-->
                    </div>
                    <!--<p onclick="validateForm()">probar</p>-->
            </form>
                </div>


        

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
    </div>
    <!-- /.container -->
  </footer>
</body>

</html>
