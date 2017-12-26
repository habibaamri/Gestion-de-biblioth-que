<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/tags" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile</title>
</head>
<body>
     <div  class="row" style="background-color: #2bbbad;height: 30%">
     	<div class="valign-wrapper">
     		<img style="margin-top: 40px;" class="col s2 circle responsive-img" src="${sessionScope['PhotoUser']}" />
           	<h2 class="col s8 valign white-text">Bienvenu </h2>
     	</div>          
    </div>

	<sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root" password="" scope="session"/>
	
			     
	
	<div class="col s8"  style="float: center;margin:60px;">
	       	
	  <form id="Form" method="POST" action="" class="collection" style="margin:20px;">
				  <div class="row">
				            <div class="input-field col s3">
				            	 <input type="text" class="validate" name="login" >
				                <label for="username" class="active">Login</label>
				            </div>
				
				              <div class="input-field col s3">
				            	 <input type="password" class="validate" name="mpd" >
				                <label for="username" class="active">Mot De Passe</label>
				            </div>
				   </div>
				 
				 
            <div class="row">
             <div class="input-field col s8">
           <button class="secondary-content" type="submit" name="action" style="float: right;">
						                      <i class="material-icons">update</i> </button>
						           </div>
         </div>
        </form>
    </div>
	    <c:if test="${pageContext.request.method =='POST'}">
	     <sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root" password="" scope="session"/>
	<c:if test="${ empty param.login or empty param.mpd }">
     	<c:redirect url="profile.jsp" >
              <c:param name="InscMsg" value="SVP veeuillez remplir tous les champs !!" />
      </c:redirect>
  	</c:if>
  	<c:if test="${not empty param.login and not empty param.mpd  }">
     <sql:update dataSource="${ds}" var="updatedTable"> 
	UPDATE bibliothecaire SET Login='${param.login}',
	MotDePasse='${param.mpd}'
	where Id='${sessionScope['UserId']}'
	</sql:update>
	<c:if test="${updatedTable>=1}">
	   <c:redirect url="AcceuilAdmin.jsp"></c:redirect>
	</c:if>
	</c:if>
	</c:if>
	<footer class="page-footer teal darken-3" style="margin-top: 10vh;">            
          <div class="container">
            <div class="row">
              <div class="col l6 s12">
                <h5 class="white-text">Acceuil</h5>
                <p class="grey-text text-lighten-4">Plus On Partage , Plus On Possede</p>
                <p class="grey-text text-lighten-4">Abdelaziz Rafik </p>
                <p class="grey-text text-lighten-4">abdelaziz.rafik@uca.ma</p>
              </div>
              <div class="col l4 offset-l2 s12">
                <h5 class="white-text">Liens</h5>
                <ul>
                  <li><a class="grey-text text-lighten-3" href="#!">Acceuil</a></li>
                  <li><a class="grey-text text-lighten-3" href="#!">Connecter</a></li>
                  <li><a class="grey-text text-lighten-3" href="#!">Trouver Un Livre </a></li>
                  <li><a class="grey-text text-lighten-3" href="#!">Contactez_Nous </a></li>
                </ul>
              </div>
            </div>
          </div>
        <div class="footer-copyright teal darken-4">
            <div class="container">
            © BIBLIOTHEQUE CENTRALE : Faculte des Sciences Semlalia Boulevard Prince Moulay Abdellah B.P.: 2390 46000 Marrakech, Maroc 212 5 24 43 46 49
            <a class="grey-text text-lighten-4 right" href="#!">^_^</a>
            </div>
          </div>
        </footer>
        <div id="NavMenu" class="fixed-action-btn">
            <a class="btn-floating btn-large">
                <i class="material-icons large ">reorder</i>
            </a>
            <ul>
             	<li><a href="AcceuilAdmin.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Acceuil"><i class="material-icons">assignment_ind</i></a></li>
			   
           	<li><a href="profile" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Profile"><i class="material-icons">assignment_ind</i></a></li>
			    <li><a href="index.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Contact"><i class="material-icons">loyalty</i></a></li>
            
                <li><a href="Deconnexion.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Deconnexion"><i class="material-icons">lock_outline</i></a></li>
             </ul>
        </div>
</body>
</html>