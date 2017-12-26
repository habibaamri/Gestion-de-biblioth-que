<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/tags" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Validation</title>
</head>
<body>
<sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root" password="" scope="session"/>
<sql:update dataSource="${ds}" var="validation">
	UPDATE notice SET DateRetour='${param.Date}' WHERE Id='${param.id}'
</sql:update>
<c:redirect url="AcceuilAssist.jsp"/>
</body> 
</html>
