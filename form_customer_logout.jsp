<%@ page contentType="text/html; charset=windows-874"%>
<form action="logout.jsp" method="post">
	<table width="150" border="0">
		<tr>
			<td width="98%" bgcolor="#99CCFF"><div align="center">
					<strong>LOGOUT</strong>
				</div></td>
		</tr>
		<tr>
			<td><div align="center">ยินดีต้อนรับ</div></td>
		</tr>
		<tr>
			<td><div align="center">
					คุณ
					<%=session.getAttribute("j_fname")%>
					<%=session.getAttribute("j_lname")%></div></td>
		</tr>
		<tr>
			<td><div align="center"></div></td>
		</tr>
		<tr>
			<td><div align="center"></div></td>
		</tr>
		<tr>
			<td><div align="center">
					<input name="Submit" type="submit" value="Logout">
				</div></td>
		</tr>
		<tr>
			<td><div align="center">
					<a href="customer.jsp">เมนูสมาชิก</a>
				</div></td>
		</tr>
	</table>
</form>
