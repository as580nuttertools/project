<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="header.jsp"%>
<%@ include file="config.jsp"%>
<jsp:useBean id="cart" class="ktpbook.ProductCart" scope="session" />
<%
	String order_id = "";

	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
	float sum = 0;
	float amount = 0;
	String[] temp;
	//ถ้ามีหนังสืออยู่ในรถเข็น
	if (cart.getItem().hasMoreElements()) {
		Enumeration enu = cart.getItem();
		while (enu.hasMoreElements()) {
			temp = (String[]) enu.nextElement();
			sum = Integer.parseInt(temp[2]) * Float.parseFloat(temp[3]);
			amount += sum;
		}
		//เพิ่มข้อมูลการสั่งซื้อเข้าในตาราง orders
		sql = "insert into orders (cus_id,amount,date,status) VALUES ('"
				+ session.getAttribute("cus_id")
				+ "','"
				+ amount
				+ "',NOW(),'1') ";
		stmt.executeUpdate(sql);
		//หารหัสสั่งซื้อ (order_id) ล่าสุด เพื่อนำไปใช้กำหนดค่าในฟิลด์ order_id ของตาราง order_item
		sql = "select max(order_id) as max_oid  from orders where cus_id='"
				+ session.getAttribute("cus_id") + "'";
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			order_id = rs.getString("max_oid");
		}
		//เพิ่มรายละเีอียดการสั่งซื้อเข้าในตาราง order_items 
		Enumeration e = cart.getItem();
		while (e.hasMoreElements()) {
			temp = (String[]) e.nextElement();
			sql = "insert into order_items (order_id,b_id,item_price,quantity) VALUES ('"
					+ order_id
					+ "','"
					+ temp[0]
					+ "','"
					+ temp[3]
					+ "','" + temp[2] + "') ";

			stmt.executeUpdate(sql);
		}
		cart.close();
		response.sendRedirect("thank.jsp");
	}
%>
