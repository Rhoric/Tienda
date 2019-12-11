<%-- 
    Document   : item
    Created on : 8/11/2019, 01:34:23 PM
    Author     : 66918
--%>
<%@page import="Utils.RequestUtils"%>
<%@page import="Models.Users"%>
<%@page import="Models.Products"%>
<%@page import="Models.Ratings"%>
<%@page import="Models.Categories"%>
<%@page import="Models.Purchases"%>
<%@page import="java.util.List"%>

<%
    int userLogged = 0;
    if(request.getSession().getAttribute("currentUser") == null){
        userLogged = 0;
    } else {
        userLogged = 1;
    }
    int boolPurc=0;
    List<Categories> categories = Categories.GetCategories();
    List<Products> product = (List<Products>)request.getAttribute(RequestUtils.KEY_SINGLE_PRODUCT);
    List<Products> images = (List<Products>)request.getAttribute(RequestUtils.KEY_PRODUCT_IMAGES);
    List<Ratings> rating = (List<Ratings>)request.getAttribute(RequestUtils.KEY_PRODUCT_RATINGS);
    List<Purchases> pBool = (List<Purchases>)request.getAttribute(RequestUtils.KEY_PRODUCT_BOOL);
       if(pBool.isEmpty()){
            boolPurc=1;
       } else{
           boolPurc=2;
       }
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
  <!-- link href="css/stars.css" rel="stylesheet" -->
  <style>
      <%@ include file="css/stars.css"%></</style>
  <script src="plugins/jquery/jquery.min.js"></script>
  <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
</head>

<body>
    <%@ include file="template.jsp"%>


  <!-- Page Content -->
  <div class="container-fluid flex-row" id="doce">
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

      <div class="col-lg-9">
          <div class="row">
          <div class="articulo-images">
              <%
                  for (int i = 0; i < 3; i++) {
                      int listSize = images.size();
                      if (i < listSize) {
                          Products img = images.get(i);
              %>
              <div class="articulo-images-image">
                  <img onclick="showMainImage(this)" src="GetImage?imgId=<%= img.getProductImage()%>">
              </div>
              <%
              } else {
              %>
              <div class="articulo-images-image">
                  <img src="images/placeholder.jpg">
              </div>
              <%
                      }
                  }
              %>
          </div>
          <% Products img = images.get(0);%>
          <div class="articulo-article-image">
              <img id="article-main-image" src="GetImage?imgId=<%= img.getProductImage()%>">
          </div>
          <!-- --------------- -->
          <%
              for (Products p : product) {
                  List<Categories> prodCat = Categories.GetProductCategories(p.getProductId());
                  List<Ratings> rating2 = Ratings.GetRatingAVG(p.getProductId());
          %>
          <div class="card redMainSPD" style="width: 30%;">
         
            <div class="card-body">
              <h3 class="card-title"><%= p.getProductName()%></h3>
              <h5>Cantidad disponible: <%= p.getProductUnits()%></h5>
              <p class="card-text"><%= p.getProductDescription()%></p>
              <b> Categorias: </b><br>
              <%
                  for (Categories category : prodCat) {
              %>
              <small name="productCategory"><a href="GetProductListPublished?search=<%= category.getCategoryName()%>&filtering=Categoria" style="color:white"><b><%= category.getCategoryName()%>  </b></a></small>
              <%  
                  }
                  for (Ratings ratingshed : rating2){ %>
                  <br><span class="text-warning">
    <%
                        for (int i = 0; i < 5; i++) {
                            if ((ratingshed.getRateProm()) > i) {
                                %>
                                &#9733;
                                <%
                        }else{
                        %>
                               &#9734; 
                                <%    
}
                        }
                        %>
                  </span><br>
                  <%= ratingshed.getRateProm() %> Estrellas
                    <%
                    }
              %>
              <br>

              
            </div>
              <% if(userLogged==1) {%>
              <a href="AddCart?productId=<%= p.getProductId()%>" class="btn btn-outline-success">Agregar al carrito</a>
              <% } else{ %>
              <a href="login.jsp" class="btn btn-outline-success">Agregar al carrito</a>
              <% } %>
              <%
                  if (userLogged == 1) {
                      Users user = (Users) request.getSession().getAttribute("currentUser");
                      int role = user.getUserRole();
                      if (role == 1) {
              %>  
       
                  <a href="GetProduct?productId=<%= p.getProductId()%>" class="btn btn-outline-success">MODIFICAR</a>
 
              <%
                      }
                  }
              %>
          </div>
     
              <!-- 16:9 aspect ratio -->
              <div class="align-items-center" style="width:100%;">
              <video class="video-fluid col-lg-9" autoplay controls loop>
                  <source src="GetVideo?vidId=<%= p.getProductVideo()%>" type="video/mp4" />
              </video>
              </div>
                <%
                    }
                %>
          </div>
          <div class="card card-outline-secondary my-4">
              <div class="card-header"style="background-color:#03b1fc;">
                  <h3>Calificaciones</h3>
              </div>
          <!-- /.card -->
          <% 
            for(Ratings r : rating){
                %>
                    <div class="card-body">
                        <p class="text-dark"><%= r.getRateCom() %></p>
                        <small class="text-muted">Publicado por <%= r.getUserName() %></small><br>
                        <small class="text-muted">Publicado el <%= r.getRateDate() %></small>
                        <hr>
                        <span class="text-warning">
                <% 
                    if(r.getRateStar()<1){
                %>
                <p class="text-dark"> No tiene puntaje</p>
                <%
                    }else{
                    for(int i=0;i< 5;i++){
                    if((r.getRateStar())>i){
                %>
                &#9733;
                <%
                    }else{ 
                %>
                &#9734;
                <%                    
                    }
                    }
                }
                %>
                        </span>
                    </div>
                <%
            }
          %>
          
                </div>
          <%
              if(userLogged==1){
                  Users userf = (Users) request.getSession().getAttribute("currentUser");
                  for (Products p : product){
                      if(!pBool.isEmpty()){
          %>
          <div class="align-content-center">
              <form method="post" action="AddRating?productId=<%=p.getProductId()%>&useractual=<%= userf.getUserId()%>">
                                    <input type="text" name="namecomentario" class="form-control input-lg" style="height: 150px; width: 400px;">
                  <p class="clasificacion">
                  <input id="radio1" type="radio" name="estrellas" value="5" checked><!--
                  --><label for="radio1">★</label><!--
                  --><input id="radio2" type="radio" name="estrellas" value="4"><!--
                  --><label for="radio2">★</label><!--
                  --><input id="radio3" type="radio" name="estrellas" value="3"><!--
                  --><label for="radio3">★</label><!--
                  --><input id="radio4" type="radio" name="estrellas" value="2"><!--
                  --><label for="radio4">★</label><!--
                  --><input id="radio5" type="radio" name="estrellas" value="1"><!--
                  --><label for="radio5">★</label>
              </p>
                  <input type="submit" class="btn btn-success" value="Deja tu comentario">
              </form>
          </div>
          <%
              }
              }
              }
          %>
          
          <!-- /.card -->

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

  <!-- Bootstrap core JavaScript -->
  <script>
            
      function showMainImage(image){
                
          imgSrc = image.getAttribute('src');
          mainImg = document.getElementById("article-main-image");
          mainImg.setAttribute('src', imgSrc);
                
      }
            
  </script>
</body>

</html>
