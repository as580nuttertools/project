<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="config.jsp"%>
<%@ include file="m_date.jsp"%>
<jsp:useBean id="cart" class="ktpbook.ProductCart" scope="session" />
<%
	String order_id = request.getParameter("order_id");
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql = "";
	ResultSet rs = null;

	sql = "select * from order_items,book where book.b_id=order_items.b_id and order_id='"
			+ order_id + "'";
	rs = stmt.executeQuery(sql);
	while (rs.next()) {
		sql = "update orders set  status='2' where order_id="
				+ order_id;

		stmt.executeUpdate(sql);

	}
	rs.close();
	con.close();
	response.sendRedirect("admin_data_orders_menu.jsp");
%>
