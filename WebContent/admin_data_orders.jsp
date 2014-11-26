<%@ include file="ck_session_admin.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*"%>
<%@ include file="config.jsp"%>
<%@ include file="m_date.jsp"%>
<%
	String keyword = "";
	if (request.getParameter("keyword") != null) {
		keyword = request.getParameter("keyword");
	}
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	int totalRow = 0;
	//หาจำนวนหนังสือ
	String sql = "select  count(*) as totalRow from orders,user where orders.cus_id=user.cus_id and orders.status = 1 order by orders.order_id desc";
	ResultSet rs = stmt.executeQuery(sql);
	while (rs.next()) {
		totalRow = rs.getInt("totalRow");
	}
	rs.close();
	sql = "select * from orders,user where orders.cus_id=user.cus_id and orders.status = 1 and orders.order_id like '%"
			+ keyword + "%' order by orders.order_id desc";
	rs = stmt.executeQuery(sql);
	int count = 0;
	boolean Empty = !rs.next();
%><br>
<table width="90%" border="1" align="center" bordercolor="black"
	cellspacing="0" bgcolor="#79CDCD">
	<tr>
		<td align="center"><b>ข้อมูลการสั่งซื้อ</b></td>
	</tr>
	<tr bgcolor="#CCCCCC">
		<td align="right"><a href="admin_data_orders_menu.jsp"
			class=Button>รายการสั่งซื้อ</a> <a href="admin_data_wait_menu.jsp"
			class=Button>รอลูกค้ามารับสินค้า</a> <a
			href="admin_data_selled_menu.jsp" class=Button>ขายแล้ว</a> <a
			href="admin_data_cancel_menu.jsp" class=Button>ยกเลิกการขาย</a></td>
	</tr>
</table>
<br>
<form name="frmSearch" method="post" action="admin_data_orders_menu.jsp">
	<table width="90%" border="1" align="center" cellspacing="0"
		bordercolor="black" bgcolor="#79CDCD">
		<tr align="center">
			<td><b>ค้นหา</b> <input name="keyword" type="text" id="keyword"
				value="<%=keyword%>"> <input type="submit" value="ค้นหา">
		</tr>
	</table>
</form>
<%
	out.println("<center>รายการสั่งซื้อ " + totalRow
			+ " รายการ</center>");
%>
<br>
<table width="90%" border="1" align="center" cellspacing="0"
	bordercolor="black" bgcolor="#E1EEEE">
	<tr bgcolor="#79CDCD">
		<td align="center"><b>รหัสสั่งซื้อ</b></td>
		<td align="center"><b>ผู้สั่งซื้อ</b></td>
		<td align="center"><b>วันที่สั่งซื้อ</b></td>
		<td align="center"><b>เปลี่ยนสถานะการสั่งซื้อ</b></td>
		<td align="center"><b>ดูใบสั่งซื้อ</b></td>
	</tr>
	<%
		try {
			do {
	%>
	<tr>
		<td align="center"><%=rs.getString("order_id")%></td>
		<td><%=new String(rs.getString("fname").getBytes(
							"ISO8859_1"), "windows-874")%> <%=new String(rs.getString("lname").getBytes(
							"ISO8859_1"), "windows-874")%></td>
		<td align="center"><%=dateTH(rs.getString("date"))%></td>
		<td align="center"><a
			href="chang_status.jsp?order_id=<%=rs.getString("order_id")%>&status=<%=rs.getString("status")%>"
			class="button"> <%
 	if (rs.getString("status").equals("1")) {
 				out.println("ตรวจสอบการสั่งซื้อ");
 			}
 			if (rs.getString("status").equals("2")) {
 				out.println("รอรับสิ้นค้า");
 			}
 			if (rs.getString("status").equals("3")) {
 				out.println("ขายแล้ว");
 			}
 			if (rs.getString("status").equals("4")) {
 				out.println("ยกเลิกการขาย ");
 			}
 %>
		</a></td>
		</td>
		<td align="center"><a
			href="order_detail_in.jsp?order_id=<%=rs.getString("order_id")%>"
			class="button">ดูใบสั่งซื้อ</a></td>
	</tr>
	</tr>
	<%
		count++;
			} while (rs.next());
			rs.close();
			con.close();
		} catch (Exception e) {
	%>
</table>
<br>
<%
	out.println("<center>ไม่มีรายการสั่งซื้อที่ค้นหา</center>");
	}
	rs.close();
	con.close();
%>
</table>
