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
           	<h2 class="col s8 valign white-text">Bienvenu Admin</h2>
     	</div>          
    </div>
    <sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root"  password=""/>
		<sql:query dataSource="${ds}" var="notice" sql="select * from notice  "></sql:query>
<sql:query dataSource="${ds}" var="notices" sql="select * from notice where SiValide=0"/>
	<sql:query dataSource="${ds}" var="adherents" sql="select * from adherent where SiVerifie=0"/>
	<sql:query dataSource="${ds}" var="listes" sql="select * from adherent"/>

	<div class="row" style="margin: 20px;float:center;">
	<ul class="collapsible" data-collapsible="accordion">
    <li>
      <div class="collapsible-header"><i class="material-icons">filter_drama</i>Listes des Emprunts</div>
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
    <li>
      <div class="collapsible-header"><i class="material-icons">place</i>validation des demandes</div>
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
     <li>
      <div class="collapsible-header"><i class="material-icons">restore</i>Gestions des retours</div>
      <div class="collapsible-body"> 
      <div class="nav-wrapper" style="margin: 20px;">
	           <div class="row" style="margin: 20px;">
	<ul class="collapsible" data-collapsible="accordion">
    <li>
      <div class="collapsible-header"><i class="material-icons">filter_drama</i>Listes des livres non retourné</div>
      
     
	<div class="collapsible-body">
      <sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root"  password=""/>
	
	<sql:query dataSource="${ds}" var="notice" sql="select * from notice where DateRetour='' and 
								DATEDIFF(CURDATE(),DatePret) > 30  and Livre <> 0"></sql:query>
	
		    <form id="actionform1" action="" method="post">
	     
		   <table class="bordered" >
        <thead>
          <tr> 
              <th>Id</th>
             <th data-field="price">Adherent</th>
              <th data-field="id">Livre</th>
                <th data-field="price">Date Pret</th>
              <th data-field="price">Etat</th>
             <th>Action</th>
          </tr>
        </thead>
        	
	      <c:forEach items="${notice.rows}" var="o">
	        <c:choose>
	          <c:when test="${ not empty notice.rows  }">
	          	   <tbody>
          <tr>
          <td > 	<c:out value="${o.Id}"/>  </td>
          		  
          		<sql:query dataSource="${ds}" var="adherent" sql="select * from adherent where Id='${o.Adherent}'"></sql:query>
				<td ><c:forEach items="${adherent.rows}" var="ad"  >
				
           		      <c:out value="${ad.Nom}"/>
                      </c:forEach>
               </td>
	          	  <td >	<sql:query dataSource="${ds}" var="livre" sql="select * from livre where Id='${o.Livre}'"/>
				          <c:forEach items="${livre.rows}" var="l"  >
				
				            <c:out value="${l.Titre}"/>
               
                           </c:forEach>
                 </td>
				  <td> 	<c:out value="${o.DatePret}"/>
           </td>
                 <td > 
             	<c:out value="${o.Etat}"/>  
            </td>
      <td> <a href="message.jsp?idnotic=${o.Id}">
		  <i class="material-icons">announcement</i> </a>
						             </td>    
          </tr>
         
        </tbody>
    
        </c:when>	  
	        </c:choose>
	      </c:forEach>
	     </table>
	     </form>
	     </div>
	     </li>
	      <li>
	     <div class="collapsible-header"><i class="material-icons">filter_drama</i>Listes des bandes dessines non retourné</div>
      
	     <div class="collapsible-body">
	     <sql:query dataSource="${ds}" var="notice2" sql="select * from notice where DateRetour='' and 
								DATEDIFF(CURDATE(),DatePret) >20 and BandeDessine <> 0"></sql:query>
	 <form id="actionform1" action="" method="post">
	     
	       <table class="bordered" >
        <thead>
          <tr> 
              <th>Id</th>
             <th data-field="price">Adherent</th>
              <th data-field="id">Bande Dessine</th>
                <th data-field="price">Date Pret</th>
              <th data-field="price">Etat</th>
             <th>Action</th>
          </tr>
        </thead>
        	
	      <c:forEach items="${notice2.rows}" var="o2">
	        <c:choose>
	          <c:when test="${ not empty notice2.rows  }">
	          	   <tbody>
          <tr>
          <td > 	<c:out value="${o2.Id}"/>  </td>
          		  
          		<sql:query dataSource="${ds}" var="adherent" sql="select * from adherent where Id='${o2.Adherent}'"></sql:query>
				<td ><c:forEach items="${adherent.rows}" var="ad"  >
				
           		      <c:out value="${ad.Nom}"/>
                      </c:forEach>
               </td>
	          	  <sql:query dataSource="${ds}" var="bd" sql="select * from bandedessine where Id='${o2.BandeDessine}'"></sql:query>
	
			             <td> <c:forEach items="${bd.rows}" var="b"  >
			            <c:out value="${b.Titre}"/>
			            	
			           </c:forEach></td>
				  <td> 	<c:out value="${o2.DatePret}"/>
           </td>
                 <td > 
             	<c:out value="${o2.Etat}"/>  
            </td>
      <td> <a href="message.jsp?idnotic=${o2.Id}">
		  <i class="material-icons">announcement</i> </a>
						             </td>    
          </tr>
         
        </tbody>
    
        </c:when>	  
	        </c:choose>
	      </c:forEach>
	     </table>
	     </form>
	     </div>
	     </li>
	     <li>
	      <div class="collapsible-header"><i class="material-icons">filter_drama</i>Listes des bandes dessines non retourné</div>
      
	     <div class="collapsible-body">
	     <sql:query dataSource="${ds}" var="notice3" sql="select * from notice where DateRetour='' and 
								DATEDIFF(CURDATE(),DatePret) >15 and GuideVoyage <> 0"></sql:query>
	 <form id="actionform1" action="" method="post">
	     
	       <table class="bordered" >
        <thead>
          <tr> 
              <th>Id</th>
             <th data-field="price">Adherent</th>
              <th data-field="id">Guide Voyage</th>
                <th data-field="price">Date Pret</th>
              <th data-field="price">Etat</th>
             <th>Action</th>
          </tr>
        </thead>
        	
	      <c:forEach items="${notice3.rows}" var="o3">
	        <c:choose>
	          <c:when test="${ not empty notice3.rows  }">
	          	   <tbody>
          <tr>
          <td > 	<c:out value="${o3.Id}"/>  </td>
          		  
          		<sql:query dataSource="${ds}" var="adherent" sql="select * from adherent where Id='${o3.Adherent}'"></sql:query>
				<td ><c:forEach items="${adherent.rows}" var="ad"  >
				
           		      <c:out value="${ad.Nom}"/>
                      </c:forEach>
               </td>
	          	   <sql:query dataSource="${ds}" var="gv" sql="select * from guide_voyage where Id='${o3.GuideVoyage}'"></sql:query>
	
           <td> <c:forEach items="${gv.rows}" var="g"  >
            <c:out value="${g.Nom}"/>
             </c:forEach></td>
             
          
				  <td> 	<c:out value="${o3.DatePret}"/>
           </td>
                 <td > 
             	<c:out value="${o3.Etat}"/>  
            </td>
      <td> <a href="message.jsp?idnotic=${o3.Id}">
		  <i class="material-icons">announcement</i> </a>
						             </td>    
          </tr>
         
        </tbody>
    
        </c:when>	  
	        </c:choose>
	      </c:forEach>
	     </table>
		 </form>
	     </div>  
		</li>
		</ul>
		</div>

