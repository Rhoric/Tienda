
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
    
    List<Categories> categories = Categories.GetCategories();
    List<Products> products = Products.GetProductListPublished("none", "none");
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
            <br>
            <br>
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
          
        <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
          <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
          </ol>
          <div class="carousel-inner" role="listbox">
            <div class="carousel-item active">
              <img class="d-block img-fluid" src="resources/knight.jpg" alt="First slide">
              <div class="carousel-caption d-none d-md-block">
                  <h5>El mejor ataque es una buena defensa</h5>
                  <p>Descubre nuestras armaduras!</p>
              </div>
            </div>
            <div class="carousel-item">
              <img class="d-block img-fluid" src="resources/Joust.jpg" alt="Second slide">
              <div class="carousel-caption d-none d-md-block">
                  <h5>Lo mejor para el caballero moderno</h5>
                  <p>Y el no tan moderno</p>
              </div>
            </div>
            <div class="carousel-item">
              <img class="d-block img-fluid" src="resources/archer.jpg" alt="Third slide">
              <div class="carousel-caption d-none d-md-block">
                  <h5>Sin ganas de recibir golpes?</h5>
                  <p>Checa nuestras armas a distancia</p>
              </div>
            </div>
          </div>
          <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Anterior</span>
          </a>
          <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Siguiente</span>
          </a>
        </div>

        <div class="row">
            <%
                for (Products product : products) {
                        List<Categories> prodCat = Categories.GetProductCategories(product.getProductId());

            %>
          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
              <a href="ShowProduct?pId=<%=product.getProductId()%>">
                  <img class="card-img-top" style="width:249px; height:249px;" src="GetImage?imgId=<%= product.getProductImage()%>" alt="">
              </a>
              <div class="card-body" style="background-color:#03b1fc; color:white;">
                <h4 class="card-title">
                  <a style="color:white;" href="ShowProduct?pId=<%=product.getProductId()%>"><%= product.getProductName()%></a>
                </h4>
                  <%
                      for (Categories category : prodCat) {
                  %>
                  <small name="productCategory"><a href="GetProductListPublished?search=<%= category.getCategoryName()%>&filtering=Categoria" style="color:white"><b><%= category.getCategoryName()%>  </b></a></small>
                  <% } %> <br>
                
                <p class="card-text"><%= product.getProductDescription()%></p>
              </div>
              <div class="card-footer">
                  <small class="text-muted"><b>Rating:</b> &#9733; &#9733; &#9733; &#9733; &#9734;</small>
              </div>
            </div>
          </div>
          <% 
              }
          %>


        </div>
        <!-- /.row -->

      </div>
      <!-- /.col-lg-9 -->
      <div class="col align-items-end">
          <br><h1>
          <% if (userLogged == 1) {
                  Users user = (Users) request.getSession().getAttribute("currentUser");
          %>
          </h1>
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
