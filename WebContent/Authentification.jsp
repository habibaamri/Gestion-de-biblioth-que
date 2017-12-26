<%@ page language="java" contentType="text/html;  charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tags" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>
	<sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root"  password=""/>
	<c:if test="${ empty param.username or empty param.password}">
      <c:redirect url="Erreur.jsp" >
              <c:param name="errMsg" value="SVP veeuillez saisir le Login et le Mot De Passe ^__^ " />
      </c:redirect>
  	</c:if> 
  	<c:choose>
    <c:when test="${not empty param.username and not empty param.password}">
	<sql:query dataSource="${ds}" var="adherents" sql="select * from adherent where Login='${param.username}' and MotDePasse='${param.password}'"/>
	<sql:query dataSource="${ds}" var="Bibliothecaires" sql="select * from Bibliothecaire where Login='${param.username}' and MotDePasse='${param.password}'"/>
	<sql:query dataSource="${ds}" var="Assistants" sql="select * from Assistant where Login='${param.username}' and MotDePasse='${param.password}'"/>
      
      <!-- Test Si Adherent -->
        <c:forEach items="${adherents.rows}" var="r">
        <c:choose>
          <c:when test="${ not empty adherents.rows }">
           	 <c:choose>
	           	<c:when test="${adherents.rows[0].SiVerifie}">
	           		<c:set scope="session"  var="loginUser" value="${adherents.rows[0].Nom} ${adherents.rows[0].Prenom}"/>
		            <c:set scope="session"  var="UserId" value="${adherents.rows[0].Id}"/>
		            <c:set scope="session"  var="PhotoUser" value="${adherents.rows[0].Photo}"/>
		            <c:redirect url="Acceuil.jsp"/>
	           	</c:when> 
	           	<c:otherwise>
		           	<c:redirect url="Erreur.jsp" >
	              		<c:param name="errMsg" value="Votre inscription n'est pas encore validée !!!" />
	            	</c:redirect>
	           	</c:otherwise>
	          </c:choose>	
          </c:when>
        </c:choose>
      </c:forEach>
      <!-- Test Si Admin -->
      <c:forEach items="${Bibliothecaires.rows}" var="r">
      	<c:choose>
      	 	<c:when test="${ not empty Bibliothecaires.rows}">
			    <c:set scope="session"  var="loginUser" value="Administrateur" />
			   	<c:set scope="session"  var="UserId" value="${Bibliothecaires.rows[0].Id}"/>
	            <c:set scope="session"  var="PhotoUser" value="${Bibliothecaires.rows[0].Photo}"/>
			   	<c:redirect url="AcceuilAdmin.jsp"/>
			</c:when>
			<c:otherwise>
				<c:redirect url="Erreur.jsp" >
	             	<c:param name="errMsg" value="Vous n'etes pas Admin hihihhi !!!" />
	            </c:redirect>
			</c:otherwise>
      	</c:choose>     
	</c:forEach>
	 <!-- Test Si Assistant -->
      <c:forEach items="${Assistants.rows}" var="r">
      	<c:choose>
	        <c:when test="${ not empty Assistants.rows }">
	        	<c:set scope="session"  var="loginUser" value="Assistant" />
	          	<c:set scope="session"  var="UserId" value="${Assistants.rows[0].Id}"/>
	          	<c:set scope="session"  var="PhotoUser" value="${Assistants.rows[0].Photo}"/>
	          	<c:redirect url="AcceuilAssist.jsp"/>
	        </c:when>
			<c:otherwise>
				<c:redirect url="Erreur.jsp" >
	             	<c:param name="errMsg" value="Vous n'etes pas parmi les Assistants !!!" />
	            </c:redirect>
			</c:otherwise>
      	</c:choose>     
	</c:forEach>
    </c:when>
    <c:otherwise>
            <c:redirect url="Erreur.jsp" >
              <c:param name="errMsg" value="Login Ou MotDePasse incorrecte !!" />
            </c:redirect>
     </c:otherwise>
    </c:choose>
    <c:redirect url="Erreur.jsp" >
	             	<c:param name="errMsg" value="Votre Login ou MotDePasse est Incorrecte !!!" />
	            </c:redirect>
    
</body>
</html>