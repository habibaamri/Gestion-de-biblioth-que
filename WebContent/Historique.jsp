<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/tags" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Historique</title>
</head>
<body>
<sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root" password="" scope="session"/>
<sql:query dataSource="${ds}" var="notices" sql="select * from notice where Message=1"/>
  <c:forEach items="${notices.rows}" var="n">
        <c:choose>
          <c:when test="${ not empty notices.rows }">
          	<c:if test="${n.Livre != 0}">
          		<sql:query dataSource="${ds}" var="livres" sql="select * from livre where Id=${n.Livre}"/>
          		  <c:forEach items="${livres.rows}" var="l">
          		  	<c:set var="MsgAlerte" value="Attention vous n'avez pas remené le Livre :${l.Titre}"/>
          		  </c:forEach>
          	</c:if>
          	<c:if test="${n.BandeDessine != 0}">
          		<sql:query dataSource="${ds}" var="BDs" sql="select * from bandedessine where Id=${n.BandeDessine}"/>
          		  <c:forEach items="${BDs.rows}" var="B">
          		  	<c:set var="MsgAlerte" value="Attention vous n'avez pas remené le Livre :${B.Titre}"/>
          		  </c:forEach>
          	</c:if>
          	<c:if test="${n.GuideVoyage != 0}">
          		<sql:query dataSource="${ds}" var="GVs" sql="select * from guide_voyage where Id=${n.GuideVoyage}"/>
          		  <c:forEach items="${GVs.rows}" var="g">
          		  	<c:set var="MsgAlerte" value="Attention vous n'avez pas remené le Livre :${g.Nom}"/>
          		  </c:forEach>
          	</c:if>
        </c:when>
	</c:choose>
  </c:forEach>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="dd-MM-yyyy" var="Date"/>
<div  class="row" style="background-color: #2bbbad;height: 40%">
   	<div class="valign-wrapper">
		<img style="margin-top: 40px;" class="col s2 circle responsive-img" src="${sessionScope['PhotoUser']}" />
		<h2 class="col s8 valign white-text">Bienvenu l'adherent : <c:out value="${sessionScope['loginUser']}"/></h2>
    </div>
</div>

<!-- Affichage de Message de Confirmation -->
<h3 class="red-text center"><c:out value="${MsgAlerte}"/> </h3>
<h2 class="teal-text center"><c:out value="${param.MsgConfirmation}"></c:out> </h2><br><br><br><br>	

<!-- Affichage de l'historique -->
<sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root" password="" scope="session"/>
<sql:query dataSource="${ds}" var="Champs" sql="select * from notice where Adherent='${sessionScope['UserId']}' "/>
<div class="row">
<div class="col s8 push-s2">
 <table class="bordered highlight centered responsive-table">
        <thead>
          <tr>
              <th data-field=titre">Titre Du Document</th>
              <th data-field=titre">Auteur / Scénariste</th>
              <th data-field="Date">Date du Pret</th>
          </tr>
        </thead>
    <!-- Parcours des Livres -->
    <tbody>
    	<!-- Parcours l'ancienne data dans notice -->
	    <c:forEach items="${Champs.rows}" var="C">
	    <sql:query dataSource="${ds}" var="livres" sql="select * from livre where Id='${C.Livre}' "/>
	        <c:forEach items="${livres.rows}" var="l">
		          <tr>
		            <td><c:out value="${l.Titre}"/> </td>
		            <sql:query dataSource="${ds}" var="Auteurs" sql="select * from auteur where Id='${l.Auteur}' "/>
		            <td><c:out value="${Auteurs.rows[0].Nom} ${Auteurs.rows[0].Prenom}"/></td>
		            <c:choose>
		            	<c:when test='${C.DatePret == Date }'>
		            		 <td>En cours de Validation</td>
		            	</c:when>
		            	<c:otherwise>
		            		<td><c:out value="${C.DatePret}"/></td>
		            	</c:otherwise>
	            	</c:choose> 
		          </tr>
		       </c:forEach>
	      </c:forEach>
	      <!-- Parcours des BDs -->
	    <c:forEach items="${Champs.rows}" var="C">
	    <sql:query dataSource="${ds}" var="Bds" sql="select * from bandedessine where Id='${C.BandeDessine}' "/>
	        <c:forEach items="${Bds.rows}" var="B">
		          <tr>
		            <td><c:out value="${B.Titre}"/> </td>
		            <td><c:out value="${B.Dessin}"/></td>
		            <c:choose>
		            	<c:when test='${C.DatePret == ""}'>
		            		 <td>En cours de Validation</td>
		            	</c:when>
		            	<c:otherwise>
		            		<td><c:out value="${C.DatePret}"/></td>
		            	</c:otherwise>
	            	</c:choose> 
		          </tr>
		       </c:forEach>
      </c:forEach>
      <!-- Parcours des Guides Voyages -->
      <c:forEach items="${Champs.rows}" var="C">
	    <sql:query dataSource="${ds}" var="GVs" sql="select * from guide_voyage where Id='${C.GuideVoyage}' "/>
	        <c:forEach items="${GVs.rows}" var="G">
		          <tr>
		            <td><c:out value="${G.Nom}"/> </td>
		            <td>----------</td>
		            <c:choose>
		            	<c:when test='${C.DatePret == ""}'>
		            		 <td>En cours de Validation</td>
		            	</c:when>
		            	<c:otherwise>
		            		<td><c:out value="${C.DatePret}"/></td>
		            	</c:otherwise>
	            	</c:choose> 
		          </tr>
		       </c:forEach>
      </c:forEach>
      </tbody>
     </table>
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
           		<li><a href="Acceuil.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Profil"><i class="material-icons">assignment_ind</i></a></li>
                <li><a href="Deconnexion.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Deconnexion"><i class="material-icons">lock_outline</i></a></li>
                <li><a href="index.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Contact"><i class="material-icons">loyalty</i></a></li>
            </ul>
        </div>
</body>
</html>