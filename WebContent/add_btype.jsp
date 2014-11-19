<%@ include file="ck_session_admin.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="header.jsp"%>
<%@ include file="config.jsp"%>
<%
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
	if (request.getParameter("Submit") != null) {
		String name = request.getParameter("name");
		Vector errors = new Vector();
		if (name.equals("")) {
			errors.add("ตรวจสอบชื่อประเภทหนังสือ");
		} else {
			//ตรวจสอบว่าชื่อประเภทหนังสือซ้ำหรือไม่
			sql = "select name from booktype where name='" + name + "'";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				errors.add("ชื่อประเภทหนังสือซ้ำ");
			}
		}
		if (errors.size() > 0) {
%><%@ include file="ckError.jsp"%>
<%
	} else {
			sql = "insert into booktype (name) VALUES ('" + name
					+ "') ";
			int row = stmt.executeUpdate(sql);
			if (row != 0) {
				rs.close();
				con.close();
				response.sendRedirect("book_type_list_menu.jsp");
			}
		}
	} else {
%>
<form action="add_btype.jsp" method="post">
	<table width="40%" border="1" align="center" cellspacing="0"
		bordercolor="black" bgcolor="#E1EEEE">
		<tr bgcolor="#79CDCD">
			<td colspan="2" align="center"><strong>เพิ่มประเภทหนังสือ</strong></td>
		</tr>
		<tr>
			<td width="39%"><b>ชื่อประเภทหนังสือ</b></td>
			<td width="61%"><input name="name" type="text" maxlength="20"></td>
		</tr>
		<tr>
			<td colspan="2"><div align="center">
					<input type="submit" name="Submit" value="ตกลง">
				</div></td>
		</tr>
	</table>
</form>
<%
	}
%>
