<%@ include file="ck_session_admin.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="config.jsp"%>
<%@ include file="m_date.jsp"%>

<script language="JavaScript" type="text/JavaScript">
	function MM_openBrWindow(theURL, winName, features) {
		window.open(theURL, winName, features);
	}
</script>
<%
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	
	int totalRow = 0;
	//หาจำนวนหนังสือ
	String sql = "select  count(*) as totalRow from orders,user where orders.cus_id=user.cus_id and orders.status = 6";
	ResultSet rs = stmt.executeQuery(sql);
	while (rs.next()) {
		totalRow = rs.getInt("totalRow");
	}
	rs.close();
	sql = "select * from orders,user where orders.cus_id=user.cus_id and orders.status = 6 and orders.order_id like '%%' order by orders.order_id desc";
	rs = stmt.executeQuery(sql);
	boolean Empty = !rs.next();
%><br>
<table width="90%" border="1" align="center" bordercolor="black"
	cellspacing="0" bgcolor="#79CDCD">
	<tr>
		<td align="center"><b>รายการสั่งซื้อ</b></td>
	</tr>
	<tr bgcolor="#CCCCCC">
		<td align="right"><a href="admin_data_orders_menu.jsp"
			class=Button>รายการสั่งซื้อ</a> <a href="admin_data_wait_menu.jsp"
			class=Button>รอลูกค้ามารับสินค้า</a> <a
			href="admin_data_selled_menu.jsp" class=Button>ขายแล้ว</a> <a
			href="admin_data_cancel_menu.jsp" class=Button>ยกเลิกการขาย</a> <a
			href="admin_data_orders_menu_order.jsp" class=Button>รายการสั่งซื้อ(คลัง)</a> <a
			href="admin_data_orders_menu_ordered.jsp" class=Button>รายการซื้อ(คลัง)</a></td>
	</tr>
</table>
<br>
<%
	out.println("<center>รายการสั่งซื้อทั้งหมด " + totalRow
			+ " รายการ</center>");
%>
<br>
<form name="frmSearch" method="post"
	action="admin_data_orders_menu_order.jsp">
	<table width="90%" border="1" align="center" cellspacing="0"
		bordercolor="black" bgcolor="#E1EEEE">
		<tr bgcolor="#79CDCD">
			<td align="center"><b>รหัสสั่งซื้อ</b></td>
			<td align="center"><b>ผู้สั่งซื้อ</b></td>
			<td align="center"><b>วันที่สั่งซื้อ</b></td>
			<td align="center"><b>สถานะการสั่งซื้อ</b></td>
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
			<td align="center">
				<%
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
							if (rs.getString("status").equals("5")) {
								out.println("กำลังสั่งซื้อ");
							}
							if (rs.getString("status").equals("6")) {
								out.println("รับสินค้าแล้ว");
							}
				%> </a>
			</td>
			<td align="center"><input name="print_detail" type="button"
				onClick="MM_openBrWindow('print_order_detail_out.jsp?order_id=<%=rs.getString("order_id")%>','','width=650,height=700')"
				value="ดูใบสั่งซื้อ"></td>
		</tr>
		<%
			} while (rs.next());
				rs.close();
				con.close();
			} catch (Exception e) {
		%>
	</table>
</form>
<br>
<%
	}
	rs.close();
	con.close();
%>
