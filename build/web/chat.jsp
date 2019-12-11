<%-- 
    Document   : chat
    Created on : 15/11/2019, 04:57:51 PM
    Author     : 66918
--%>

<%@page import="Utils.RequestUtils"%>
<%@page import="Models.Users"%>
<%@page import="Models.Chats"%>
<%@page import="Models.Messages"%>
<%@page import="Models.Purchases"%>
<%@page import="Models.Products"%>
<%@page import="Models.Categories"%>
<%@page import="java.util.List"%>

<%
    int userLogged = 0;
    if (request.getSession().getAttribute("currentUser") == null) {
        userLogged = 0;
    } else {
        userLogged = 1;
    }
    
    Users user = (Users) request.getSession().getAttribute("currentUser");

    Chats chat = (Chats) request.getAttribute(RequestUtils.KEY_SINGLE_CHAT);
    int chatId = chat.getChatId();

    List<Messages> messages = Messages.GetMessagesList(chatId);
    int messageList = messages.size();
    
    List<Categories> categories = Categories.GetCategories();
    List<Products> products = (List<Products>) request.getAttribute(RequestUtils.KEY_ALL_PRODUCTS); 
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
        <style>
            <%@ include file="css/homepage.css"%>
        </style>
        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>-->
        <script src="plugins/jquery/jquery.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <!--<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>-->
        <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
        <script>
    $(document).ready(function(){
        //var message_input = document.getElementById("id-chat-input");
        //var chat = document.getElementById("id-chat-messages");

        $("#id-chat-form").submit(function(e) {
            e.preventDefault(); // avoid to execute the actual submit of the form.
            var form = $(this);
            var url = form.attr('action');
            $.ajax({
                type: "POST",
                url: url,
                data: form.serialize(),
                success: function(data)
                {
                    /*$("#chatContainer").append(data);
                    $("input[name=message]").val("");*/
                    //var message_input.value = "";
                    $("#id-chat-input").val("");
                    alert(data);
                }
            });


        });
        setInterval(function() {
            //var msg = "Other Message";
            var url = "GetMessage?chatId=<%= chat.getChatId()%>";
            $.ajax({
                type: "GET",
                url: url,
                success: function(data)
                {
                    //$("#chatContainer").append(data);
                    $("#id-chat-messages").append(data);
                    //chat.appendChild(data);
                    scrollChat();
                            
                }
            });
            /*var chat_div = $("#id-chat-messages").last()
            var top = chat_div.offsetParent()
            //var top = chat.lastChild;
            $("#id-chat-messages").scrollTop(top);
            //chat.scrollTop = top;*/
            scrollChat();
        }, 1000);
                
        function scrollChat() {
                    var chat = document.getElementById("id-chat-messages");
                    var chatLast = chat.lastElementChild;
                    var top = chatLast.offsetTop;
                    chat.scrollTop = top;
                    /*
                     var topPos = message_div.offsetTop;
                     chat.scrollTop = topPos;
                     
                     message_input.value = "";*/
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
                    
                    <div>
                    <h1>Solicitud de presupuesto</h1>
                    <div class="chat-wrapper">

                        <div class="chat-messages-div" id="id-chat-messages">
                            <%
                                if (messageList != 0) {
                                    for (Messages m : messages) {
                                        String mName = m.getMessageUser();
                                        if ("admin".contains(mName)) {
                            %>
                            <div class="messages-message message-received">
                                <p class="message-user signup-labels" >ADMINISTRADOR</p>
                                <p class="message-text"><%= m.getMessageText()%></p>
                            </div>
                            <%
                            } else {
                            %>
                            <div class="messages-message message-sent">
                                <p class="message-user signup-labels"><%= m.getMessageUser()%></p>
                                <p class="message-text"><%= m.getMessageText()%></p>
                            </div>
                            <%
                                        }
                                    }
                                }
                            %>
                        </div>

                        <form method="post" action="SendMessage?chatId=<%= chat.getChatId()%>&userId=<%= user.getUserId()%>" id="id-chat-form" class="chat-form" style="height: 5%; width: 60%;">
                            <div class="chat-input-div row">
                                <input class="form-control input-xs" style="max-width:300px;" id="id-chat-input" type="text" name="chat-message" placeholder="escribe tu mensaje" required>
                                <input type="submit" value="Enviar" name="chat-submit" id="id-chat-enviar" class="btn btn-sm btn-primary btn-block btn-signup" style="max-width:150px;">
                                <!--<p id="id-chat-enviar" clas="chat-enviar" onclick="sendMessage()">Enviar</p>-->
                            </div>
                        </form>
                        <div class="chat-confirmation">
                        <%
                            if (userLogged == 1) {
                                Users cUser = (Users) request.getSession().getAttribute("currentUser");
                                int role = cUser.getUserRole();
                                if (role == 1) {
                        %>
                        
                            <a href="ConfirmPurchase?chatId=<%= chat.getChatId()%>" class="btn-sm btn-warning">CONFIRMAR COMPRA</a>
                            
                        <%
                                }
                            }
                        %>
                            <a href="DeclinePurchase?chatId=<%= chat.getChatId()%>" class="btn-sm btn-danger">RECHAZAR COMPRA</a>
                            <br>
                        </div>
                        
                    
                    </div>
                    </div>
                            <div class="row"><br> </div>
                        <div class="row">
                            
                            <%
                                for (Products product : products) {
                            %>
                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100">
                                    <img class="card-img-top" style="width:249px; height:249px;" src="GetImage?imgId=<%= product.getProductImage()%>" alt="">
                                    <div class="card-body" style="background-color:#03b1fc; color:white;">
                                        <h4 class="card-title">
                                            <%= product.getProductName()%>
                                        </h4>
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
                <div class="col align-items-end" style="  background-image: linear-gradient(to bottom, #03b1fc, #035e82);">
                    <% if (userLogged == 1) {
                            Users user2 = (Users) request.getSession().getAttribute("currentUser");
                    %>
                    <br>
                    <a class="btn btn-sm btn-light btn-block signup-btn" href="LogoutUser">Salir</a>
                    <%
                        int role = user2.getUserRole();
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
