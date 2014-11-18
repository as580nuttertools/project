<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*"%>
<%@ include file="config.jsp"%>
<jsp:useBean id="cart" class="ktpbook.ProductCart" scope="session" />
<%
	String b_id = request.getParameter("b_id");
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql = "select * from book where b_id=" + b_id;
	ResultSet rs = stmt.executeQuery(sql);
	
	int x = 1;
	if (x > 0) {
		while (rs.next()) {
			cart.addItem(rs.getString("b_id"), rs.getString("title"),
					1, rs.getString("price"));
		}
	}
	rs.close();
	response.sendRedirect("view_cart.jsp");
%>
