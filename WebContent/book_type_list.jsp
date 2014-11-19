<%@include file="ck_session_admin.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*"%>
<%@ include file="config.jsp"%>
<div align="left">
	<%
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, user, pw);
		Statement stmt = con.createStatement();
		String sql;
		ResultSet rs = null;
	%><br>
	<table width="85%" border="1" align="center" bordercolor="black"
		cellspacing="0" bgcolor="#79CDCD">
		<tr>
			<td align="center"><b>ประเภทหนังสือ</b></td>
		</tr>
	</table>
	<br>
	<form method="post" action="book_list.jsp">
		<table width="60%" border="1" align="center" cellspacing="0"
			bordercolor="#000000" bgcolor="#E1EEEE">
			<tr bgcolor="#79CDCD">
				<td bgcolor="#79CDCD" align="center"><span
					style="font-weight: bold">ชื่อประเภทหนังสือ</span></td>
				<td width="10%" align="center"><span style="font-weight: bold">แก้ไข</span></td>
				<td width="10%" align="center"><span style="font-weight: bold">ลบ</span></td>
			</tr>
			<%
				sql = "select * from booktype";
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
			%>
			<tr>
				<td><%=new String(
						rs.getString("name").getBytes("ISO8859_1"),
						"windows-874")%></td>
				<td align="center"><a
					href="edit_btype.jsp?bt_id=<%=rs.getString("bt_id")%>"
					class="button">แก้ไข</a></td>
				<td align="center"><a
					href="del_btype.jsp?bt_id=<%=rs.getString("bt_id")%>"
					class="button">ลบ</a></td>
			</tr>
			<%
				}
				rs.close();
				con.close();
			%>
			<tr>
				<td colspan="3" align="center"><a href="add_btype.jsp"
					class="button">เพิ่มประเภทหนังสือ</a></td>
			</tr>
		</table>
	</form>
