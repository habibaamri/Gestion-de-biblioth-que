<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/tags" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bienvenu</title>
</head>
<body>
     <div  class="row" style="background-color: #2bbbad;height: 40%">
     	<div class="valign-wrapper">
     		<img style="margin-top: 40px;" class="col s2 circle responsive-img" src="${sessionScope['PhotoUser']}" />
           	<h2 class="col s8 valign white-text">Bienvenu l'adherent : <c:out value="${sessionScope['loginUser']}"/></h2>
     	</div>          
    </div>
    <div class="container row">
	    <div class="s12 m4 l8">
	             <nav>
	                <div class="nav-wrapper">
	                    <form id="SearchBar" action="" method="post">
	                        <div class="input-field">
	                            <input id="searchInput" type="search" name="searchValues" placeholder="Chercher par Titre, Auteur, Genre de livre /Titre, Collection de BD....">
	                            <label for="search"><i class="material-icons">search</i></label>
	                            <i class="material-icons">close</i>
	                        </div>
	                    </form>
	                </div>
	              </nav>
	        </div>
        </div>
    	<div class="container row">
	         <div class="col s4 card medium" style="ma">
			    <div class="card-image waves-effect waves-block waves-light">
			      <img class="activator" src="Media/BD.gif">
			    </div>
			    <div class="card-content">
			      <span class="card-title activator grey-text text-darken-4">Bande Dessinee<i class="material-icons right">more_vert</i></span>
			    </div>
			    <div class="card-reveal">
			      <span class="card-title grey-text text-darken-4">Bande Dessinee<i class="material-icons right">close</i></span>
			      <p>La bande dessinée est un art narratif, graphique et séquentiel. 
			      Certains éléments graphiques et narratifs remontent à la Préhistoire, mais ne sont pas encore séquentiels. 
			      Dans le Polithique supérieur (35 000-10 000 av. J.-C.),
			       les humains commencent avec l'Art Rupestre (peinture et gravure sur rocher) et l'Art Pariétal (peinture et gravure sur des parois de grotte)
			        Ã  créer des narrations graphiques sur des supports durs et frontaux afin d'obtenir un panorama visuel			      
			      </p>
			    </div>
	  		</div>
	  		<div class="col s4 card medium Cards">
			    <div class="card-image waves-effect waves-block waves-light">
			      <img class="activator" src="Media/Livre.jpeg">
			    </div>
			    <div class="card-content">
			      <span class="card-title activator grey-text text-darken-4">Romans<i class="material-icons right">more_vert</i></span>
			    </div>
			    <div class="card-reveal">
			      <span class="card-title grey-text text-darken-4">Romans<i class="material-icons right">close</i></span>
			      <p>Le roman est un genre littéraire, caractérisé essentiellement par une narration fictionnelle.
			       La place importante faite à l'imagination transparait dans certaines expressions comme :« C'est du roman ! »
			        ou dans certaines acceptions de l'adjectif Â« romanesque Â» qui renvoient Ã  l'extraordinaire des personnages, des situations ou de l'intrigue.
					</p>
			    </div>
	  		</div>
	  		<div class="col s4 card medium Cards">
			    <div class="card-image waves-effect waves-block waves-light">
			      <img class="activator" src="Media/GV.jpg">
			    </div>
			    <div class="card-content">
			      <span class="card-title activator grey-text text-darken-4">Guide De Voyages<i class="material-icons right">more_vert</i></span>
			    </div>
			    <div class="card-reveal">
			      <span class="card-title grey-text text-darken-4">Guide De Voyages<i class="material-icons right">close</i></span>
			      <p>Un guide touristique ou guide de voyage est un type de livre contenant des informations sur un lieu donnée, 
			      qui peuvent etre d'ordre pratique autant que culturel et historique, à l'usage des touristes.			      
			      </p>
			    </div>
	  		</div>
     </div> 
     <c:if test="${pageContext.request.method =='POST'}">
	    <sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root"  password=""/>
		<sql:query dataSource="${ds}" var="Livres" sql="select * from livre"></sql:query>
		<sql:query dataSource="${ds}" var="BDs" sql="select * from bandedessine"></sql:query>
		<sql:query dataSource="${ds}" var="GVs" sql="select * from guide_voyage"></sql:query>
		<sql:query dataSource="${ds}" var="Auteurs" sql="select * from auteur"></sql:query>
		<sql:query dataSource="${ds}" var="Collections" sql="select * from collection"></sql:query>
		<sql:query dataSource="${ds}" var="Genres" sql="select * from genre"></sql:query>
		
		<div class="container row">	
	    <ul class="col s12 collection">
	    <!-- Recherche par Livre -->
		  <c:forEach items="${Livres.rows}" var="l">
	        <c:choose>
	          <c:when test='${l.Titre == param.searchValues}'>
	          	<li class=" collection-item avatar">
			      	<img src="${l.Preface}" alt="" class="circle  responsive-img materialboxed">
				      <span class="teal-text title"><c:out value="${l.Titre}"/></span>
					  <sql:query dataSource="${ds}" var="noms" sql="select * from auteur where Id='${l.Auteur}'"/>                     
				      <p><c:out value="${noms.rows[0].Nom} ${noms.rows[0].Prenom}"/><br>
				     	 <sql:query dataSource="${ds}" var="genres" sql="select Genre from Genre where Id='${l.Genre}'"/>                     
				      	<c:out value="${genres.rows[0].Genre}"/>
				      </p>
			      <a href="#modal1" class="modal-trigger secondary-content"><i class="material-icons">add</i></a>
			      <div id="modal1" class="modal">
					    <div class="modal-content">
					      <h4>Le livre : <c:out value="${l.Titre}"/></h4>
					      <p>Ecrit par : <c:out value="${noms.rows[0].Nom} ${noms.rows[0].Prenom}"/></p>
					    </div>
					    <div class="modal-footer">
					      <a href="Emprunt.jsp?livreID=${l.Id}" class=" modal-action modal-close waves-effect waves-green btn-flat">Emprunter</a>
					    </div>
 				 </div>
			    </li>
	          </c:when>
	        </c:choose>
	      </c:forEach>
	      <!-- Recherche par Bande Dessinée-->
	      <c:forEach items="${BDs.rows}" var="bd">
	        <c:choose>
	          <c:when test="${bd.Titre == param.searchValues}">
	          	<li class="collection-item avatar">
			      	<img src="${bd.Preface}"  class="circle  responsive-img materialboxed">
				      <span class="teal-text title"><c:out value="${bd.Titre}"/></span>
					  <sql:query dataSource="${ds}" var="collections" sql="select * from collection where Id='${bd.Collection}'"/>                     
				      <p><c:out value="${collections.rows[0].Nom}"/><br>
				     	<sql:query dataSource="${ds}" var="editeurs" sql="select * from editeur where Id='${bd.Editeur}'"/>                     
				      	<c:out value="${editeurs.rows[0].Nom}"/><br>
				      	<c:out value="${editeurs.rows[0].Adresse}"/><br>
				      	<c:out value="${bd.Scenario}"/>
				      </p>
			      <a href="#modal1" class="modal-trigger secondary-content"><i class="material-icons">add</i></a>
			      <div id="modal1" class="modal">
					    <div class="modal-content">
					      <h4>La Bande Dessinée : <c:out value="${bd.Titre}"/></h4>
					      <p>Dans la Collection : <c:out value="${collections.rows[0].Nom}"/><br>
					      	Résume : <c:out value="${bd.Scenario}"/></p>
					    </div>
					    <div class="modal-footer">
					      <a href="Emprunt.jsp?IdBd=${bd.Id}" class=" modal-action modal-close waves-effect waves-green btn-flat">Emprunter</a>
					    </div>
 				 </div>
			    </li>
	          </c:when>	  
	        </c:choose>
	      </c:forEach>
	      <!-- Recherche par Auteur -->
	       <c:forEach items="${Auteurs.rows}" var="A">
	        <c:choose>
	          <c:when test='${fn:contains(param.searchValues,A.Nom)}'>
	          		<sql:query dataSource="${ds}" var="li" sql="select * from livre where Auteur='${A.Id}'"/> 
					 <c:forEach items="${li.rows}" var="liv">
			          	<li class="collection-item avatar">
					      	<img src="${liv.Preface}" alt="" class=" circle responsive-img materialboxed">
						      <span class="teal-text title"><c:out value="${liv.Titre}"/></span>
						      <p><c:out value="${A.Nom} ${A.Prenom}"/><br>
						     	 <sql:query dataSource="${ds}" var="genres" sql="select Genre from Genre where Id='${liv.Genre}'"/>                     
						      	<c:out value="${genres.rows[0].Genre}"/>
						      </p>
					      <a href="#modal1" class="modal-trigger secondary-content"><i class="material-icons">add</i></a>
					      <div id="modal1" class="modal">
						    <div class="modal-content">
						      <h4>Le livre : <c:out value="${liv.Titre}"/></h4>
						      <p>Ecrit par : <c:out value="${A.Nom} ${A.Prenom}"/></p>
						    </div>
						    <div class="modal-footer">
						      <a href="Emprunt.jsp?livreID=${liv.Id}" class=" modal-action modal-close waves-effect waves-green btn-flat">Emprunter</a>
						    </div>
 						 </div>
					    </li>
					  </c:forEach>
	          </c:when>	  
	        </c:choose>
	      </c:forEach>
	     <!-- Recherche par Collection -->
	      <c:forEach items="${Collections.rows}" var="C">
	        <c:choose>
	          <c:when test='${fn:contains(param.searchValues,C.Nom)}'>
	          		<sql:query dataSource="${ds}" var="bd" sql="select * from bandedessine where Collection='${C.Id}'"/> 
					 <c:forEach items="${bd.rows}" var="BD">
			          	<li class="collection-item avatar">
					      	<img src="${BD.Preface}" alt="" class=" circle responsive-img materialboxed">
						      <span class="teal-text title"><c:out value="${BD.Titre}"/></span>
						      <p><c:out value="${C.Nom}"/><br>
					     	 <sql:query dataSource="${ds}" var="editeurs" sql="select * from editeur where Id='${BD.Editeur}'"/>                     
					      	<c:out value="${editeurs.rows[0].Nom}"/><br>
					      	<c:out value="${editeurs.rows[0].Adresse}"/><br>
					      	<c:out value="${BD.Scenario}"/>
						      </p>
					      <a href="#modal1" class="modal-trigger secondary-content"><i class="material-icons">add</i></a>
					      <div id="modal1" class="modal">
						    <div class="modal-content">
						      <h4>La Bande Dessinée : <c:out value="${BD.Titre}"/></h4>
						      <p>Dans la Collection : <c:out value="${C.Nom}"/><br>
						      	 Scénariste : <c:out value="${BD.Scenario}"/></p>
						    </div>
						    <div class="modal-footer">
						      <a href="Emprunt.jsp?IdBd=${BD.Id}" class=" modal-action modal-close waves-effect waves-green btn-flat">Emprunter</a>
						    </div>
 				 		</div>
					    </li>
					  </c:forEach>
	          </c:when>	  
	        </c:choose>
	      </c:forEach>
	     <!-- Recherche par Genre -->
	       <c:forEach items="${Genres.rows}" var="G">
	        <c:choose>
	          <c:when test='${fn:contains(param.searchValues,G.Genre)}'>
	          		<sql:query dataSource="${ds}" var="li" sql="select * from livre where Genre='${G.Id}'"/> 
					 <c:forEach items="${li.rows}" var="liv">
			          	<li class="collection-item avatar">
					      	<img src="${liv.Preface}" alt="" class=" circle responsive-img materialboxed">
						      <span class="teal-text title"><c:out value="${liv.Titre}"/></span>
						      <sql:query dataSource="${ds}" var="noms" sql="select * from auteur where Id='${liv.Auteur}'"/>                     
						      <p><c:out value="${noms.rows[0].Nom} ${noms.rows[0].Prenom}"/><br>
						      	<c:out value="${G.Genre}"/>
						      </p>
					      <a href="#modal1" class="modal-trigger secondary-content"><i class="material-icons">add</i></a>
					      <div id="modal1" class="modal">
						    <div class="modal-content">
						      <h4>Le livre : <c:out value="${liv.Titre}"/></h4>
						      <p>Ecrit par : <c:out value="${noms.rows[0].Nom} ${noms.rows[0].Prenom}"/></p>
						    </div>
						    <div class="modal-footer">
						      <a href="Emprunt.jsp?livreID=${liv.Id}" class=" modal-action modal-close waves-effect waves-green btn-flat">Emprunter</a>
						    </div>
 						 </div>
					    </li>
					  </c:forEach>
	          </c:when>	  
	        </c:choose>
	      </c:forEach>
	      <!-- Recherche Par Guides de voyages -->
	      <c:forEach items="${GVs.rows}" var="G">
	        <c:choose>
	          <c:when test='${G.Nom == param.searchValues}'>
	          	<li class=" collection-item avatar">
			      	<img src="${G.Preface}" alt="" class="circle  responsive-img materialboxed">
				      <span class="teal-text title"><c:out value="${G.Nom}"/></span>
				      <p><c:out value="${G.Description}"/></p>
			      <a href="#modal1" class="modal-trigger secondary-content"><i class="material-icons">add</i></a>
			      <div id="modal1" class="modal">
						    <div class="modal-content">
						      <h4>Guide de Voyage : <c:out value="${G.Nom}"/></h4>
						      <p> Description: <c:out value="${G.Description}"/></p>
						    </div>
						    <div class="modal-footer">
						      <a href="Emprunt.jsp?IdGV=${G.Id}" class=" modal-action modal-close waves-effect waves-green btn-flat">Emprunter</a>
						    </div>
 					</div>
			    </li>
	          </c:when>
	        </c:choose>
	      </c:forEach>	
	      <!-- Recherche tous les BDs -->
	      <c:forEach items="${BDs.rows}" var="B">
	        <c:choose>
	          <c:when test='${param.searchValues == "Bande Dessinee" or param.searchValues == "bande dessinee"}'>
	          	<li class=" collection-item avatar">
			      	<img src="${B.Preface}" alt="" class="circle  responsive-img materialboxed">
				      <span class="teal-text title"><c:out value="${B.Titre}"/></span>
					  <sql:query dataSource="${ds}" var="collections" sql="select * from collection where Id='${B.Collection}'"/>                     
				      <p><c:out value="${collections.rows[0].Nom}"/><br>
				     	 <sql:query dataSource="${ds}" var="editeurs" sql="select * from editeur where Id='${B.Editeur}'"/>                     
				      	<c:out value="${editeurs.rows[0].Nom}"/><br>
				      	<c:out value="${editeurs.rows[0].Adresse}"/><br>
				      	<c:out value="${B.Scenario}"/>
				      </p>
			      <a href="#modal1" class="modal-trigger secondary-content"><i class="material-icons">add</i></a>
			       <div id="modal1" class="modal">
						    <div class="modal-content">
						      <h4>La Bande Dessinée : <c:out value="${B.Titre}"/></h4>
						      <p>Dans la Collection : <c:out value="${collections.rows[0].Nom}"/><br>
						      	 Résume : <c:out value="${B.Scenario}"/></p>
						    </div>
						    <div class="modal-footer">
						      <a href="Emprunt.jsp?IdBd=${B.Id}" class=" modal-action modal-close waves-effect waves-green btn-flat">Emprunter</a>
						    </div>
 				 	</div>
			    </li>
	          </c:when>	  
	        </c:choose>
	      </c:forEach>
	             
		</ul>
	</div>
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
            Â© BIBLIOTHEQUE CENTRALE : Faculte des Sciences Semlalia Boulevard Prince Moulay Abdellah B.P.: 2390 46000 Marrakech, Maroc 212 5 24 43 46 49
            <a class="grey-text text-lighten-4 right" href="#!">^_^</a>
            </div>
          </div>
        </footer>
        <div id="NavMenu" class="fixed-action-btn">
            <a class="btn-floating btn-large">
                <i class="material-icons large ">reorder</i>
            </a>
            <ul>
           		<li><a href="Profil.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Profil"><i class="material-icons">assignment_ind</i></a></li>
				<li><a href="Historique.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Historique"><i class="material-icons">info_outline</i></a></li>
                <li><a href="Deconnexion.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Deconnexion"><i class="material-icons">lock_outline</i></a></li>
                <li><a href="index.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Contact"><i class="material-icons">loyalty</i></a></li>
            </ul>
        </div>
</body>
</html>
