<%-- 
    Document   : updateP
    Created on : 14/11/2019, 12:28:03 PM
    Author     : 66918
--%>

<%@page import="Utils.RequestUtils"%>
<%@page import="Models.Users"%>
<%@page import="Models.Products"%>
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
    List<Products> product = (List<Products>)request.getAttribute(RequestUtils.KEY_SINGLE_PRODUCT);
    List<Products> images = (List<Products>)request.getAttribute(RequestUtils.KEY_PRODUCT_IMAGES);
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
  <link href="css/signup.css" rel="stylesheet">
  <link href="css/signin.css" rel="stylesheet">
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
          
        <div class="row">
            
                <%
                    for (Products p : product) {
                        List<Categories> prodCat = Categories.GetProductCategories(p.getProductId());
                %>
                <form method="post" action="UpdateProduct?productId=<%= p.getProductId()%>&productVideoId=<%= p.getProductVideo()%>" enctype="multipart/form-data" id="id-product-form">
                    <h1>Actualizar producto</h1>
                    <div class="product-form">

                        <div class="row">
                            <p class="signup-labels">Nombre</p>
                            <input class="form-control input-lg" type="text" name="product-name" value="<%= p.getProductName()%>" required>
                        </div>
                        <div class="row">
                            <p class="signup-labels">Descripción</p>
                            <input class="form-control input-lg" type="text" name="product-description" value="<%= p.getProductDescription()%>" required>
                        </div>
                        <div class="row">
                            <p class="signup-labels">Unidades</p>
                            <input class="form-control input-lg" type="text" name="product-units" value="<%= p.getProductUnits()%>" required>
                        </div>
                        <div class="row">
                        <div class="product-categories">
                            <p class="signup-labels">CATEGORIAS</p>
                            <fieldset class="product-fieldset">
                                <%
                                    for (Categories category : categories) {
                                        int checkOption = 0;
                                        for (Categories pC : prodCat) {
                                            String cat = category.getCategoryName();
                                            String pcat = pC.getCategoryName();
                                            if (cat.contains(pcat)) {
                                                checkOption = 1;
                                            }
                                        }
                                        if (checkOption == 1) {
                                %>
                                <input type="checkbox" name="product-category" class="product-checkbox" value="<%= category.getCategoryName()%>" checked><%= category.getCategoryName()%>
                                <%
                                } else {
                                %>
                                <input type="checkbox" name="product-category" class="product-checkbox" value="<%= category.getCategoryName()%>"><%= category.getCategoryName()%>
                                <%
                                        }
                                        if(totalcat%3==0){
                                        %>
                                        <br>
                                        <%
                                            }
                                            totalcat++;
                                        }
                                    
                                %>
                            </fieldset>
                        </div>
                            <div class="product-categories">
                                <p class="signup-labels">STATUS</p>
                                <fieldset class="product-fieldset">
                                    <input type="radio" name="product-status" class="product-checkbox" value="1" checked>Publicar
                                    <input type="radio" name="product-status" class="product-checkbox" value="0">Borrador

                                </fieldset>
                            </div>
                        </div>
                            <br>

                        <%
                            for (int i = 0; i < 3; i++) {
                                int listSize = images.size();
                                if (i < listSize) {
                                    Products img = images.get(i);
                        %>
                        <div class="row articulo-images" style="width:80%">
                        <div class="articulo-images-image col">
                            <img src="GetImage?imgId=<%= img.getProductImage()%>">
                        </div>
                        <div class="product-img-div col">
                            <label for="product-img-<%=i + 1%>" class="signup-labels">Agregar imagen</label>
                            <input type="file" name="product-img" id="product-img-<%=i + 1%>" class="btn btn-sm btn-primary btn-block signup-btn">
                        </div>
                        </div>
                        <%
                        } else {
                        %>
                        <div class="product-img-div">
                            <label for="product-img-<%=i + 1%>" class="signup-labels">Agregar imagen</label>
                            <input type="file" name="product-img" id="product-img-<%=i + 1%>" class="btn btn-sm btn-primary btn-block signup-btn">
                        </div>
                        <%
                                }
                            }
                        %>
                        <div class="product-img-div">
                            <label for="product-video" class="signup-labels">Cambiar video</label>
                            <input type="file" name="product-video" id="product-video" class="btn btn-sm btn-primary btn-block signup-btn" style="width:25rem;"><br>
                        </div>
                        <div class="product-enviar">
                            <input type="submit" class="btn btn-sm btn-primary btn-block signup-btn" value="Actualizar Producto" name="product-submit" id="id-product-enviar">
                            <!--<button id="id-signup-enviar" onclick="validateForm()">agregar producto</button>-->
                        </div><br>
                        <!--<p onclick="validateForm()">probar</p>-->
                        <a href="DeleteProduct?productId=<%= p.getProductId()%>" class="btn btn-sm btn-primary btn-block signup-btn">Eliminar Producto</a>

                    </div>

                </form>
                <%
                    }
                %>

        </div>
        <!-- /.row -->

      </div>
      <!-- /.col-lg-9 -->
      <div class="col align-items-end" style="  background-image: linear-gradient(to bottom, #03b1fc, #035e82);">
          <% if (userLogged == 1) {
                  Users user = (Users) request.getSession().getAttribute("currentUser");
          %>
         <br>
          <a class="btn btn-sm btn-primary btn-block signup-btn" href="LogoutUser">Salir</a>
          <%
              int role = user.getUserRole();
              if (role == 1) {
          %>
          <a href="addProduct.jsp" class="btn btn-sm btn-primary btn-block signup-btn">Agregar Producto</a>
          <a href="GetProductList?search=none&filtering=none" class="btn btn-sm btn-primary btn-block signup-btn">Lista de productos</a>

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
