<%@ include file="ck_session_admin.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="header.jsp"%>
<%
	String bt_id = request.getParameter("bt_id");
	String name = "", old_name = "";
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection con = DriverManager
			.getConnection("jdbc:mysql://localhost/ktpbook?user=root&password=1234");
	Statement stmt = con.createStatement();
	String sql = "select * from booktype where bt_id='" + bt_id + "'";
	ResultSet rs = stmt.executeQuery(sql);
	while (rs.next()) {
		name = new String(rs.getString("name").getBytes("ISO8859_1"),
				"windows-874");
	}
	rs.close();
	//ตรวจสอบว่ามีการกดปุ่มแก้ไขหรือไม่
	if (request.getParameter("Submit") != null) {
		Vector errors = new Vector();
		old_name = request.getParameter("old_name");
		name = request.getParameter("name");
		//ถ้าหากไม่ใช่ชื่อเดิม ตรวจสอบว่าชื่อใหม่ซ้ำกับชื่อที่อยู่ในฐานข้อมูลหรือไม่
		if (!name.equals(old_name)) {
			sql = "select  name from booktype where name ='" + name
					+ "'";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				errors.add("ชื่อประเภทหนังสือซ้ำ");
			}
		}
		if (name.equals("")) {
			errors.add("ตรวจสอบชื่อประเภทหนังสือ");
		}
		if (errors.size() > 0) {
%><%@ include file="ckError.jsp"%>
<%
	} else {
			sql = "update booktype set name='" + name
					+ "' where bt_id='" + bt_id + "'";
			int row = stmt.executeUpdate(sql);
			if (row != 0) {
				rs.close();
				con.close();
				response.sendRedirect("book_type_list_menu.jsp");
			}
		}
	} else {
%>
<br>
<form action="edit_btype.jsp" method="post">
	<table width="50%" border="1" align="center" cellspacing="0"
		bordercolor="black" bgcolor="#E1EEEE">
		<tr bgcolor="#79CDCD">
			<td colspan="2" align="center"><strong>แก้ไขประเภทหนังสือ</strong></td>
		</tr>
		<tr>
			<td width="30%"><b>ชื่อประเภทหนังสือ</b></td>
			<td width="70%"><input name="name" type="text" value="<%=name%>" maxlength="20"></td>
		</tr>
		<tr>
			<td colspan="2"><div align="center">
					<input name="bt_id" type="hidden" value="<%=bt_id%>"> <input
						name="old_name" type="hidden" value="<%=name%>"> <input
						type="submit" name="Submit" value="แก้ไข">
				</div></td>
		</tr>
	</table>
</form>
<%
	}
%>
