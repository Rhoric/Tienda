<%-- 
    Document   : login
    Created on : 8/11/2019, 05:25:17 PM
    Author     : svazquez3
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
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Espadotas el tripas | Login</title>

  <!-- Bootstrap core CSS -->
  <link href="plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
  <!-- Custom styles for this template -->
  <link href="css/signin.css" rel="stylesheet">
  <link href="css/homepage.css" rel="stylesheet">
  <script src="plugins/jquery/jquery.min.js"></script>
  <!--<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>-->
  <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
  <script>
      $(document).ready(function(){
          $("#id-login-error").hide();
          $("#id-login-form").submit(function(e) {
                e.preventDefault(); // avoid to execute the actual submit of the form.
                
                var username = document.getElementById("id-login-usuario").value;
                var password = document.getElementById("id-login-contrasena").value;    
                //var warning = document.getElementById("id-login-warning");


                if(username !== "" && password !== ""){
                    
                    var form = $(this);
                    var url = form.attr('action');
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: form.serialize(),
                        success: function(data)
                        {
                            if(data == "logged"){
                                window.location.assign("index.jsp");
                            } else {
                                $("#id-login-error").show();
                            }
                        }
                    });
                    
                } else {
                    //warning.classList.remove("warning-inactive");
                    //warning.classList.add("warning-active");
                    alert("error");
                }
                
            });
      });
  </script>
</head>

<body>

  <!-- Navigation -->
  <%@ include file="template.jsp"%>

  <!-- Page Content -->
  <div class="container-fluid" id="doce">

    <div class="row">

      <div class="col-lg-3"><!--style= "background-color:#427bb4;"-->

        

      </div>
      <!-- /.col-lg-3 -->

      <div class="col-lg-9">
            <form method="post" class="form-signin text-center" id="id-login-form" action="LoginUser">
                    
                    <h1 class="h3 mb-3 font-weight-normal">Inicia sesión</h1>
                    <!--<label for="inputEmail" class="sr-only">UserName</label>-->
                    
                    <input type="text" name="login-username" id="id-login-usuario" class="form-control" placeholder="UserName" required autofocus>
                    <label for="inputPassword" class="sr-only">Password</label>
                    <input type="password" name="login-password" id="id-login-contrasena" class="form-control" placeholder="Password" required>
                    <input  class="btn btn-lg btn-info btn-block" type="submit" name="submit" value="Log In" id="id-login-enviar">
                    <p class="login-error" id="id-login-error">nombre de usuario o contraseña incorrecta</p>
                    <!--<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>-->
                    <a href="signup.jsp" class="m-0 text-center">Registrarse</a>
                    
                  </form>
        <hr>
      </div>
      
      <!-- /.col-lg-9 -->
      <div class="col align-items-end">
          <% if (userLogged == 1) {
                  Users user = (Users) request.getSession().getAttribute("currentUser");
          %>
          <br>
          <a class="nav-link" href="LogoutUser">Salir</a>
          <%
              int role = user.getUserRole();
              if (role == 1) {
          %>
          <a href="addProduct.jsp" class="nav-link">Agregar Producto</a>
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
      <br>
      <br>
      <br>
      <br>
      <br>
      <br>
      <br>
      <br>
      <br>
      
    </div>
    <!-- /.container -->
  </footer>
  <!-- Bootstrap core JavaScript -->
</body>
</html>
