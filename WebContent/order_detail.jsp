<%@ include file="ck_session_customer.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="header_user.jsp"%>
<%@ include file="m_date.jsp"%>
<%@ include file="config.jsp"%>
<script language="JavaScript" type="text/JavaScript">
	function MM_openBrWindow(theURL, winName, features) {
		window.open(theURL, winName, features);
	}
</script>
<%
	String order_id = request.getParameter("order_id");
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
%>
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
				<b>ชื่อ: </b><%=session.getAttribute("j_fname")%> <%=session.getAttribute("j_lname")%><br>
				<b>วันที่สั่งซื้อ : </b><%=dateTH(rs.getString("date"))%> <br></td>
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
			int amount = 0;
			while (rs.next()) {
				sum = rs.getInt("item_price") * rs.getInt("quantity");
				amount += sum;
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
			<td colspan="4"><div align="right">
					<b>ราคารวมทั้งหมด</b>
				</div></td>
			<td align="center"><%=amount%></td>
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
