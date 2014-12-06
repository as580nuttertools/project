<%@ include file="ck_session_admin.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*"%>
<%@ include file="config.jsp"%>
<script language="JavaScript" type="text/JavaScript">
	function MM_openBrWindow(theURL, winName, features) {
		window.open(theURL, winName, features);
	}
</script>
<jsp:useBean id="pa" class="ktpbook.PageBean" scope="session" />
<%
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
	String keyword = "";
	try {
		if (request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
%>
<br>
<form name="frmSearch" method="post" action="circulation_menu.jsp">
	<table width="90%" border="1" align="center" cellspacing="0"
		bordercolor="black" bgcolor="#79CDCD">
		<tr align="center">
			<td><b>ค้นหา</b> <select name="keyword" id="keyword">
					<option value="2020" selected>2020</option>
					<option value="2019" selected>2019</option>
					<option value="2018" selected>2018</option>
					<option value="2017" selected>2017</option>
					<option value="2016" selected>2016</option>
					<option value="2015" selected>2015</option>
					<option value="2014" selected>2014</option>
					<option value="" selected>เลือกปีที่จะแสดง</option>
			</select> <input type="submit" value="ค้นหา"></td>
		</tr>
	</table>
</form>
<table width="90%" border="1" align="center" cellspacing="0"
	bordercolor="black" bgcolor="#79CDCD">
	<tr align="center">
		<%
			if (keyword == "") {
		%><td><b>ยอดขายทั้งหมด</b></td>
		<%
			} else {
		%><td><b>ยอดขายในปี <%=keyword%></b></td>
		<%
			}
		%>
	</tr>
</table>
<br>
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
		sql = "select count(*) as totalRow FROM orders,order_items,book where orders.date like '%"
				+ keyword
				+ "%' and order_items.order_id=orders.order_id and order_items.b_id=book.b_id and book.score>0 and orders.status=3 group by book.title ";
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			totalRow = rs.getInt("totalRow");
		}
		rs.close();
		//กำหนดค่าต่างๆ ใน bean
		pa.setTotalRow(totalRow);
		pa.actionPage(action, 10);
		// แสดงหนังสือตามค่าที่กำหนด
		sql = "SELECT * FROM orders,order_items,book where orders.date like '%"
				+ keyword
				+ "%' and order_items.order_id=orders.order_id and order_items.b_id=book.b_id and book.score>0 and orders.status=3 group by book.title ";
		rs = stmt.executeQuery(sql);
		rs.absolute(pa.getStartRow()); //กำหนดแถวค่าแรกที่แสดง
		con.close();
		int sum, amount = 0;
%>
<table width="90%" border="1" align="center" cellspacing="0"
	bordercolor="black" bgcolor="#E1EEEE">
	<tr bgcolor="#79CDCD">
		<td width="15%" align="center"><span style="font-weight: bold">ISBN</span></td>
		<td width="30%" align="center"><span style="font-weight: bold">ชื่อหนังสือ</span></td>
		<td width="10%" align="center"><span style="font-weight: bold">ราตา</span></td>
		<td width="10%" align="center"><span style="font-weight: bold">ยอดขาย
		</span></td>
		<td width="10%" align="center"><span style="font-weight: bold">ยอดขาย
		</span></td>
	</tr>
	<%
		do {
	%><td align="center"><%=rs.getString("isbn")%></td>
	<td><%=new String(rs.getString("title").getBytes(
							"ISO8859_1"), "windows-874")%></td>
	<td align="center"><%=rs.getString("book.price")%> บาท</td>
	<td align="center"><%=rs.getString("book.score")%> เล่ม</td>
	<%
		sum = rs.getInt("book.score") * rs.getInt("book.price");
	%>
	<td align="center"><%=sum%> บาท</td>
	</tr>
	<%
		amount = amount + sum;
			} while (rs.next() && rs.getRow() <= pa.getEndRow());
	%>

	<tr>
		<td colspan="4" align="right"><b>ยอดขายทั้งหมด</b></td>
		<td align="center"><%=amount%> บาท</td>
	</tr>
	<tr>
		<td colspan="5"><div align="center">
				<input name="print_detail" type="button"
					onClick="MM_openBrWindow('print_circulation.jsp?keyword=<%=keyword%>','','width=650,height=500')"
					value="พิมพ์ใบสั่งซื้อ">
			</div></td>
	</tr>

</table>
<br>
<form name="form1" method="post"
	action="circulation_menu.jsp?keyword=<%=keyword%>">
	<table width="90%" border="1" align="center" cellspacing="0"
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
		out.println("ไม่มียอดขายในปี " + keyword);
	}
	rs.close();
	con.close();
%>
