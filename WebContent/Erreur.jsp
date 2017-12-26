<%@ page language="java" contentType="text/html;  charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Erreur</title>
</head>
<body>
		<div id="HomeImg" class="parallax-container">
            <div class="parallax">
                <img class="parallaxItem" src="Media/img2.jpg"/>
            </div>
            <div style="width: 100vw;height: 100vh; background-color: black;opacity: 0.55; position: absolute;"></div>
			<div id="HomeText">
				<h1 id="HomeTitle" class="center">${param.errMsg}</h1>
            </div>
            <button id="LoginBtn" class="waves-effect waves-teal btn-flat btn-large modal-trigger right" type="button" data-target="modal1">Essayer à Nouveau
                <i class="material-icons right">perm_identity</i>
            </button>
             <form action="index.jsp">
             	<button id="LoginBtn" style="margin-right: 49%" class="waves-effect waves-teal btn-flat btn-large" type="submit" name="action">Retour à l'Acceuil
               	 <i class="material-icons left">skip_previous</i>
           		</button>	
            </form>		  
        </div>
	<div id="modal1" class="modal">
    	<div class="modal-content">
        <form id="LoginForm" method="POST" action="Authentification.jsp">
            <div class="input-field col s6">
                <input type="text" class="validate" name="username">
                <label for="username">Identifiant</label>
            </div>
    
            <div class="input-field col s6">
                <input type="password" class="validate" name="password">
                <label for="password">Mot De Passe</label>
            </div>
            
            <a href="#">Mot De Passe Oublié?</a>
            <br />
            <br />
            <button class="btn waves-effect waves-light" type="submit" name="action" style="width: 100%;">Se Connecter
                <i class="material-icons right">send</i>
            </button>
        </form>
    </div>
    </div>
	
</body>
</html>
