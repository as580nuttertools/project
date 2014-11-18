<%@ include file="ck_session_admin.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="config.jsp"%>
<%@ include file="header_admin.jsp"%>
<%
	String bt_id = request.getParameter("bt_id");
	Vector errors = new Vector();
	if (bt_id != null) {
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, user, pw);
		Statement stmt = con.createStatement();
		String sql;
		ResultSet rs = null;
		//ตรวจสอบว่าประเภทหนังสือนี้ถูกหนังสือใดใช้อยู่หรือไม่
		sql = "select * from book where bt_id='" + bt_id + "'";
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			errors.add("ประเภทหนังสือนี้ไม่สามารถลบได้ เพราะมีหนังสือใช้งานอยู่");
		}
		if (errors.size() > 0) {
%><%@ include file="ckError.jsp"%>
<%
	} else {
			sql = "delete from booktype where bt_id='" + bt_id + "'";
			stmt.executeUpdate(sql);
			response.sendRedirect("book_list.jsp");
		}
	}
%>
