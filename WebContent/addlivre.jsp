<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/tags" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Administrateur</title>
</head>
<body>
     <div  class="row" style="background-color: #2bbbad;height: 30%">
     	<div class="valign-wrapper">
     		<img style="margin-top: 40px;" class="col s2 circle responsive-img" src="${sessionScope['PhotoUser']}" />
           	<h2 class="col s8 valign white-text">Bienvenu </h2>
     	</div>          
    </div>
    
    <div class="col s8" style="margin:60px; " >
    <div class="modal-content">
					      <h4 style="float:center;">Ajouter un nouveau livre</h4>
	 <form id="Form" method="POST" action="" class="collection" style="padding:20px; " >
				  <div class="row">
				           <div class="input-field col s3">
				            	 <input type="text" class="validate"  value="" name="titre" >
				                <label for="username" class="active">Titre</label>
				            </div>
				              <div class="input-field col s3">
           	                         <input type="text" class="validate" name="Genre" value="">
				                    <label for="username" class="active">Genre</label>
				              </div>
				     </div>         
				    <div class="row">
				            <div class="input-field col s3">
			                    <input type="text" class="validate" name="Nom" value="" >
				                <label for="username" class="active">Nom d'auteur</label>
				            </div>
				            <div class="input-field col s3">
			                    <input type="text" class="validate" name="Prenom" value="" >
				                <label for="username" class="active">Prenom d'auteur</label>
				            </div>
				    </div>
				   <div class="row">
				              <div class="input-field col s3">
				                    <input type="text" class="validate" name="Editeur" value="">
				                    <label for="username" class="active">Editeur</label>
				              </div>
				              <div class="input-field col s3">
           	                         <input type="text" class="validate" name="Adresse" value="">
				                    <label for="username" class="active">Adresse</label>
				              </div>
				   </div>
				     
			         
			      <div class="row">
			                 <div class="input-field col s3">
			                          <input type="text" class="validate"  id="first_name" name="Nombre" value="">
		                               <label for="first_name" class="active">Nombre Exemplaire</label>
                                </div>
                                <div class="file-field input-field col s8 push-s2">
		                               <div class="btn">
									        <span>Preface</span>
									        <input type="file">
									    </div>
									      <div class="file-path-wrapper">
									        <input class="file-path validate" type="text" name="photo" placeholder="Upload .. ">
									      </div>
								    	</div>   
                 </div> 
                  <div class="row">
						       <div class="input-field col s8">
						            <button class="secondary-content" type="submit" name="action" >
						                      <i class="material-icons">add</i> </button>
						        </div> 
		           </div>
        </form>
        </div>
     <c:if test="${pageContext.request.method =='POST'}">
	  
    <sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root" password="" scope="session"/>
	<c:if test="${ empty param.titre or empty param.Nom  or empty param.Prenom  or empty param.Editeur or empty param.Genre 
	or empty param.Adresse  or empty param.Nombre or empty param.photo}">
     	<c:redirect url="addlivre.jsp" >
              <c:param name="InscMsg" value="SVP veeuillez remplir tous les champs !!" />
      </c:redirect>
  	</c:if>
  	<c:if test="${not empty param.titre and not empty param.Nom and not  empty param.Prenom and not empty param.Editeur 
  	and not empty param.Genre and not empty param.Adresse  and not empty param.Nombre and not empty param.photo}">
     <sql:update dataSource="${ds}" var="updatedTable"> 
	INSERT INTO auteur (Nom,Prenom) VALUES (?,?)
	<sql:param value="${param.Nom}"/>
		<sql:param value="${param.Prenom}"/>
	</sql:update>
	 <sql:update dataSource="${ds}" var="updatedTable"> 
	INSERT INTO genre(Genre)VALUES (?)
	<sql:param value="${param.Genre}"/>
	</sql:update>
	 <sql:update dataSource="${ds}" var="updatedTable"> 
	INSERT INTO editeur(Nom,Adresse)VALUES (?,?)
	<sql:param value="${param.Editeur}"/>
	
	<sql:param value="${param.Adresse}"/>
	</sql:update>
	<sql:query dataSource="${ds}" var="a" sql="select Id from auteur  where Nom='${param.Nom}' "></sql:query>
		<c:forEach items="${a.rows}" var="au">
	       <c:set scope="session"  var="idauteur" value="${au.Id}"/>
        </c:forEach>
     <sql:query dataSource="${ds}" var="e" sql="select Id from editeur  where Nom='${param.Editeur}' "></sql:query>
		<c:forEach items="${e.rows}" var="ed">
	       <c:set scope="session"  var="idediteur" value="${ed.Id}"/>
        </c:forEach>
        <sql:query dataSource="${ds}" var="g" sql="select Id from genre  where Genre='${param.Genre}' "></sql:query>
		<c:forEach items="${g.rows}" var="genre">
	       <c:set scope="session"  var="idgenre" value="${genre.Id}"/>
        </c:forEach>
              
    <sql:update dataSource="${ds}" var="updatedTable"> 
	INSERT INTO livre(Titre,Auteur,Editeur,Genre,NbrExemplaire,Preface,Disponibilité) VALUES (?, ?, ?, ?, ?, ?, ?)
		<sql:param value="${param.titre}" />
		<sql:param value="${idauteur}" />
		<sql:param value="${idediteur}" />
		<sql:param value="${idgenre}" />
		<sql:param value="${param.Nombre}" />
		<sql:param value="${param.photo}" />
		<sql:param value="Oui"/>
	</sql:update>
	</c:if>
	<c:if test="${updatedTable>=1}">
	   <c:redirect url="livre.jsp"></c:redirect>
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
       
               
            <ul>	<li><a href="AcceuilAdmin.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Acceuil"><i class="material-icons">assignment_ind</i></a></li>
			  
           		<li><a href="profile.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Profile"><i class="material-icons">assignment_ind</i></a></li>
			
                <li><a href="Deconnexion.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Deconnexion"><i class="material-icons">lock_outline</i></a></li>
                <li><a href="index.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Contact"><i class="material-icons">loyalty</i></a></li>
              </ul>
        </div>
</body>
</html>
