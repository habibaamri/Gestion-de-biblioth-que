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
		<sql:query dataSource="${ds}" var="livre" sql="select * from livre  "></sql:query>
		<div class="col s8" style="margin:60px; " >
	 <div class="container row" style="margin-left:850px;" >
	 	 <div class="col s4 pull-s4"  >
			<a href="addbande.jsp">Ajouter une bande dessine </a>
                      
                </div>
	       	 </div>
	 	
	 
	    <sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root"  password=""/>
	<sql:query dataSource="${ds}" var="bande" sql="select * from bandedessine  "></sql:query>
		
		    <form id="actionform1" action="" method="post">
	     
		   <table class="bordered" >
        <thead>
          <tr> 
          <th>Preface</th>
             
              <th>Id</th>
             
              <th data-field="id">Titre</th>
              <th data-field="name">Scenario</th>
              <th data-field="price">Dessin</th>
              
              <th data-field="price">Couleur</th>
              <th data-field="price">Editeur</th>
              <th data-field="price">Collection</th>
              <th data-field="price">Nbr Exemplaie</th>
              
              <th data-field="price">Disponibilité</th>
              <th></th>
          </tr>
        </thead>
         
	      <c:forEach items="${bande.rows}" var="l">
	        <c:choose>
	          <c:when test="${ not empty bande.rows }">
	          	 	
		 <tbody>
          <tr><td > <div class="row">	<img class="col s3 circle responsive-img" src="${l.Preface}"/> </div> </td>
         
         <td > 	<c:out value="${l.Id}"/>  </td>
            <td > 	<c:out value="${l.Titre}"/>  </td>
              <td > 	<c:out value="${l.Scenario}"/>  </td>
            <td > 	<c:out value="${l.Dessin}"/>  </td>
           <td > 	<c:out value="${l.Couleur}"/>  </td>
           
               <sql:query dataSource="${ds}" var="editeur" sql="select * from editeur where Id='${l.Editeur}'"></sql:query>
	
            <c:forEach items="${editeur.rows}" var="e"  >
             <td> 	<c:out value="${e.Nom}"/>
            	</td>
           </c:forEach>
           <sql:query dataSource="${ds}" var="collection" sql="select * from collection where Id='${l.Collection}'"></sql:query>
	
           <c:forEach items="${collection.rows}" var="c"  >
            <td><c:out value="${c.Nom}"/></td>
             </c:forEach>
           <td><c:out value="${l.NbrExemplaire}"/></td>
            <td > 
             	<c:out value="${l.Disponibilité}"/>  
            <c:set scope="session"  var="Disponible" value="${l.Disponibilité}"/>
            </td>
      <td><a href="deletebande.jsp?id=${l.Id}" class="secondary-content">
      <i class="material-icons">delete</i> </a>
                 
           </td>    
          </tr>
         
        </tbody>
    
        </c:when>	  
	        </c:choose>
	      </c:forEach>
	     </table>  </form>
	       
 
	
    </div>
      
		
	   
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
			  
           		<li><a href="FondDocumentaire.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Profile"><i class="material-icons">assignment_ind</i></a></li>
			
                <li><a href="Deconnexion.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Deconnexion"><i class="material-icons">lock_outline</i></a></li>
                <li><a href="index.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Contact"><i class="material-icons">loyalty</i></a></li>
              </ul>
        </div>
</body>
</html>
