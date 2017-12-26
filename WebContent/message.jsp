<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/tags" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>supprimer un assistant</title>
</head>
<body>
 <sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root"  password=""/>
	
	<sql:update dataSource="${ds}" var="updatedTable"> 	
		update notice set message ='1' where Id =${param.idnotic}
	</sql:update>
	
	<c:if test="${updatedTable>=1}">
	   <c:redirect url="AcceuilAdmin.jsp"></c:redirect>
	</c:if>
</body>
</html>