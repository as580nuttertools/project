<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*"%>
<%@ include file="m_date.jsp"%>
<%@ include file="config.jsp"%>
<jsp:useBean id="pa" class="ktpbook.PageBean" scope="session" />
<br>
<table width="85%" border="1" align="center" bordercolor="black"
	cellspacing="0" bgcolor="#79CDCD">
	<tr>
		<td align="center"><b>หนังสือการ์ตูนขายดี</b></td>
	</tr>
</table>
<br>
<%
	try {
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, user, pw);
		Statement stmt = con.createStatement();
		String sql;
		ResultSet rs = null;

		//ตรวจสอบค่าปุ่มที่กด
		String action = "";
		if (request.getParameter("bFirst") != "1") {
			action = "first";
		}
		if (request.getParameter("bPrevious") != null) {
			action = "previous";
		}
		if (request.getParameter("bNext") != null) {
			action = "next";
		}
		if (request.getParameter("bLast") != null) {
			action = "last";
		}
		if (request.getParameter("bPageNo") != null) {
			//ดักจับข้อผิดพลาดค่าของ pageNo ว่าเป็นตัวเลขหรือไม่
			try {
				pa.setPageNo(Integer.parseInt(request
						.getParameter("pageNo")));
				action = "pageNo";
			} catch (NumberFormatException e) {
			}
		}

		int totalRow = 0;
		//หาจำนวนหนังสือ
		sql = "select  count(*) as totalRow from book WHERE title like '%%'";
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			totalRow = rs.getInt("totalRow");
		}
		rs.close();
		//กำหนดค่าต่างๆ ใน bean
		pa.setTotalRow(totalRow);
		pa.actionPage(action, 3);
		// แสดงหนังสือตามค่าที่กำหนด
		sql = "SELECT * FROM book WHERE title like '%%' ";
		rs = stmt.executeQuery(sql);
		rs.absolute(pa.getStartRow()); //กำหนดแถวค่าแรกที่แสดง
		do {
%>
<table width="85%" border="1" align="center" bordercolor="black"
	cellspacing="0" bgcolor="#E1EEEE">
	<table width="60%" align="center" bgcolor="#E1EEEE">
		<tr>
			<td colspan="3" bgcolor="#79CDCD"><a
				href="product_detail.jsp?b_id=<%=rs.getString("b_id")%>"
				class=Button><%=new String(rs.getString("title").getBytes(
							"ISO8859_1"), "windows-874")%></a></td>
		</tr>
		<tr>
			<td width="20%" rowspan="4"><img
				src="Image/pic_book/<%=rs.getString("image")%>" width="80"
				height="100" /></td>
			<td width="25%">ผู้เขียน</td>
			<td width="55%"><%=new String(rs.getString("author").getBytes(
							"ISO8859_1"), "windows-874")%></td>
		</tr>
		<tr>
			<td>ISBN</td>
			<td><%=rs.getString("isbn")%></td>
		</tr>
		<tr>
			<td>จำนวนหน้า</td>
			<td><%=rs.getString("n_page")%></td>
		</tr>
		<tr>
			<td>ราคา</td>
			<td><%=rs.getString("price")%></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><a href="product_detail.jsp?b_id=<%=rs.getString("b_id")%>"
				class=Button>รายละเอียด</a></td>
			<td><a href="add_to_cart.jsp?b_id=<%=rs.getString("b_id")%>"
				class=Button>หยิบใส่รถเข็น</a></td>
		</tr>
	</table>
	<br>
	<%
		} while (rs.next() && rs.getRow() <= pa.getEndRow());
	%>
</table>
<table width="75%" align="center" cellpadding="0" cellspacing="0">
	<tr bgcolor="#ECE9D8">
</table>
<%
	} catch (Exception e) {
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>
<jsp:include page="footer.jsp" />
