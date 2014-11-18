<%@ include file="m_ckSession.jsp"%>
<%
	//ตรวจสอบว่าเข้าสู่ระบบโดยผู้ลูกค้าแล้วหรือยัง
	if (!isSession(session.getAttribute("j_username"),
			session.getAttribute("status"), "customer")) {
		response.sendRedirect("session_er.jsp");
	}
%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ include file="header_user.jsp"%>
<br>
<br>
<table width="55%" border="1" align="center">
	<tr>
		<td>
			<center>
				<b>ยินดีต้อนรับคุณ <%=session.getAttribute("j_fname")%> <%=session.getAttribute("j_lname")%>
					เข้าสู่เมนูลูกค้า <br>
				<br>สามารถจัดการรายการต่างๆ โดยเลือกเมนูด้านบน
				</b><br>
			</center>
		</td>
	</tr>
</table>
