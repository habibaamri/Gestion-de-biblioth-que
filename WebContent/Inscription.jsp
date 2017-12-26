<%@ page language="java" contentType="text/html;  charset=UTF-8"
pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/tags" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Inscription</title>
</head>
<body>
	<sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root" password="" scope="session"/>
	<c:if test="${ empty param.nom or empty param.prenom or empty param.adresse or empty param.email or empty param.photo}">
     	<c:redirect url="index.jsp" >
              <c:param name="InscMsg" value="SVP veeuillez remplir tous les champs !!" />
      </c:redirect>
  	</c:if>
  	<c:if test="${not empty param.nom and not empty param.prenom and not empty param.adresse and not empty param.email and not empty param.photo}">
    <sql:update dataSource="${ds}" var="updatedTable"> 
	INSERT INTO adherent(Nom,Prenom,Adresse,Email,Login,MotDePasse,Photo,SiVerifie) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
		<sql:param value="${param.nom}" />
		<sql:param value="${param.prenom}" />
		<sql:param value="${param.adresse}" />
		<sql:param value="${param.email}" />
		<sql:param value="${param.prenom}" />
		<sql:param value="${param.prenom}${param.nom}" />
		<sql:param value="${param.photo}"/>
		<sql:param value="0"/>
	</sql:update>
	</c:if>
	<c:if test="${updatedTable>=1}">
	   <c:redirect url="index.jsp"></c:redirect>
	</c:if>
</body>
</html>
