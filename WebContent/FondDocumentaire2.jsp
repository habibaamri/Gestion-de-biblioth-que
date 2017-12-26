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
     <div  class="row" style="background-color: #2bbbad;height: 40%">
     	<div class="valign-wrapper">
     		<img style="margin-top: 40px;" class="col s2 circle responsive-img" src="${sessionScope['PhotoUser']}" />
           	<h2 class="col s8 valign white-text">Bienvenu Msr l'<c:out value="${sessionScope['loginUser']}"/></h2>
     	</div>          
    </div>
    <sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root"  password=""/>
		<sql:query dataSource="${ds}" var="livre" sql="select * from livre  where Id=${param.id} "></sql:query>
		
	
	<div class="col s8" style="margin:60px; " >
	 <form id="Form" method="POST" action="" class="collection" style="padding:20px; " >
				 <c:forEach items="${livre.rows}" var="l"  >
           
				
				  <div class="row">
				            <div class="input-field col s3">
				            	 <input type="text" class="validate" name="titre"  disabled>
				      <label for="username"><c:out value='${l.Id}'/>
				          <c:set scope="session"  var="id" value="${l.Id}"/>
         </label>
				  </div>
				         
				
				              <div class="input-field col s3">
				            	 <input type="text" class="validate"  value="${l.Titre}" name="titre" >
				                <label for="username" class="active">Titre</label>
				            </div>
				   </div>
				   	<sql:query dataSource="${ds}" var="auteur" sql="select * from auteur where Id='${l.Auteur}'"></sql:query>
	
				    <div class="row">
				            <div class="input-field col s3">
				               <c:forEach items="${auteur.rows}" var="au"  >
           	 <input type="text" class="validate" name="titre" value="${au.Nom}" >
				                <label for="username" class="active">Nom d'auteur</label>
				           </c:forEach> </div>
				     <sql:query dataSource="${ds}" var="editeur" sql="select * from editeur where Id='${l.Editeur}'"></sql:query>
	
				              <div class="input-field col s3">
				             <c:forEach items="${editeur.rows}" var="e"  >
           	 <input type="text" class="validate" name="titre" value="${e.Nom}">
				                <label for="username" class="active">Editeur</label>
				           </c:forEach> </div>
				   </div>
				     <sql:query dataSource="${ds}" var="genre" sql="select * from genre where Id='${l.Genre}'"></sql:query>
	   <div class="row">
			        <div class="input-field col s3">
				             <c:forEach items="${genre.rows}" var="g"  >
           	 <input type="text" class="validate" name="titre" value="${g.Genre}">
				                <label for="username" class="active">Genre</label>
				         </c:forEach>   </div> </div>
			      <div class="row">
			        <div class="input-field col s3">
			             <input type="text" class="validate"  id="first_name" name="titre" value="${l.NbrExemplaire}">
		  <label for="first_name" class="active">Nombre Exemplaire</label>
           </div>
        </div>    <div class="row">
             <div class="input-field col s8">
            <button class="secondary-content" type="submit" name="action"><i class="material-icons">update</i> </button>
             <button class="secondary-content" type="submit" id="d" name="action"><i class="material-icons">delete</i> </button>
             <button class="secondary-content" type="submit" name="action"><i class="material-icons">Annuler</i> </button>
        </div> 
			       
                 
          
         </div>
         </c:forEach>
        </form>
    </div>
    <c:if test="${pageContext.request.method =='POST'}">
    <sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root" password="" scope="session"/>
	 
	<c:when test='${param.action=="d")}'>
	 <sql:update dataSource="${ds}" var="updatedTable"> 
	 <sql:query dataSource="${ds}" var="de" sql="delete * from livre where Id='${param.id}'"></sql:query>
	</sql:update>
	</c:when>		          		
	
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
       
               
            <ul>
           		<li><a href="FondDocumentaire.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Fond Documentaire"><i class="material-icons">assignment_ind</i></a></li>
				<li><a href="listeemprunte.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Liste des empruntes"><i class="material-icons">lock_outline</i></a></li>
               
				<li><a href="ValidationInscription.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Validation des Inscriptions"><i class="material-icons">info_outline</i></a></li>
                <li><a href="listeuser.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Liste des user"><i class="material-icons">lock_outline</i></a></li>
                <li><a href="listeauteur.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Liste des auteurs"><i class="material-icons">lock_outline</i></a></li>
               
                <li><a href="Deconnexion.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Deconnexion"><i class="material-icons">lock_outline</i></a></li>
                <li><a href="index.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Contact"><i class="material-icons">loyalty</i></a></li>
              </ul>
        </div>
</body>
</html>
