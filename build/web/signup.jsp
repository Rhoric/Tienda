<%-- 
    Document   : signup
    Created on : 8/11/2019, 01:34:45 PM
    Author     : svazquez3
--%>
<%@page import="Utils.RequestUtils"%>
<%@page import="Models.Users"%>
<%@page import="Models.Products"%>
<%@page import="Models.Categories"%>
<%@page import="java.util.List"%>
<%@page import="javax.naming.Context"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    int userLogged = 0;
    if(request.getSession().getAttribute("currentUser") == null){
        userLogged = 0;
    } else {
        userLogged = 1;
    }
    
    List<Categories> categories = Categories.GetCategories();
    //List<Products> products = Products.GetProductList("none", "none");
%>


<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Espadotas el tripas</title>

  <!-- Bootstrap core CSS -->
  <link href="plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  
  <link href="css/signup.css" rel="stylesheet">
  <link href="css/homepage.css" rel="stylesheet">
  <script src="plugins/jquery/jquery-3.3.1.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.0/js/bootstrap.min.js" integrity="sha384-7aThvCh9TypR7fIc2HV4O/nFMVCBwyIUKL8XCtKE+8xgCgl/PQGuFsvShjr74PBp" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="plugins/jquery/jquery.min.js"></script>
  <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
  <script>
		$(document).ready(function(){
      // S I G N   U P   S T U F F //
        $('#confirma').hide();
      var x = false;
        var y = false;
        var z = false;
        var w= false;
        
        var valid = false;
        
        $('#formUser').submit(function() {
            validateForm();
            
            if(valid == true){
                return true;
            } else {
                return false;
                alert("llene los campos correspondientes");
            }
        });

        function validateForm(){
            
            var nombre = $("#id-signup-nombre").val();
            var apellido = $("#id-signup-apellido").val();
            var avatar = $("#id-signup-imagen").val();

            x = false;
            y = false;
            z = false;
            w = false;
            
            validateUsername();
            validateEmail();
            validatePassword();
            validateConfirm();
            //alert("listen");
            /*alert(x);
            alert(y);
            alert(z);*/
            
            if(x && y && z && w){
                if(nombre !== "" && apellido !== "" && avatar !== ""){
                    valid = true;
                } else {
                    valid = false;
                    //alert("llene los campos correspondientes");
                }
            }

        }

        function validateEmail(){
            var warnings = $(".signup-warning");
            var email = $("#id-signup-correo").val();
            var validation = /^(.+){1,}@[\w\.\-_]{2,}[.][\w]{2,}/;

            if(email.match(validation)){
                warnings[1].style.color = "#5bc830";
                warnings[1].style.fontWeight = "800";
                warnings[1].style.fontSize = "13px";

                x = true;
            } else {
                warnings[1].style.color = "#e45430";
                warnings[1].style.fontWeight = "800";
                warnings[1].style.fontSize = "13px";

                x = false;
            }

        }

        function validateUsername(){

            var warnings = $(".signup-warning");
            var username = $("#id-signup-usuario").val();
            var validation = /^(?=.{6,})/;
            if(username.match(validation)){
                warnings[0].style.color = "#5bc830";
                warnings[0].style.fontWeight = "800";
                warnings[0].style.fontSize = "13px";

                y = true;
            } else {
                warnings[0].style.color = "#e45430";
                warnings[0].style.fontWeight = "800";
                warnings[0].style.fontSize = "13px";

                y = false;
            }

        }

        function validatePassword(){
            
            var warnings = $(".signup-warning");
            var password = $("#id-signup-contrasena").val();
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
        function validateConfirm(){
          var warnings= $(".signup-warning");
          var confirm = $("#id-signup-confirma").val();
          var password = $("#id-signup-contrasena").val();
          if(confirm==password){
                warnings[3].style.color = "#5bc830";
                warnings[3].style.fontWeight = "800";
                warnings[3].style.fontSize = "13px";

                w = true;
          } else {
                warnings[3].style.color = "#e45430";
                warnings[3].style.fontWeight = "800";
                warnings[3].style.fontSize = "13px";
                $('#confirma').show();
                w = false;
          }
        }
		});
  </script>
</head>

<body>

  <!-- Navigation -->
  <%@ include file="template.jsp"%>

  <!-- Page Content -->
  <div class="container-fluid" id="doce">

    <div class="row">

      <div class="col-lg-3">

       
        <div class="list-group">
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
          <div class="form-signin">
            <div class="col-md-6 col-md-offset-3">
              <form  id ="id-signup-form" action = "AddUserCustomer" method="post" enctype="multipart/form-data" class="form-signin" role="form">   <legend>Registrate!</legend>
                  <br>
                <div class="form-group">
                  <p class="signup-labels">Nombre de usuario*</p>
                  <input type="text"  name="signup-user" id="id-signup-usuario" value="" class="form-control input-lg" placeholder="Nombre de usuario"/>
                  <p class="signup-warning">mínimo 6 carácteres</p>  
                </div>
                
                <div class="row">
                    <div class="col-xs-6 col-md-6">
                      <p class="signup-labels">Nombre(s)*</p>
                      <input type="text" name="signup-name" id="id-signup-nombre" value="" class="form-control input-lg" placeholder="Nombre(s)" required/> 
                    </div>
                    <div class="col-xs-6 col-md-6">
                      <p class="signup-labels">Apellido(s)*</p>
                      <input type="text" name="signup-lastname" id="id-signup-apellido" value="" class="form-control input-lg" placeholder="Apellido(s)" required/> 
                    </div>
                  </div>
                  <div class="form-group">
                      <p class="signup-labels">Correo*</p>
                      <input type="email" name="signup-email" id= "id-signup-correo"value="" class="form-control input-lg" placeholder="Correo electrónico" required/>
                      <p class= "signup-warning">Ingresa un correo único por cuenta</p>
                   </div>
                  <div class="form-group">
                      <p class="signup-labels">Contraseña*</p>
                      <input type="password" name="signup-password" id= "id-signup-contrasena" value="" class="form-control input-lg" placeholder="Password" required/>
                      <p class="signup-warning">Mínimo 8 carácteres, una mayúscula, una minúscula y un número</p>    
                  </div>
                  <div class="form-group">
                    <p class="signup-labels">Confirme contraseña:</p>
                      <input type="password"  id="id-signup-confirma" name="confirm_password" value="" class="form-control input-lg" placeholder="Confirm Password" required/> 
                      <p class="signup-warning" id="confirma">No coincide con la anterior</p>
                  </div>
                  
                    <div class="form-group">
                      <div class="input-group mb-3">
                        <p class="signup-labels">Telefono</p>
                        <input type="text" class="form-control" name="signup-phone" id="id-signup-telefono"placeholder="Telefono" aria-label="Username" aria-describedby="basic-addon1">
                      </div>
                    </div>
                  
                  <div class="form-group">
                    <div class="input-group mb-3">
                      <p class="signup-labels">Dirección</p>
                      <input type="text" class="form-control" name="signup-address" id="id-signup-direccion" placeholder="Direccion" aria-label="Username" aria-describedby="basic-addon1">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="input-group mb-3">
                      <p class="signup-labels">Foto de perfil*</p>
                      <label for="id-signup-imagen" class="signup-labels signup-label-imagen"></label>
                      <input type="file" class="form-control" name="signup-avatar" id="id-signup-imagen"  placeholder="Avatar" aria-label="Username" aria-describedby="basic-addon1" required>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-xs-4 col-md-4">
                          
                    </div>
                  </div>
                                   
                  <br>
                  <span class="help-block">Tus datos personales son importantes para nosotros, por eso no los usamos.</span>
                    <input type="submit" class="btn btn-lg btn-primary btn-block signup-btn" value = "Crear Cuenta" name = "signup-submit"  id="id-signup-enviar">
               
                </form>  
              </div>        
                          <br><br><br>
              </div>
          
          </div>
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
      </div>
      <!-- /.col-lg-9 -->

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
