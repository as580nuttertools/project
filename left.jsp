<%@ page contentType="text/html; charset=windows-874"%>
<%
	if ((session.getAttribute("j_username") != null)
			&& (session.getAttribute("status").equals("customer"))) {
%>
<jsp:include page="form_customer_logout.jsp" />
<%
	} else {
%>
<jsp:include page="form_customer_login.jsp" />
<%
	}
%>
