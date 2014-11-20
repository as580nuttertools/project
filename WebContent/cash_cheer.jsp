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
		out.println("ไม่มีหนังสือ");
	}
	rs.close();
	con.close();
%>
<%@ include file="ck_session_admin.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="config.jsp"%>
<jsp:useBean id="pa" class="ktpbook.PageBean" scope="session" />
<jsp:useBean id="cart" class="ktpbook.ProductCart" scope="session" />
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
		out.println("ไม่มีหนังสือ");
	}
	rs.close();
	con.close();////////////////////////////////////////////////////////////////////
%>
<%
	String[] temp;
	if (request.getParameter("cal") != null) {
		Enumeration e = cart.getItem();
		while (e.hasMoreElements()) {
			temp = (String[]) e.nextElement();
			cart.setQuantity(temp[0], request.getParameter(temp[0]));
		}
	}
	if (request.getParameter("pay") != null) {
		response.sendRedirect("pay.jsp");
	}
	if (request.getParameter("buy") != null) {
		response.sendRedirect("product.jsp");
	}
	if (request.getParameter("del") != null) {
		String[] b_id = request.getParameterValues("b_id");
		if (b_id != null) {
			for (int i = 0; i < b_id.length; i++) {
				cart.removeItem(b_id[i]);
			}
		}
	}
	if (cart.getItem().hasMoreElements()) {
%><br>
<table width="85%" border="1" align="center" bordercolor="black"
	cellspacing="0" bgcolor="#79CDCD">
	<tr>
		<td align="center"><b>รถเข็น</b></td>
	</tr>
</table>
<br>
<form method="post" action="view_cart.jsp">
	<table width="70%" border="1" align="center" cellspacing="0"
		bordercolor="black" bgcolor="#E1EEEE">
		<tr bgcolor="#79CDCD">
			<td width="5%" align="center"><b>เลือก</b></td>
			<td width="18%" align="center"><b>รหัสหนังสือ</b></td>
			<td width="42%" align="center"><b>ชื่อหนังสือ</b></td>
			<td width="10%" align="center"><b>จำนวน</b></td>
			<td width="14%" align="center"><b>ราคา/หน่วย</b></td>
			<td width="13%" align="center"><b>ราคารวม</b></td>
		</tr>
		<%
			Enumeration enu = cart.getItem();
				float sum = 0;
				float amount = 0;
				//นำหนังสือที่อยู่ใน bean ออกมาแสดง
				while (enu.hasMoreElements()) {
					temp = (String[]) enu.nextElement();
					sum = Integer.parseInt(temp[2]) * Float.parseFloat(temp[3]);
					amount += sum;
		%>
		<tr>
			<td align="center"><input name="b_id" type="checkbox"
				value="<%=temp[0]%>"></td>
			<td align="center"><%=temp[0]%></td>
			<td><%=new String(temp[1].getBytes("ISO8859_1"),
							"windows-874")%></td>
			<td><input name="<%=temp[0]%>" type="text" value="<%=temp[2]%>"
				size="3" maxlength="3"><a
				href="add_to_cart.jsp?b_id=<%=temp[0]%>" class="button">เพิ่ม</a><a
				href="reduce_to_car.jsp?b_id=<%=temp[0]%>" class="button">ลด</a></td>
			<td align="center"><%=temp[3]%></td>
			<td align="center"><%=sum%></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="2"><input name="del" type="submit"
				value="ยกเลิกที่เลือก"></td>
			<td colspan="3" align="right"><b>ราคารวมทั้งหมด</b></td>
			<td align="center"><%=amount%></td>
		</tr>
		<tr>
			<td colspan="6"><div align="center">
					<input name="cal" type="submit" value=" คำนวณใหม่"> <input
						name="buy" type="submit" value="เลือกซื้อสินค้าต่อ"> <input
						name="pay" type="submit" value="ชำระเงิน">
				</div></td>
		</tr>
	</table>
</form>
<%
	} else {
%>
<br>
<%
	out.println("<center>ยังไม่มีหนังสือในรถเข็น</center>");
	}
%>
<br>
