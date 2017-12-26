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
	       	
	<div class="col s4"  >
	       	
	  <form id="assistantForm" method="POST" action="" class="collection">
				  <div class="row">
				            <div class="input-field col s5">
				            	 <input type="text" class="validate" name="Nom" >
				                <label for="username" class="active">Nom</label>
				            </div>
				
				              <div class="input-field col s5">
				            	 <input type="text" class="validate" name="Prenom" >
				                <label for="username" class="active">Prenom</label>
				            </div>
				   </div>
				 
			    <div class="row">
			     <div class="file-field input-field col s8 push-s2">
		                               <div class="btn">
									        <span>Photo</span>
									        <input type="file">
									    </div>
									      <div class="file-path-wrapper">
									        <input class="file-path validate" type="text" name="photo" placeholder="Upload .. ">
									      </div>
								    	</div> 
						       <div class="input-field col s8">
						            <button class="secondary-content" type="submit" name="action" style="float: right;">
						                      <i class="material-icons">add</i> </button>
						        </div> 
		           </div>
        </form>
    </div>
    </div>
	 <c:if test="${pageContext.request.method =='POST'}">
	 <sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root" password="" scope="session"/>
	<c:if test="${ empty param.Nom or empty param.Prenom or empty param.photo  }">
     	<c:redirect url="addassistant.jsp" >
              <c:param name="InscMsg" value="SVP veeuillez remplir tous les champs !!" />
      </c:redirect>
      </c:if>
  	</c:if>
  	<c:if test="${not empty param.Prenom and not empty param.Nom  and not empty param.photo  }">
      <sql:update dataSource="${ds}" var="updatedTable"> 
	INSERT INTO assistant(Nom,Prenom,Login,MotDePasse,Photo) VALUES (?, ?, ?, ?,?)
		<sql:param value="${param.Nom}" />
		<sql:param value="${param.Prenom}" />
		<sql:param value="${param.Nom}" />
		<sql:param value="${param.Prenom}${param.Nom}" />
		<sql:param value="${param.photo}" />
	</sql:update>
	<c:if test="${updatedTable>=1}">
	   <c:redirect url="AcceuilAdmin.jsp"></c:redirect>
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
