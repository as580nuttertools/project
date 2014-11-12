<%@ include file="ck_session_admin.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*"%>
<%@ include file="header_admin.jsp"%>
<%@ include file="config.jsp"%>
<%
	String order_id = request.getParameter("order_id");
	String status = request.getParameter("status");
	if (request.getParameter("Submit") != null) {
		status = request.getParameter("select");
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, user, pw);
		Statement stmt = con.createStatement();
		String sql = "update orders set status=" + status
				+ " where order_id=" + order_id;
		stmt.executeUpdate(sql);
		response.sendRedirect("admin_data_orders.jsp");
	} else {
%>
<form method="post" action="chang_status.jsp">
	<table width="40%" border="1" align="center" cellspacing="0"
		bordercolor="black">
		<tr>
			<th scope="col">เปลี่ยนสถานะการสั่งซื้อ</th>
		</tr>
		<tr>
			<td><p>
					เลือกสถานะการสั่งซื้อ<br>
					 
					<input name="select" type="radio"
						value="1" <%if (status.equals("1")) {
					out.println("checked");
				}%>> ตรวจสอบการสั่งซื้อ <br> 
					
					<input name="select" type="radio"
						value="2" <%if (status.equals("2")) {
					out.println("checked");
				}%>> รอรับสินค้า <br>
					 
					<input name="select" type="radio"
						value="3" <%if (status.equals("3")) {
					out.println("checked");
				}%>> ขายแล้ว <br> 
					 
					<input name="select" type="radio"
						value="4" <%if (status.equals("4")) {
					out.println("checked");
				}%>> ยกเลิกการขาย <br> 
				
				</p>
				<div align="left">
					<input name="order_id" type="hidden" value="<%=order_id%>">
					<input type="submit" name="Submit" value="เปลี่ยน">
				</div></td>
		</tr>
	</table>
</form>
<%
	}
%>
