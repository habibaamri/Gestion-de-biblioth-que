<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tags" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Emprunt</title>
</head>
<body>
<jsp:useBean id="Date" class="java.util.Date" />
<sql:setDataSource var="ds" driver="${initParam['jdbc/library']}" url="${initParam['Biblio']}" user="root" password="" scope="session"/>

<sql:query dataSource="${ds}" var="TestNbrLivre" sql="SELECT COUNT(Livre) as NbrMax FROM notice WHERE Adherent =${sessionScope['UserId']}" />
<c:forEach items="${TestNbrLivre.rows}" var="X">
	<c:choose>
		<c:when test="${X.NbrMax >= 3}">
			<c:redirect url="Erreur.jsp">
				<c:param name="errMsg" value="Vous avez déjà 3 livres c'est le nombre max  ^__^ " />
			</c:redirect>
		</c:when>
		<c:when test="${X.NbrMax < 3}">
			<!-- Enregistrement du Livre Emprunté  -->
			<sql:query dataSource="${ds}" var="livres" sql="select * from livre where Id='${param.livreID}' "/>
			 <c:forEach items="${livres.rows}" var="livre">
		        <c:choose>
		          <c:when test="${livres.rows[0].NbrExemplaire == 1}" >
		          		<sql:update dataSource="${ds}" var="disponibilité">
		          			UPDATE livre SET NbrExemplaire=NbrExemplaire-1,Disponibilité='non' WHERE Id='${param.livreID}'
		          		</sql:update>
					    <sql:update dataSource="${ds}" var="Notice"> 
							INSERT INTO notice(Livre,BandeDessine,GuideVoyage,Adherent,DatePret,DateRetour,Etat,) VALUES (?, ?, ?, ?, ?, ?, ?)
								<sql:param value="${param.livreID}" />
								<sql:param value="0" />
								<sql:param value="0" />
								<sql:param value="${sessionScope['UserId']}" />
								<sql:dateParam value="${Date}" type="Date" />  
								<sql:param value="" />  
								<sql:param value="Bonne" />
						</sql:update>
		          		<c:redirect url="Historique.jsp">
			              <c:param name="MsgConfirmation" value="Le livre a été Emprunté avec Succés veuillez aller le recupérer ^__^ " />
		          		</c:redirect>
		          	</c:when>
		          	<c:when test="${livres.rows[0].NbrExemplaire > 1}">
		          		<sql:update dataSource="${ds}" var="disponibilité">
		          			UPDATE livre SET NbrExemplaire=NbrExemplaire-1 WHERE Id='${param.livreID}'
		          		</sql:update>
					    <sql:update dataSource="${ds}" var="Notice"> 
							INSERT INTO notice(Livre,BandeDessine,GuideVoyage,Adherent,DatePret,DateRetour,Etat) VALUES (?, ?, ?, ?, ?, ?, ?)
								<sql:param value="${param.livreID}" />
								<sql:param value="0" />
								<sql:param value="0" />
								<sql:param value="${sessionScope['UserId']}" />
								<sql:dateParam value="${Date}" type="Date" />  
								<sql:param value="" />  
								<sql:param value="Bonne" />
						</sql:update>
						<c:redirect url="Historique.jsp">
			              <c:param name="MsgConfirmation" value="Le livre a été Emprunté avec Succés veuillez aller le recupérer ^__^ " />
		          		</c:redirect>
		          	</c:when>
			   	 	<c:otherwise>
			   	 		 <c:redirect url="Erreur.jsp">
			   	  			<c:param name="errMsg" value="Le livre n'est pas disponible ^__^ " />
			   	  		</c:redirect>
			   	 	</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:when>
	</c:choose>
</c:forEach>


