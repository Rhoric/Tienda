<%-- 
    Document   : history
    Created on : 15/11/2019, 02:44:32 PM
    Author     : 66918
--%>

<%@page import="Utils.RequestUtils"%>
<%@page import="Models.Users"%>
<%@page import="Models.Products"%>
<%@page import="Models.Purchases"%>
<%@page import="Models.Categories"%>
<%@page import="java.util.List"%>

<%
    int userLogged = 0;
    if(request.getSession().getAttribute("currentUser") == null){
        userLogged = 0;
    } else {
        userLogged = 1;
    }
    
    List<Purchases> purchases = (List<Purchases>)request.getAttribute(RequestUtils.KEY_ALL_PURCHASES);
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
              <h1>historial de compras</h1><br><br>
              <div></div>
          </div>
            <div class="row">

                <div class="col">
                    <table class="table table-dark table-bordered">
                        <thead>
                            <tr> 
                                <th scope="col">Fecha compra</th>
                                <th scope="col">Usuario</th>
                                <th scope="col">Status</th>
                            </tr>
                        </thead>
                        <tbody>

                    <%
                        Users cUser = (Users) request.getSession().getAttribute("currentUser");
                        int role = cUser.getUserRole();
                        if (role == 1) { 
                            List<Purchases> purchs = Purchases.GetAllPurchases();
                            for (Purchases purch : purchs) {
                                int status = purch.getPurchaseStatus();
                    %>

                            <tr>
                            <%
                                if (status == 0) {
                            %>
                            <td>
                            <a href="GetChat?purchaseId=<%= purch.getPurchaseId()%>" class="busqueda-article-nombre"><%= purch.getPurchaseDate()%></a>
                            </td>
                            <%
                            } else {
                            %>
                            <td>
                            <a href="GetPurchase?purchaseId=<%= purch.getPurchaseId()%>" class="busqueda-article-nombre"><%= purch.getPurchaseDate()%></a>
                            </td>
                            <%
                                }
                            %>
                            <td>
                            <p class="busqueda-article-user"><%= purch.getPurchaseUserName()%></p>
                            </td>
                            <%
                                if (status == 0) {
                            %>
                            <td>
                                <p class="busqueda-article-user" style="color: #e45430;"><b>Pendiente</b></p>
                            </td>
                            <%
                            } else {
                            %>
                            <td style="color: #5bc830;">
                            <label class="signup-labels" style="color:white;">$<%= purch.getPurchaseTotal()%></label>
                            <b> ---Realizada---</b>
                            </td>
                            <%
                                }
                            %>
                            </tr>

                    <%
                        }
                    } else {
                        for (Purchases purchase : purchases) {
                            int status = purchase.getPurchaseStatus();
                    %>

                            <tr>
                            <%
                                if (status == 0) {
                            %>
                            <td>
                            <a href="GetChat?purchaseId=<%= purchase.getPurchaseId()%>" class="busqueda-article-nombre"><%= purchase.getPurchaseDate()%></a>
                            </td>
                            <%
                            } else {
                            %>
                            <td>
                            <a href="GetPurchase?purchaseId=<%= purchase.getPurchaseId()%>" class="busqueda-article-nombre"><%= purchase.getPurchaseDate()%></a>
                            </td>
                            <%
                                }
                            %>
                            <td>
                            <p class="busqueda-article-user">admin</p>
                            </td>
                            <%
                                if (status == 0) {
                            %>
                            <td>
                                <p class="busqueda-article-user" style="color: #e45430;"><b>Pendiente</b></p>
                            </td>
                            <%
                            } else {
                            %>
                            <td style="color: #5bc830;">
                                <b>Realizada</b>
                            </td>
                            <%
                                }
                            %>
                            </tr>

                    <%
                            }
                        }
                    %>
                </tbody>
                </table>
                </div>


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
              int rol = user.getUserRole();
              if (rol == 1) {
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
