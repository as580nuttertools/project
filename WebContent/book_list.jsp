<%@ include file="ck_session_admin.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*"%>
<%@ include file="config.jsp"%>
<jsp:useBean id="pa" class="ktpbook.PageBean" scope="session" />
<%
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
	try {

		String keyword = "";
		if (request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
%>
<br>
<form name="frmSearch" method="post" action="book_list_menu.jsp">
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
				+ keyword + "%' or isbn like '%" + keyword + "%'";
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
				+ "%' or isbn like '%" + keyword + "%'";
		rs = stmt.executeQuery(sql);
		rs.absolute(pa.getStartRow()); //กำหนดแถวค่าแรกที่แสดง
		con.close();
%>
<table width="60%" border="1" align="center" cellspacing="0"
	bordercolor="black" bgcolor="#E1EEEE">
	<tr bgcolor="#79CDCD">
		<td align="center"><span style="font-weight: bold">ISBN</span></td>
		<td align="center"><span style="font-weight: bold">ชื่อหนังสือ</span></td>
		<td width="10%" align="center"><span style="font-weight: bold">จำนวน</span></td>
		<td width="10%" align="center"><span style="font-weight: bold">แก้ไข</span></td>
		<td width="10% align=" center"" align="center"><span
			style="font-weight: bold">ลบ</span></td>
	</tr>
	<%
		do {
	%>
	<tr>
		<td align="center"><%=rs.getString("isbn")%></td>
		<td><%=new String(rs.getString("title").getBytes(
							"ISO8859_1"), "windows-874")%></td>
		<td align="center"><%=rs.getString("quantity")%></td>
		<td align="center"><a
			href="edit_book.jsp?b_id=<%=rs.getString("b_id")%>" class="button">แก้ไข</a></td>
		<td align="center"><a
			href="del_book.jsp?b_id=<%=rs.getString("b_id")%>" class="button">ลบ</a></td>
	</tr>
	<%
		} while (rs.next() && rs.getRow() <= pa.getEndRow());
	%>
	<tr>
		<td colspan="5"><br></td>
	</tr>
	<td colspan="5" align="center"><a href="add_book.jsp"
		class="button">เพิ่มหนังสือ</a>
	</tr>


</table>
<br>
<form name="form1" method="post"
	action="book_list_menu.jsp?keyword=<%=keyword%>">
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
	rs.close();
	con.close();
%>
