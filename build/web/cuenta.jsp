<%-- 
    Document   : cuenta
    Created on : 8/11/2019, 01:35:01 PM
    Author     : 66918
--%>
<%@page import="Utils.RequestUtils"%>
<%@page import="Models.Users"%>
<%@page import="Models.Products"%>
<%@page import="Models.Categories"%>
<%@page import="java.util.List"%>
<%@page import="javax.naming.Context"%>

<%
    int userLogged = 0;
    if (request.getSession().getAttribute("currentUser") == null) {
        userLogged = 0;
    } else {
        userLogged = 1;
    }

    List<Categories> categories = Categories.GetCategories();
    List<Users> user = (List<Users>)request.getAttribute(RequestUtils.KEY_SINGLE_USER);
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
<link href="css/signup.css" rel="stylesheet">
  <link href="plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
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
                  for (Categories category : categories) {
              %>
              <a href="GetProductListPublished?search=<%= category.getCategoryName()%>&filtering=Categoria" class="list-group-item"><%= category.getCategoryName()%></a>
              <%
                  }
              %>

          </div>

      </div>
      <!-- /.col-lg-3 -->

      <div class="col-lg-9">
        
          <%
              for (Users u : user) {
          %>
          <form method="post" action="UpdateUser?userId=<%= u.getUserId()%>&userAvatarId=<%= u.getUserAvatar()%>" enctype="multipart/form-data" id="id-update-form">

              <div class="signup-form">

                  <div class="form-group">
                      <p class="signup-labels">nombre(s) *</p>
                      <input class="form-control input-lg" type="text" name="update-name" id="id-signup-nombre" value="<%= u.getUserFirstName()%>" required>
                  </div>
                  <div class="signup-apellido signup-div">
                      <p class="signup-labels">apellido(s) *</p>
                      <input class="form-control input-lg" type="text" name="update-lastname" id="id-signup-apellido" value="<%= u.getUserLastName()%>" required>
                  </div>
                  <div class="signup-correo signup-div">
                      <p class="signup-labels">correo electrónico *</p>
                      <input class="form-control input-lg" type="email" name="update-email" id="id-signup-correo" value="<%= u.getUserEmail()%>" required>
                      <p class="signup-warning">ingresa un solo correo electrónico por cuenta</p>
                  </div>
                  <div class="signup-usuario signup-div">
                      <p class="signup-labels">nombre de usuario *</p>
                      <input class="form-control input-lg" type="text" name="update-user" id="id-signup-usuario" value="<%= u.getUserName()%>" required>
                      <p class="signup-warning">mínimo 6 carácteres</p>
                  </div>
                  <div class="row">
                      <div class="col-xs-6 col-md-6">
                      <p class="signup-labels">contraseña *</p>
                      <input class="form-control input-lg" type="password" name="update-password" id="id-signup-contrasena" value="<%= u.getUserPassword()%>" required>
                      <p class="signup-warning">mínimo 8 carácteres, una mayúscula, una minúscula y un número</p>
                      </div>
                  <div class="col-xs-6 col-md-6">
                      <p class="signup-labels">número de teléfono (opcional)</p>
                      <input class="form-control input-lg" type="number" name="update-phone" id="id-signup-telefono" value="<%= u.getUserTelephone()%>">
                  </div>
                  <div class="col-xs-6 col-md-6">
                      <p class="signup-labels">domicilio (opcional)</p>
                      <input class="form-control input-lg" type="text" name="update-address" id="id-signup-direccion" value="<%= u.getUserAddress()%>">
                  </div>
                  <div class="col-lg-6 col-lg-6">
                  <div class="articulo-article-image">
                      <img id="article-main-image" src="GetImage?imgId=<%= u.getUserAvatar()%>">
                      <!--<img src="GetImage?imgId=<%= u.getUserAvatar()%>">-->
                  </div>
                  <div class="signup-imagen signup-div">
                      <label for="id-signup-imagen" class="signup-labels signup-label-imagen">imagen de avatar</label>
                      <input type="file" class="btn btn-sm btn-primary btn-block signup-btn" name="update-avatar" id="id-signup-imagen">
                  </div>
                  </div>
                  </div>
                  <div class="align-items-center">
                      <p class="signup-warning">todos los elementos marcados con "*" son requeridos</p><br>
                      <input class="btn btn-sm btn-primary btn-block signup-btn" type="submit" value="actualizar" name="update-submit" id="id-signup-enviar">
                      <!--<button id="id-signup-enviar" onclick="validateForm()">crear cuenta</button>-->
                  </div>
                  <!--<p onclick="validateForm()">probar</p>-->
                  <a href="DeleteUser?userId=<%= u.getUserId()%>" class="product-delete">Eliminar Cuenta</a>

              </div>

          </form>
          <%
              }
          %>

      </div>
      <!-- /.col-lg-9 -->
      <div class="col align-items-end">
          <% if (userLogged == 1) {
                  Users user1 = (Users) request.getSession().getAttribute("currentUser");
          %>
          <br>
          <a class="btn btn-sm btn-light btn-block signup-btn" href="LogoutUser">Salir</a>
          <%
              int role = user1.getUserRole();
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
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script>
         // S I G N   U P   S T U F F //
        
         var x = false;
         var y = false;
         var z = false;
        
         var valid = false;
        
         $('#id-update-form').submit(function() {
             validateForm();
             if(valid == true){
                 return true;
             } else {
                 return false;
                 alert("llene los campos correspondientes");
             }
         });

         function validateForm(){

             var nombre = document.getElementById("id-signup-nombre").value;
             var apellido = document.getElementById("id-signup-apellido").value;
             var avatar = document.getElementById("id-signup-imagen").value;

             x = false;
             y = false;
             z = false;

             validateEmail();
             validateUsername();
             validatePassword();
            
             /*alert(x);
             alert(y);
             alert(z);*/
            
             if(x && y && z){
                 if(nombre !== "" && apellido !== ""){
                     valid = true;
                 } else {
                     valid = false;
                     //alert("llene los campos correspondientes");
                 }
             }

         }

         function validateEmail(){

             var warnings = document.getElementsByClassName("signup-warning");
             var email = document.getElementById("id-signup-correo").value;
             var validation = /^(.+){1,}@[\w\.\-_]{2,}[.][\w]{2,}/;

             if(email.match(validation)){
                 warnings[0].style.color = "#5bc830";
                 warnings[0].style.fontWeight = "800";
                 warnings[0].style.fontSize = "13px";

                 x = true;
             } else {
                 warnings[0].style.color = "#e45430";
                 warnings[0].style.fontWeight = "800";
                 warnings[0].style.fontSize = "13px";

                 x = false;
             }

         }

         function validateUsername(){

             var warnings = document.getElementsByClassName("signup-warning");
             var username = document.getElementById("id-signup-usuario").value;
             var validation = /^(?=.{6,})/;

             if(username.match(validation)){
                 warnings[1].style.color = "#5bc830";
                 warnings[1].style.fontWeight = "800";
                 warnings[1].style.fontSize = "13px";

                 y = true;
             } else {
                 warnings[1].style.color = "#e45430";
                 warnings[1].style.fontWeight = "800";
                 warnings[1].style.fontSize = "13px";

                 y = false;
             }

         }

         function validatePassword(){

             var warnings = document.getElementsByClassName("signup-warning");
             var password = document.getElementById("id-signup-contrasena").value;
             var validation = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,})/;

             if(password.match(validation)){
                 warnings[2].style.color = "#5bc830";
                 warnings[2].style.fontWeight = "800";
                 warnings[2].style.fontSize = "13px";

                 z = true;
             } else {
                 warnings[2].style.color = "#e45430";
                 warnings[2].style.fontWeight = "800";
                 warnings[2].style.fontSize = "13px";

                 z = false;
             }

         }
  </script>
  
</body>

</html>
