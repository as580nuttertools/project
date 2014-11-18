<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="header.jsp"%>
<%@ include file="config.jsp"%>
<%
	Vector errors = new Vector();
	String j_username = request.getParameter("j_username");
	String j_password = request.getParameter("j_password");
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
	if (j_username.equals("") || j_password.equals("")) {
		errors.add("ตรวจสอบ username หรือ password");
	} else {
		//ตรวจสอบ username และ password ว่ามีอยู่จริงหรือไม่
		sql = "select * from admin where username ='" + j_username
				+ "' and password='" + j_password + "'";
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			session.setAttribute("status", "admin");
			session.setAttribute("j_username", j_username);
			session.setAttribute(
					"j_fname",
					new String(rs.getString("fname").getBytes(
							"ISO8859_1"), "windows-874"));
			session.setAttribute(
					"j_lname",
					new String(rs.getString("lname").getBytes(
							"ISO8859_1"), "windows-874"));
			session.setAttribute("j_email", rs.getString("email"));
		} else {
			errors.add("ชื่อ username หรือ password ไม่ถูกต้อง");
		}
	}
	if (errors.size() > 0) {
%><%@ include file="ckError.jsp"%>
<%
	} else {
		response.sendRedirect("admin_alert.jsp");
	}
%>
