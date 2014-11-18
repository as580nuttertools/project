<%@ include file="ck_session_admin.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*"%>
<%@ include file="header_admin.jsp"%>
<%@ include file="config.jsp"%>
<%@ include file="m_date.jsp"%>
<%
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql = "select * from orders,customer where orders.cus_id=customer.cus_id order by orders.order_id desc";
	ResultSet rs = stmt.executeQuery(sql);
	boolean Empty = !rs.next();
	if (Empty) {
		rs.close();
		out.println("<center>ยังไม่มีข้อมูลการสั่งซื้อ</center>");
	} else {
%><br>
<table width="85%" border="1" align="center" bordercolor="black"
	cellspacing="0" bgcolor="#79CDCD">
	<tr>
		<td align="center"><b>ข้อมูลการสั่งซื้อ</b></td>
	</tr>
</table>
<br>
<table width="70%" border="1" align="center" cellspacing="0"
	bordercolor="black" bgcolor="#E1EEEE">
	<tr bgcolor="#79CDCD">
		<td align="center"><b>รหัสสั่งซื้อ</b></td>
		<td align="center"><b>ผู้สั่งซื้อ</b></td>
		<td align="center"><b>วันที่สั่งซื้อ</b></td>
		<td align="center"><b>เปลี่ยนสถานะการสั่งซื้อ</b></td>
		<td align="center"><b>ดูใบสั่งซื้อ</b></td>
	</tr>
	<%
		do { 	
	%>
	<%
		//highlight
				if (rs.getString("status").equals("1")) {
	%><tr bgcolor="#00FFFF">
		<%
			} else if (rs.getString("status").equals("3")) {
				%><tr bgcolor="#7CFC00">
		<%} else if (rs.getString("status").equals("4")) {
				%><tr bgcolor="FF0000">
		<%} else {%>
	
	<tr bgcolor="#00FFFF">
	<tr>
		<%
			}
		%>
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
 				out.println("รับสิ้นค้า");
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
		} while (rs.next());
			rs.close();
	%>
</table>
<%
	}
%>
