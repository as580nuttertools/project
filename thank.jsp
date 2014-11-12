<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="header.jsp"%>
<%@ include file="m_date.jsp"%>
<%@ include file="config.jsp"%>
<script language="JavaScript" type="text/JavaScript">
	function MM_openBrWindow(theURL, winName, features) {
		window.open(theURL, winName, features);
	}
</script>
<%
	String order_id = "";
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
	sql = "select max(order_id) as max_id from orders where cus_id="
			+ session.getAttribute("cus_id");
	rs = stmt.executeQuery(sql);
	while (rs.next()) {
		order_id = rs.getString("max_id");
	}
	rs.close();
%><br>
<table width="85%" border="1" align="center" bordercolor="black"
	cellspacing="0" bgcolor="#79CDCD">
	<tr>
		<td align="center"><b>ขอบคุณที่ใช้บริการ</b></td>
	</tr>
</table>
<br>
<form action="thank.jsp" method="post">
	<table width="80%" align="center" align="center" bordercolor="black"
	cellspacing="0" bgcolor="#E1EEEE" border="1">
		<tr bgcolor="#79CDCD">
			<th colspan="5" scope="col"><b>ใบสั่งซื้อ</b></th>
		</tr>
		<%
			sql = "select  * from orders where order_id='" + order_id + "'";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
		%>
		<tr>
			<td colspan="5"><b>เลขที่ใบสั่งซื้อ :</b> <%=rs.getString("order_id")%><br>
				<b>ชื่อ:</b> <%=session.getAttribute("j_fname")%> <%=session.getAttribute("j_lname")%><br>
				<b>วันที่สั่งซื้อ :</b> <%=dateTH(rs.getString("date"))%> <br></td>
		</tr>
		<tr bgcolor="#79CDCD">
			<td width="13%" align="center"><b>รหัสหนังสือ</b></td>
			<td width="52%" align="center"><b>ชื่อหนังสือ</b></td>
			<td width="14%" align="center"><b>ราคา/หน่วย</b></td>
			<td width="9%" align="center"><b>จำนวน</b></td>
			<td width="12%" align="center"><b>ราคารวม</b></td>
		</tr>
		<%
			}
			rs.close();
			sql = "select * from order_items,book where book.b_id=order_items.b_id and order_id='"
					+ order_id + "'";
			rs = stmt.executeQuery(sql);
			int sum = 0;
			int total = 0;
			while (rs.next()) {
				sum = rs.getInt("item_price") * rs.getInt("quantity");
				total += sum;
		%>
		<tr>
			<td align="center"><%=rs.getString("b_id")%></td>
			<td><%=new String(rs.getString("title")
						.getBytes("ISO8859_1"), "windows-874")%></td>
			<td align="center"><%=rs.getString("item_price")%></td>
			<td align="center"><%=rs.getString("quantity")%></td>
			<td align="center"><%=sum%></td>
		</tr>
		<%
			}
			rs.close();
		%>
		<tr>
			<td colspan="3">&nbsp;</td>
			<td align="center"><b>รวม<b/></td>
			<td align="center"><%=total%></td>
		</tr>
		<tr>
			<td colspan="5"><div align="center">
					<input name="print_detail" type="button"
						onClick="MM_openBrWindow('print_detail.jsp?order_id=<%=order_id%>','','width=650,height=350')"
						value="พิมพ์ใบสั่งซื้อ">
				</div></td>
		</tr>
	</table>
</form>
<jsp:include page="footer.jsp" />