<sql:query dataSource="${ds}" var="TestNbrBD" sql="SELECT COUNT(BandeDessine) as NbrMax FROM `notice` WHERE Adherent =${sessionScope['UserId']}" />
<c:forEach items="${TestNbrBD.rows}" var="B">
	<c:choose>
		<c:when test="${B.NbrMax >= 5}">
			<c:redirect url="Erreur.jsp">
				<c:param name="errMsg" value="Vous avez déjà 5 Bandes Déssinée c'est le nombre max  ^__^ " />
			</c:redirect>
		</c:when>
		<c:when test="${B.NbrMax < 5}">
			<!-- Enregistrement du BD Emprunté-->
			<sql:query dataSource="${ds}" var="BDs" sql="select * from bandedessine where Id='${param.IdBd}' "/>
				 <c:forEach items="${BDs.rows}" var="BD">
			        <c:choose>
			          <c:when test="${BD.NbrExemplaire <= 1}" >
							<sql:update dataSource="${ds}" var="disponibilité">
			          			UPDATE bandedessine SET  NbrExemplaire=NbrExemplaire-1,Disponibilité='non' WHERE Id='${param.IdBd}'
			          		</sql:update>
						    <sql:update dataSource="${ds}" var="Notice"> 
								INSERT INTO notice(Livre,BandeDessine,GuideVoyage,Adherent,DatePret,DateRetour,Etat) VALUES (?, ?, ?, ?, ?, ?, ?)
									<sql:param value="0" />
									<sql:param value="${param.IdBd}" />
									<sql:param value="0" />
									<sql:param value="${sessionScope['UserId']}" />
									<sql:dateParam value="${Date}" type="Date" />  
									<sql:param value="" />  
									<sql:param value="Bonne" />
							</sql:update>
			          		<c:redirect url="Historique.jsp">
				              <c:param name="MsgConfirmation" value="La Bande Dessinée a été Emprunté avec Succés veuillez aller la recupérer ^__^ " />
			          		</c:redirect>
			          </c:when>
			          <c:when test="${BD.NbrExemplaire > 1}">
			          		<sql:update dataSource="${ds}" var="disponibilité">
			          			UPDATE bandedessine SET NbrExemplaire=NbrExemplaire-1 WHERE Id='${IdBd}'
			          		</sql:update>
						    <sql:update dataSource="${ds}" var="Notice"> 
								INSERT INTO notice(Livre,BandeDessine,GuideVoyage,Adherent,DatePret,DateRetour,Etat) VALUES (?, ?, ?, ?, ?, ?, ?)
									<sql:param value="0" />
									<sql:param value="${param.IdBd}" />
									<sql:param value="0" />
									<sql:param value="${sessionScope['UserId']}" />
									<sql:dateParam value="${Date}" type="Date" />  
									<sql:param value="" />  
									<sql:param value="Bonne" />
							</sql:update>
							<c:redirect url="Historique.jsp">
				              <c:param name="MsgConfirmation" value="La Bande Dessinée a été Emprunté avec Succés veuillez aller la recupérer ^__^ " />
			          		</c:redirect>
			          	</c:when>
				   	  <c:otherwise>
				   	  	<c:redirect url="Erreur.jsp">
				   	  		<c:param name="errMsg" value="La Bande Dessinée n'est pas disponible ^__^ " />
				   	  	</c:redirect>
				   	  </c:otherwise>
					</c:choose>         
				</c:forEach>
		</c:when>	
	</c:choose>
</c:forEach>


<sql:query dataSource="${ds}" var="TestNbrGV" sql="SELECT COUNT(GuideVoyage) as NbrMax FROM `notice` WHERE Adherent =${sessionScope['UserId']}" />
<c:forEach items="${TestNbrGV.rows}" var="G">
	<c:choose>
		<c:when test="${G.NbrMax >= 2}">
			<c:redirect url="Erreur.jsp">
				<c:param name="errMsg" value="Vous avez déjà 2 Guides De Voyage c'est le nombre max  ^__^ " />
			</c:redirect>
		</c:when>
		<c:when test="${G.NbrMax < 2}">
			<!--  Enregsitrement des Guides de Voyages-->
			<sql:query dataSource="${ds}" var="GVs" sql="select * from guide_voyage where Id='${param.IdGV}' "/>
			 <c:forEach items="${GVs.rows}" var="gv">
		        <c:choose>
		          <c:when test="${gv.NbrExemplaire <= 1}" >
						<sql:update dataSource="${ds}" var="disponibilité">
		          			UPDATE guide_voyage SET  NbrExemplaire=NbrExemplaire-1,Disponibilité='non' WHERE Id='${param.IdGV}'
		          		</sql:update>
					    <sql:update dataSource="${ds}" var="Notice"> 
							INSERT INTO notice(Livre,BandeDessine,GuideVoyage,Adherent,DatePret,DateRetour,Etat) VALUES (?, ?, ?, ?, ?, ?, ?)
								<sql:param value="0" />
								<sql:param value="0" />
								<sql:param value="${param.IdGV}" />
								<sql:param value="${sessionScope['UserId']}" />
								<sql:dateParam value="${Date}" type="Date" />  
								<sql:param value="" />  
								<sql:param value="Bonne" />
						</sql:update>
		          		<c:redirect url="Historique.jsp">
			              <c:param name="MsgConfirmation" value="Le Guide de Voyage a été Emprunté avec Succés veuillez aller le recupérer ^__^ " />
		          		</c:redirect>
		          </c:when>
		          <c:when test="${gv.NbrExemplaire > 1}">
		          		<sql:update dataSource="${ds}" var="disponibilité">
		          			UPDATE guide_voyage SET NbrExemplaire=NbrExemplaire-1 WHERE Id='${param.IdGV}'
		          		</sql:update>
					    <sql:update dataSource="${ds}" var="Notice"> 
							INSERT INTO notice(Livre,BandeDessine,GuideVoyage,Adherent,DatePret,DateRetour,Etat) VALUES (?, ?, ?, ?, ?, ?, ?)
								<sql:param value="0" />
								<sql:param value="0" />
								<sql:param value="${param.IdGV}" />
								<sql:param value="${sessionScope['UserId']}" />
								<sql:dateParam value="${Date}" type="Date" />  
								<sql:param value="" />  
								<sql:param value="Bonne" />
						</sql:update>
						<c:redirect url="Historique.jsp">
			              <c:param name="MsgConfirmation" value="Le Guide de Voyage a été Emprunté avec Succés veuillez aller le recupérer ^__^ " />
		          		</c:redirect>
		          	</c:when>
			   	  <c:otherwise>
			   	  	<c:redirect url="Erreur.jsp">
			   	  		<c:param name="errMsg" value="Le Guide de Voyage n'est pas disponible ^__^ " />
			   	  	</c:redirect>
			   	  </c:otherwise>
				</c:choose>          
			</c:forEach>	
		</c:when>
	</c:choose>
</c:forEach>


</body>
</html>