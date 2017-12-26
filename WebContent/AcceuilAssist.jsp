<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/tags" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Assistant</title>
</head>
<body>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="dd-MM-yyyy" var="Date"/>
	<sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root"  password=""/>
	<sql:query dataSource="${ds}" var="notices" sql="select * from notice where SiValide=0"/>
	<sql:query dataSource="${ds}" var="adherents" sql="select * from adherent where SiVerifie=0"/>
     <div  class="row" style="background-color: #2bbbad;height: 40%">
     	<div class="valign-wrapper">
     		<img style="margin-top: 40px;" class="col s2 circle responsive-img" src="${sessionScope['PhotoUser']}" />
           	<h2 class="col s8 valign white-text">Bienvenu <c:out value="${sessionScope['loginUser']}"/></h2>
     	</div>          
    </div>
    <div class="row">
    <div class="col s9 push-s2">
        <ul class="collapsible" data-collapsible="accordion">
        <!-- Gestion des Adherents -->
       		<li>
            	<div class="collapsible-header teal-text"><i class="material-icons">place</i>Liste des Demandes d'inscription</div>
                	<div class="collapsible-body">
						<table class="centered">
							<thead>
						    	<tr>
						        	<th data-field="Nom">Nom</th>
						            <th data-field="Prenom">Prenom</th>
						            <th data-field="Adresse">Adresse</th>
						            <th data-field="Email">Email</th>
						            <th data-field="Confirmation">Confirmation</th>
						        </tr>
						    </thead>
						    <tbody>
						    	<c:forEach items="${adherents.rows}" var="Adh">
								    	<tr>
								        	<td><c:out value="${Adh.Nom}"/></td>
								            <td><c:out value="${Adh.Prenom}"/></td>
								            <td><c:out value="${Adh.Adresse}"/></td>
								            <td><c:out value="${Adh.Email}"/></td>
								            <td><button class="secondary-content">
									            <a href="Validation.jsp?id=${Adh.Id}">Valider</a></button>
									         </td>
								          </tr>
								 	</c:forEach>   
						 </tbody>
						</table>
						</div>
                        </li>
                        <!-- Gestion des emprunts -->
                        <li>
                        	<div class="collapsible-header teal-text"><i class="material-icons">filter_drama</i>Gestion des Emprunts</div>
                			<div class="collapsible-body">
                				<sql:query dataSource="${ds}" var="notice" sql="select * from notice"></sql:query>
		  	 				<table class="centered">
        						<thead>
						          <tr>
						              <th data-field="Nom">Adherent</th>
						              <th data-field="Livre">Livre</th>
						              <th data-field="BD">BandeDessine</th>
						              <th data-field="GV">GuideVoyage</th>
						              <th data-field="Etat">Etat</th>
						              <th data-field="Validation">Validation</th>
						          </tr>
						        </thead>
         						<tbody>
         						<c:forEach items="${notices.rows}" var="notice">
									<sql:query dataSource="${ds}" var="livre" sql="select * from livre where Id='${notice.Livre}'"/>
									<sql:query dataSource="${ds}" var="adherent" sql="select * from adherent where Id='${notice.Adherent}'"/>
									<sql:query dataSource="${ds}" var="bds" sql="select * from bandedessine where Id='${notice.BandeDessine}'"/>
									<sql:query dataSource="${ds}" var="gvs" sql="select * from guide_voyage where Id='${notice.GuideVoyage}'"/>
							    	<tr>
							    		<c:forEach items="${adherent.rows}" var="adh"  >
								        	<td><c:out value="${adh.Nom} ${adh.Prenom}"/></td></c:forEach>
								        <c:choose>
								        	<c:when test="${notice.Livre == 0}">
								        		<td>--------------</td>
								        	</c:when>
								        	<c:otherwise>
								        		<c:forEach items="${livre.rows}" var="livr"  >
								            <td><c:out value="${livr.Titre}"/></td></c:forEach>
								        	</c:otherwise>
								        </c:choose>
								        <c:choose>
								        	<c:when test="${notice.BandeDessine == 0}">
								        		<td>--------------</td>
								        	</c:when>
								        	<c:otherwise>
								        		 <c:forEach items="${bds.rows}" var="bd"  >
								            <td><c:out value="${bd.Titre}"/></td></c:forEach>
								        	</c:otherwise>
								        </c:choose>
								        <c:choose>
								        	<c:when test="${notice.GuideVoyage == 0}">
								        		<td>--------------</td>
								        	</c:when>
								        	<c:otherwise>
								        		<c:forEach items="${gvs.rows}" var="gv"  >
								            <td><c:out value="${gv.Nom}"/></td></c:forEach>
								        	</c:otherwise>
								        </c:choose>
								        <td><c:out value="${notice.Etat}"/></td>
							            <td><button class="secondary-content">
						           			<a href="ValidationEmprunt.jsp?id=${notice.Id}">Valider</a></td>
						           		 </button>
							          </tr>
							 	</c:forEach>    
						 		</tbody>
			        		</table>
                			</div>
                        </li>
                        <!-- Gestion de Retours -->
                        <li>
                        	<div class="collapsible-header teal-text"><i class="material-icons">query_builder</i>Gestion de Retours</div>
                			<div class="collapsible-body">
                				<sql:query dataSource="${ds}" var="noticeV" sql='select * from notice where SiValide=1 and DateRetour=""'></sql:query>
		  	 				<table class="centered">
        						<thead>
						          <tr>
						              <th data-field="Nom">Adherent</th>
						              <th data-field="Livre">Livre</th>
						              <th data-field="BD">BandeDessine</th>
						              <th data-field="GV">GuideVoyage</th>
						              <th data-field="Etat">Etat</th>
						              <th data-field="Date">Date De Pret</th>
						              <th data-field="Date">Date De Retour</th>
						              <th data-field="Validation">Validation</th>
						          </tr>
						        </thead>
         						<tbody>
         						<c:forEach items="${noticeV.rows}" var="notice">
									<sql:query dataSource="${ds}" var="livre" sql="select * from livre where Id='${notice.Livre}'"/>
									<sql:query dataSource="${ds}" var="adherent" sql="select * from adherent where Id='${notice.Adherent}'"/>
									<sql:query dataSource="${ds}" var="bds" sql="select * from bandedessine where Id='${notice.BandeDessine}'"/>
									<sql:query dataSource="${ds}" var="gvs" sql="select * from guide_voyage where Id='${notice.GuideVoyage}'"/>
							    	<tr>
							    		<c:forEach items="${adherent.rows}" var="adh"  >
								        	<td><c:out value="${adh.Nom} ${adh.Prenom}"/></td></c:forEach>
								        <c:choose>
								        	<c:when test="${notice.Livre == 0}">
								        		<td>--------------</td>
								        	</c:when>
								        	<c:otherwise>
								        		<c:forEach items="${livre.rows}" var="livr"  >
								            <td><c:out value="${livr.Titre}"/></td></c:forEach>
								        	</c:otherwise>
								        </c:choose>
								        <c:choose>
								        	<c:when test="${notice.BandeDessine == 0}">
								        		<td>--------------</td>
								        	</c:when>
								        	<c:otherwise>
								        		 <c:forEach items="${bds.rows}" var="bd"  >
								            <td><c:out value="${bd.Titre}"/></td></c:forEach>
								        	</c:otherwise>
								        </c:choose>
								        <c:choose>
								        	<c:when test="${notice.GuideVoyage == 0}">
								        		<td>--------------</td>
								        	</c:when>
								        	<c:otherwise>
								        		<c:forEach items="${gvs.rows}" var="gv"  >
								            <td><c:out value="${gv.Nom}"/></td></c:forEach>
								        	</c:otherwise>
								        </c:choose>
								        <td><c:out value="${notice.Etat}"/></td>
								        <c:choose>
								        	<c:when test='${notice.DatePret == ""}'>
								        		<td>--------------</td>
								        	</c:when>
								        	<c:otherwise>
								            <td><c:out value="${notice.DatePret}"/></td>
								        	</c:otherwise>
								        </c:choose>
								        <c:choose>
								        	<c:when test='${notice.DateRetour == ""}'>
								        		<td>
								        			<input class="" value="${Date}" />
								        		</td>
								        	</c:when>
								        	<c:otherwise>
								            <td><c:out value="${notice.DateRetour}"/></td>
								        	</c:otherwise>
								        </c:choose>
							            <td><button class="secondary-content">
						           			<a href="ValidationRetour.jsp?id=${notice.Id}&Date=${Date}">Valider</a></td>
						           		 </button>
							          </tr>
							 	</c:forEach>    
						 		</tbody>
			        		</table>
                			</div>
                        </li>
                        <!-- Recherches et verification -->
                        <li>
                        	<div class="collapsible-header teal-text"><i class="material-icons">play_for_work</i>Recherches et Vérfication</div>
                			<div class="collapsible-body">
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
						     <c:if test="${pageContext.request.method =='POST'}">
							    <sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root"  password=""/>
								<sql:query dataSource="${ds}" var="Livres" sql="select * from livre"></sql:query>
								<sql:query dataSource="${ds}" var="BDs" sql="select * from bandedessine"></sql:query>
								<sql:query dataSource="${ds}" var="GVs" sql="select * from guide_voyage"></sql:query>
								<sql:query dataSource="${ds}" var="Auteurs" sql="select * from auteur"></sql:query>
								<sql:query dataSource="${ds}" var="Collections" sql="select * from collection"></sql:query>
								<sql:query dataSource="${ds}" var="Genres" sql="select * from genre"></sql:query>
						        <div class="container row">	
								    <ul class="collection">
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
												      <h4>Le livre : <c:out value="${l.Titre}"/><c:set var="IdLivre" value="${l.Id}" scope="session"/> </h4>
												      <p>Ecrit par : <c:out value="${noms.rows[0].Nom} ${noms.rows[0].Prenom}"/></p>
												    </div>
												    <div class="modal-footer">
												      <a href="#" class=" modal-action modal-close waves-effect waves-green btn-flat">Verifier</a>
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
												      <h4>La Bande Dessinée : <c:out value="${bd.Titre}"/><c:set var="IdBd" value="${bd.Id}" scope="session"/></h4>
												      <p>Dans la Collection : <c:out value="${collections.rows[0].Nom}"/><br>
												      	Résume : <c:out value="${bd.Scenario}"/></p>
												    </div>
												    <div class="modal-footer">
												      <a href="#" class=" modal-action modal-close waves-effect waves-green btn-flat">Verifier</a>
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
													      <h4>Le livre : <c:out value="${liv.Titre}"/><c:set var="IdLivre" value="${liv.Id}" scope="session"/></h4>
													      <p>Ecrit par : <c:out value="${A.Nom} ${A.Prenom}"/></p>
													    </div>
													    <div class="modal-footer">
													      <a href="#" class=" modal-action modal-close waves-effect waves-green btn-flat">Verifier</a>
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
													      <h4>La Bande Dessinée : <c:out value="${BD.Titre}"/><c:set var="IdBd" value="${BD.Id}" scope="session"/></h4>
													      <p>Dans la Collection : <c:out value="${C.Nom}"/><br>
													      	 Scénariste : <c:out value="${BD.Scenario}"/></p>
													    </div>
													    <div class="modal-footer">
													      <a href="#" class=" modal-action modal-close waves-effect waves-green btn-flat">Verifier</a>
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
													      <h4>Le livre : <c:out value="${liv.Titre}"/><c:set var="IdLivre" value="${liv.Id}" scope="session"/></h4>
													      <p>Ecrit par : <c:out value="${noms.rows[0].Nom} ${noms.rows[0].Prenom}"/></p>
													    </div>
													    <div class="modal-footer">
													      <a href="Emprunt.jsp" class=" modal-action modal-close waves-effect waves-green btn-flat">Emprunter</a>
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
													      <h4>Guide de Voyage : <c:out value="${G.Nom}"/><c:set var="IdGV" value="${G.Id}" scope="session"/></h4>
													      <p> Description: <c:out value="${G.Description}"/></p>
													    </div>
													    <div class="modal-footer">
													      <a href="#" class=" modal-action modal-close waves-effect waves-green btn-flat">Verifier</a>
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
													      <h4>La Bande Dessinée : <c:out value="${B.Titre}"/><c:set var="IdBd" value="${B.Id}" scope="session"/></h4>
													      <p>Dans la Collection : <c:out value="${collections.rows[0].Nom}"/><br>
													      	 Résume : <c:out value="${B.Scenario}"/></p>
													    </div>
													    <div class="modal-footer">
													      <a href="#" class=" modal-action modal-close waves-effect waves-green btn-flat">Verifier</a>
													    </div>
							 				 	</div>
										    </li>
								          </c:when>	  
								        </c:choose>
								      </c:forEach>
								             
									</ul>
								</div>
								</c:if>
                			</div>
                        </li>
                    </ul>
               </div>
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
