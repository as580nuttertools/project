<%@ include file="ck_session_admin.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*"%>
<%@ include file="config.jsp"%>
<%
	String b_id = request.getParameter("b_id");
	if (b_id != null) {
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, user, pw);
		Statement stmt = con.createStatement();
		String sql = "delete from book where b_id='" + b_id + "'";
		stmt.executeUpdate(sql);
	}
	response.sendRedirect("book_list.jsp");
%>
