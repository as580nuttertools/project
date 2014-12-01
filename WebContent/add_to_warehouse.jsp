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
	float sum = 0;
	float amount = 0;
	while (rs.next()) {
		sum = rs.getInt("item_price")
				* rs.getInt("order_items.quantity");
		int quantitydb = rs.getInt("book.quantity");
		int quantitybuy = rs.getInt("order_items.quantity");
		amount += sum;
		String b_id = rs.getString("b_id");
		quantitydb = quantitydb + quantitybuy;

		sql = "update book set  quantity='" + quantitydb + "',status='1' where b_id=" + b_id;

		stmt.executeUpdate(sql);

		sql = "update orders set  status='6' where order_id="
				+ order_id;

		stmt.executeUpdate(sql);

	}
	rs.close();
	con.close();
	float vat = (amount * 7) / 100;
	amount = amount + vat;
	response.sendRedirect("admin_data_orders_menu_order.jsp");
%>
