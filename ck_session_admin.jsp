<%@ include file="m_ckSession.jsp"%>
<%
	//µÃÇ¨ÊÍºÇèÒà¢éÒÊÙèÃÐººâ´Â¼Ùé´ÙáÅÃÐººËÃ×ÍäÁè
	if (!isSession(session.getAttribute("j_username"),
			session.getAttribute("status"), "admin")) {
		response.sendRedirect("session_er.jsp");
	}
%>
