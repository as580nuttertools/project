<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*"%>
<%@ include file="config.jsp"%>
<jsp:useBean id="pa" class="ktpbook.PageBean" scope="session" />
<%
	try {
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, user, pw);
		Statement stmt = con.createStatement();
		String sql;
		ResultSet rs = null;

		String keyword = "";
		if (request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
%>
<br>
<form name="frmSearch" method="post" action="product.jsp">
	<table width="85%" border="1" align="center" cellspacing="0"
		bordercolor="black" bgcolor="#79CDCD">
		<tr align="center">
			<td><b>ค้นหา</b> <input name="keyword" type="text" id="keyword"
				value="<%=keyword%>"> <input type="submit" value="ค้นหา">
		</tr>
	</table>
</form>
<%
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
		sql = "select  count(*) as totalRow from book WHERE title like '%"
				+ keyword + "%' or author like '%" + keyword + "%'";
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			totalRow = rs.getInt("totalRow");
		}
		rs.close();
		//กำหนดค่าต่างๆ ใน bean
		pa.setTotalRow(totalRow);
		pa.actionPage(action, 5);
		// แสดงหนังสือตามค่าที่กำหนด
		sql = "SELECT * FROM book WHERE title like '%" + keyword
				+ "%' or author like '%" + keyword + "%'";
		rs = stmt.executeQuery(sql);
		rs.absolute(pa.getStartRow()); //กำหนดแถวค่าแรกที่แสดง
		do {
%>
<table width="60%" align="center" bgcolor="#E1EEEE">
	<tr bgcolor="#79CDCD">
		<td colspan="3"><a
			href="product_detail.jsp?b_id=<%=rs.getString("b_id")%>" class=Button><%=new String(rs.getString("title").getBytes(
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
<form name="form1" method="post"
	action="product.jsp?keyword=<%=keyword%>">
	<table width="70%" border="1" align="center" cellspacing="0"
		bordercolor="black" bgcolor="#E1EEEE">
		<tr>
			<td><div align="center">
					<input name="bFirst" type="submit" id="bFirst" value="  <<  "
						<%if (pa.getPageNo() == 1)
					out.println("disabled");%>>
					<input name="bPrevious" type="submit" id="bPrevious"
						value="   <   "
						<%if (pa.getPageNo() == 1)
					out.println("disabled");%>>
					<input name="bNext" type="submit" id="bNext" value="   >   "
						<%if (pa.getPageNo() == pa.getTotalPage())
					out.println("disabled");%>>
					<input name="bLast" type="submit" id="bLast" value="  >>  "
						<%if (pa.getPageNo() == pa.getTotalPage())
					out.println("disabled");%>>
					<input name="bPageNo" type="submit" id="bPageNo" value="หน้าที่">
					<input name="pageNo" type="text" id="pageNo"
						value="<%=pa.getPageNo()%>" size="2" maxlength="3"> /<%=pa.getTotalPage()%></div></td>
		</tr>
	</table>
</form>
<%
	} catch (Exception e) {
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>
