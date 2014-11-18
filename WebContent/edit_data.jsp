<%@ include file="ck_session_customer.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ include file="header_user.jsp"%>
<br>
<table width="50%" align="center" cellspacing="0">
	<tr bgcolor="#ECE9D8">
		<td colspan="2">รายละเอียดโดยย่อ</td>
	</tr>
	<tr>
		<td width="40%">username</td>
		<td width="60%"><%=session.getAttribute("j_username")%></td>
	</tr>
	<tr>
		<td>email</td>
		<td><%=session.getAttribute("j_email")%></td>
	</tr>
	<tr>
		<td>ชื่อ</td>
		<td><%=session.getAttribute("j_fname")%></td>
	</tr>
	<tr>
		<td>นามสกุล</td>
		<td><%=session.getAttribute("j_lname")%></td>
	</tr>
	<tr bgcolor="#ECE9D8">
		<td colspan="2"><a href="edit_data_private.jsp">
				แก้ไขข้อมูลส่วนตัว</a> | <a href="edit_data_login.jsp">แก้ไขรหัสผ่าน</a>
			| <a href="edit_data_address.jsp?pay=no">แก้ไขที่อยู่ในการส่งสินค้า</a></td>
	</tr>
</table>