</div>
</div>

    </li>
    
    <li>
      <div class="collapsible-header"><i class="material-icons">list</i>Gestion des assistants
              </div>
      <div class="collapsible-body">
          <div class="nav-wrapper" style="margin-top:25px;">
	            <div class="row" style="margin-top:5px;margin-right:5px;">    
	                   <a class="secondary-content" href="addassistant.jsp">
	                   <i class="material-icons">add</i> ajouter un nouveau assistant </a>
                       </div>
	         </div>
            
      		  <sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root"  password=""/>
		<sql:query dataSource="${ds}" var="assistant" sql="select * from assistant"></sql:query>
	<div class="row" style="margin-left:70px;">
		 <div class="col s8" >
		   <table class="bordered" >
        <thead>
          <tr> <tr><th></th>
              <th>Id</th>
              <th data-field="id">Nom</th>
              <th data-field="name">Prenom</th>
          </tr>
        </thead>
          <form id="delete" action="" method="post" name="delete">
	     
	      <c:forEach items="${assistant.rows}" var="A">
	        <c:choose>
	          <c:when test="${ not empty assistant.rows }">
	          	 	
		 <tbody>
          <tr>
          		
            <td><img style="margin-right: -50px;" class="col s2 circle responsive-img" src="${A.Photo}" />
           </td>
            <td> 	<c:out value="${A.Id}"/>
             <c:set scope="session"  var="A.Id" value="${A.Id}"/>
           </td>
           
            <td> 	<c:out value="${A.Nom}"/></td>
            <td> 	<c:out value="${A.Prenom}"/></td>
           <td>   <a class="secondary-content" href="deleteassistant.jsp?id=${A.Id}"><i class="material-icons">delete</i> </a>
      
           </td>    
          </tr>
         
        </tbody>
    
        </c:when>	  
	        </c:choose>
	      </c:forEach>
	      </form>
	        </table>
		  <br />

    
      	</div>
         </div>
      </div>
    </li>
     <li>
      <div class="collapsible-header"><i class="material-icons">work</i>Gestion des documents</div>
      <div class="collapsible-body" style="margin-left:80px;margin-top:25px;">
      
     <div style="margin-top:10px;"><a href="livre.jsp" ><i class="material-icons">settings</i> Gestion des livres</a></div>
		<div style="margin-top:10px;"><a href="bandedessine.jsp"><i class="material-icons">settings</i> Gestion des bandes dessines </a></div>
		<div style="margin-top:10px;margin-bottom:20px;"> <a href="guidevoyage.jsp"><i class="material-icons">settings</i>Gestion des guides des voyages</a></div>
		

</div>
    </li>
  </ul>
        


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
			  
           	<li><a href="profile.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Profile"><i class="material-icons">assignment_ind</i></a></li>
			    <li><a href="index.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Contact"><i class="material-icons">loyalty</i></a></li>
             
                <li><a href="Deconnexion.jsp" class="btn-floating tooltipped" data-position="left" data-delay="40" data-tooltip="Deconnexion"><i class="material-icons">lock_outline</i></a></li>
            </ul>
        </div>
</body>
</html>
