<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*"%>
<%@ include file="header_user.jsp"%>
<%@ include file="config.jsp"%>
<%@ include file="m_date.jsp"%>
<%
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql = "select * from orders where cus_id=" + session.getAttribute("cus_id") + " order by order_id desc";
	ResultSet rs = stmt.executeQuery(sql);
	boolean Empty = !rs.next();
	if (Empty) {
		out.println("<center>ยังไม่มีข้อมูลการสั่งซื้อ</center>");
	} else {
%>
<br>
<table width="85%" border="1" align="center" bordercolor="black"
	cellspacing="0" bgcolor="#79CDCD">
	<tr>
		<td align="center"><b>ข้อมูลการสั่งซื้อ</b></td>
	</tr>
</table>
<br>
<table width="60%" border="1" align="center" cellspacing="0"
	bordercolor="black" bgcolor="#E1EEEE">
	<tr bgcolor="#79CDCD">
		<td align="center"><b>รหัสสั่งซื้อ</b></td>
		<td align="center"><b>วันที่สั่งซื้อ</b></td>
		<td align="center"><b>สถานะการสั่งซื้อ</b></td>
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
		<td align="center"><%=rs.getString("order_id")%></a></td>
		<td align="center"><%=dateTH(rs.getString("date"))%></td>
		<td align="center">
			<%
			if (rs.getString("status").equals("1")) {
 				out.println("ตรวจสอบการสั่งซื้อ");
 			}
 			if (rs.getString("status").equals("2")) {
 				out.println("รับสิ้นค้า");
 			}
 			if (rs.getString("status").equals("3")) {
 				out.println("รับสินค้าแล้ว");
 			}
 			if (rs.getString("status").equals("4")) {
 				out.println("ยกเลิกการขาย ");
 			}
			%>
		</td>
		<td align="center"><a
			href="order_detail.jsp?order_id=<%=rs.getString("order_id")%>"
			class="button">ดูใบสั่งซื้อ</a></td>
	</tr>

	<%
		} while (rs.next());
	%>
</table>
<%
		}
%>
