<%@ include file="m_ckSession.jsp"%>
<%
	//µÃÇ¨ÊÍºÇèÒà¢éÒÊÙèÃÐººâ´ÂÅÙ¡¤éÒËÃ×ÍäÁè
	if (!isSession(session.getAttribute("j_username"),
			session.getAttribute("status"), "customer")) {
		response.sendRedirect("session_er.jsp");
	}
%>
