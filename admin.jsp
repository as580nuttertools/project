<%@ include file="m_ckSession.jsp"%>
<%
	//ตรวจสอบว่าเข้าสู่ระบบแล้วโดยผู้ดูแลระบบแล้วหรือยัง
	if (!isSession(session.getAttribute("j_username"),
			session.getAttribute("status"), "admin")) {
		response.sendRedirect("session_er.jsp");
	}
%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ include file="header_admin.jsp"%>
<br>
<br>
<table width="60%" border="1" align="center">
	<tr>
		<td>
			<center>
				<b>ยินดีต้อนรับคุณ <%=session.getAttribute("j_fname")%> <%=session.getAttribute("j_lname")%>
					เข้าสู่เมนูผู้ดูแลระบบ <br>
				<br>สามารถจัดการรายการต่างๆ โดยเลือกเมนูด้านบน
				</b>
			</center>
		</td>
	</tr>
</table>
