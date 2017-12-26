<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Acceuil</title>
</head>
<body>
	<div id="HomeImg" class="parallax-container">
            <div class="parallax" style="">
                <video class="parallaxItem" loop muted autoplay>
                    <source src="Media/Library.mp4" type="video/mp4">
                </video>
            </div>
            <div style="width: 100vw;height: 100vh; background-color: black;opacity: 0.55; position: absolute;"></div>
            <button id="LoginBtn" class="waves-effect waves-teal btn-flat btn-large modal-trigger" type="button" data-target="modal1">Se Connecter
                <i class="material-icons right">perm_identity</i>
            </button>
            <div id="HomeText">
                <h1 class="header" id="HomeTitle">Bibliothéque</h1>
                <blockquote id="HomeQuote" class="lighten-3">Plus On Partage<br />Plus On Posséde</blockquote>
                <div class="container row">
				<div class="col s3 pull-s3">
					 <button class="HomeBtns waves-effect waves-teal btn-flat btn-large modal-trigger" type="button" data-target="modal2">S'inscrire
		            	<i class="material-icons right">add</i>
		               </button>
                </div>
                <div class="col s6 pull-s3">
	             <nav>
	                <div class="nav-wrapper">
	                    <form id="SearchBar" action="" method="post">
	                        <div class="input-field">
	                            <input id="searchInput" type="search" name="searchValues" placeholder="Chercher par Titre, Auteur, Genre....">
	                            <label for="search"><i class="material-icons">search</i></label>
	                            <i class="material-icons">close</i>
	                        </div>
	                    </form>
	                </div>
	              </nav>
	       	 </div>
	       	 </div>
            </div>
        </div>
        <div id="AboutDiv" class="section white">
            <div class="row container center">
                <h3 class="header">La lecture est une amitié</h3>
            </div>
            <div class="row container infoCols">
                <div class="col s4" style=" background-color: #a7ffeb;">
                    <h2 class="header"><i class="material-icons medium">library_books</i><br />+500<br />Livres</h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p><br/>
                </div>
                <div class="col s4">
                    <h2 class="header"><i class="material-icons medium">list</i><br />+100<br />Documents</h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sed.</p>
                </div>
                <div class="col s4" style=" background-color: #a7ffeb;">
                    <h2 class="header"><i class="material-icons medium">info_outline</i><br />+200<br />Categories</h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sed libero metus.</p>
                </div>
            </div>
        </div>
        <div class="parallax-container Section3">
            <div class="parallax"><img  class="parallaxItem" src="Media/img1.jpg"/>
                <br />
                <br />
                <br />
                <h2 class="header" style="font-weight: 300">Une heure de lecture est le souverain remède contre les dégoûts de la vie</h2>
            </div>
        </div>
        <div id="ContactDiv" class="container">
            <h1 class="header">Conatctez_Nous</h1>
            <form onsubmit="return false;">
                <div class="row">
                    <div class="input-field col s6">
                        <input type="text" class="validate" name="Fname" id="Fname">
                        <label class="active" for="Fname">Prenom</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" class="validate" name="Lname" id="Lname">
                        <label class="active" for="Lname">Nom</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <input type="email" class="validate" name="Email" id="Email">
                        <label class="active" for="Email">Email</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <input type="text" class="validate" name="Object" id="Object">
                        <label class="active" for="Object">Objet</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <textarea id="MessageTA" class="materialize-textarea" name="Message" rows="10"></textarea>
                        <label for="Message">Message</label>
                    </div>
                </div>
                <div class="row">
                        <button class="btn waves-effect waves-light" type="submit" name="action" id="ContactSendButton" style="float: right;">Envoyer
                            <i class="material-icons right">send</i>
                        </button>
                </div>
            </form>
        </div>
        <div class="parallax-container Section3">
            <div class="parallax"><img  class="parallaxItem" src="Media/img2.jpg"/>
                <br />
                <br />
                <br />
                <h2 class="header" style="font-weight: 300">Une heure de lecture est le souverain remède contre les dégoûts de la vie</h2>
            </div>
        </div>
        <div id="Resultat" class="section white">
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
					      <a class="secondary-content modal-trigger" data-target="modal2"><i class="material-icons">add</i></a>
					    </li>
			          </c:when>
			        </c:choose>
			      </c:forEach>
			      <!-- Recherche par Bande Dessinée-->
			      <c:forEach items="${BDs.rows}" var="B">
			        <c:choose>
			          <c:when test='${B.Titre == param.searchValues}'>
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
					      <a class="secondary-content modal-trigger" data-target="modal2"><i class="material-icons">add</i></a>
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
					      <a class="secondary-content modal-trigger" data-target="modal2"><i class="material-icons">add</i></a>
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
					      <a class="secondary-content modal-trigger" data-target="modal2"><i class="material-icons">add</i></a>
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
					      <a class="secondary-content modal-trigger" data-target="modal2"><i class="material-icons">add</i></a>
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
					      <a class="secondary-content modal-trigger" data-target="modal2"><i class="material-icons">add</i></a>
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
								      <a href="Emprunt.jsp" class=" modal-action modal-close waves-effect waves-green btn-flat">Emprunter</a>
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
	  </div>
	 <footer class="page-footer teal darken-3" style="margin-top: 10vh;">            
		          <div class="container">
		            <div class="row">
		              <div class="col l6 s12">
		                <h5 class="white-text">Acceuil</h5>
		                <p class="grey-text text-lighten-4">Plus On Partage , Plus On Posséde</p>
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
		            © BIBLIOTHÈQUE CENTRALE : Faculté des Sciences Semlalia Boulevard Prince Moulay Abdellah B.P.: 2390 46000 Marrakech, Maroc 212 5 24 43 46 49
		            <a class="grey-text text-lighten-4 right" href="#!">^_^</a>
		            </div>
		          </div>
        </footer>
        <div id="NavMenu" class="fixed-action-btn">
            <a class="btn-floating btn-large">
                <i class="material-icons large ">reorder</i>
            </a>
            <ul>
                <li onclick="ScrollTo('HomeImg');"><a class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Acceuil"><i class="material-icons">home</i></a></li>
                <li onclick="ScrollTo('');"><a class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Inscription"><i class="material-icons">description</i></a></li>
                <li onclick="ScrollTo('Resultat');"><a class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Résultat"><i class="material-icons">view_headline</i></a></li>
                <li onclick="ScrollTo('ContactDiv');"><a class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Contact"><i class="material-icons">loyalty</i></a></li>
            </ul>
        </div>
 <div id="modal1" class="modal">
    <div class="modal-content">
        <form id="LoginForm" method="POST" action="Authentification.jsp">
            <div class="input-field col s6">
            	<p class=" teal-text center"> ${param.errMsg}</p>
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
<div id="modal2" class="modal">
    <div class="modal-content">
        <form id="LoginForm" method="POST" action="Inscription.jsp">
	        <p class="teal-text center"> ${param.InscMsg}</p>
	        <div class="input-field col s4 push-s2">
	          <i class="material-icons prefix">account_circle</i>
	          <input type="text" class="validate" name="prenom">
	          <label for="prenom">Prénom</label>
	        </div>
	        <div class="input-field col s4 push-s2">
	          <i class="material-icons prefix">account_circle</i>
	          <input type="text" class="validate" name="nom">
	          <label for="nom">Nom</label>
	        </div>
	        <div class="input-field col s8 push-s2">
			  <i class="material-icons prefix">location_on</i>
			  <input type="text" class="validate" name="adresse">
	          <label for="adresse">Adresse</label>
	        </div>
	        <div class="input-field col s8 push-s2">
			  <i class="material-icons prefix">email</i>
	          <input id="email" type="email" class="validate" name="email">
	          <label for="email" data-error="wrong" data-success="right">Email</label>
	        </div>
	        <div class="file-field input-field col s8 push-s2">
		      <div class="btn">
		        <span>Photo</span>
		        <input type="file">
		      </div>
		      <div class="file-path-wrapper">
		        <input class="file-path validate" type="text" name="photo" placeholder="Upload votre photo ^__^">
		      </div>
	    	</div>   
	    	<div class="col s8 push-s2">
	    		<button class="btn waves-effect waves-light" type="submit" name="action" style="float: right;">Valider
	  			  <i class="material-icons right">send</i>
	 			 </button>
	    	</div> 
    </form>
    </div>
</div>
</body>
</html>
