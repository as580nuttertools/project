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
<form name="frmSearch" method="post" action="cash_cheer_menu.jsp">
	<table width="90%" border="1" align="center" cellspacing="0"
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
				+ "%' or isbn like '%" + keyword + "%' order by isbn";
		rs = stmt.executeQuery(sql);
		rs.absolute(pa.getStartRow()); //กำหนดแถวค่าแรกที่แสดง
		con.close();
%>
<table width="90%" border="1" align="center" cellspacing="0"
	bordercolor="black" bgcolor="#E1EEEE">
	<tr bgcolor="#79CDCD">
		<td align="center"><span style="font-weight: bold">ISBN</span></td>
		<td align="center"><span style="font-weight: bold">ชื่อหนังสือ</span></td>
		<td width="10%" align="center"><span style="font-weight: bold">จำนวน</span></td>
		<td width="10%" align="center"><span style="font-weight: bold">ซื้อ</span></td>

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
			href="add_to_cash_cheer.jsp?b_id=<%=rs.getString("b_id")%>"
			class=Button>ซื้อ</a></td>
	</tr>


	<%
		} while (rs.next() && rs.getRow() <= pa.getEndRow());
	%>
</table>
<form name="form1" method="post"
	action="cash_cheer_menu.jsp?keyword=<%=keyword%>">
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
		out.println("<center>ไม่มีหนังสือ</center>");
%><br>
</table>
<%
	}
	rs.close();
	con.close();
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
		response.sendRedirect("pay_cash_cheer.jsp");
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
<form method="post" action="cash_cheer_menu.jsp">
	<table width="90%" border="1" align="center" cellspacing="0"
		bordercolor="black" bgcolor="#E1EEEE">
		<tr bgcolor="#79CDCD">
			<td width="5%" align="center"><b>เลือก</b></td>
			<td width="15%" align="center"><b>รหัสหนังสือ</b></td>
			<td width="20%" align="center"><b>ชื่อหนังสือ</b></td>
			<td width="15%" align="center"><b>จำนวนคงเหลือ</b></td>
			<td width="15%" align="center"><b>จำนวน</b></td>
			<td width="15%" align="center"><b>ราคา/หน่วย</b></td>
			<td width="20%" align="center"><b>ราคารวม</b></td>
		</tr>
		<%
			Enumeration enu = cart.getItem();
				float sum = 0;
				float amount = 0;
				//นำหนังสือที่อยู่ใน bean ออกมาแสดง
				while (enu.hasMoreElements()) {
					temp = (String[]) enu.nextElement();

					Class.forName(driver);
					con = DriverManager.getConnection(url, user, pw);
					stmt = con.createStatement();
					sql = "select * from book where b_id=" + temp[0];
					rs = stmt.executeQuery(sql);

					int quantityB = Integer.parseInt(temp[2]);//จำนวนที่จะซื้อ
					//Integer.parseInt(rs.getString("quantity"))จำนวนที่เหลือ
					while (rs.next()) {

						if (quantityB < 1) {
		%>
		<script>
		alert("ไม่สามารถซื้อหนังสือจำนวนกว่า1เล่มได้");
							</script>
		<%
			temp[2] = "1";
						}

						if (quantityB > Integer.parseInt(rs
								.getString("quantity"))) {
		%>
		<script>
		alert("หนังสือการ์ตูนเรื่อง <%=new String(temp[1].getBytes("ISO8859_1"),
									"windows-874")%> เหลืออยู่จำนวน <%=rs.getString("quantity")%> เล่ม ไม่สามารถซื้อมากไปกว่านี้ได้");
		</script>
		<%
			temp[2] = rs.getString("quantity");
						}
						sum = quantityB * Float.parseFloat(temp[3]);
						amount += sum;
		%>
		<tr>
			<td align="center"><input name="b_id" type="checkbox"
				value="<%=temp[0]%>"></td>
			<td align="center"><%=rs.getString("isbn")%></td>
			<td><%=new String(temp[1].getBytes("ISO8859_1"),
								"windows-874")%></td>
			<td align="center"><%=rs.getString("quantity")%></td>
			<td><input name="<%=temp[0]%>" type="text" value="<%=temp[2]%>"
				size="3" maxlength="3"><a
				href="add_to_cash_cheer.jsp?b_id=<%=temp[0]%>" class="button">เพิ่ม</a><a
				href="reduce_to_cash_cheer.jsp?b_id=<%=temp[0]%>" class="button">ลด</a></td>
			<td align="center"><%=temp[3]%> บาท</td>
			<td align="center"><%=sum%> บาท</td>
		</tr>
		<%
			}
				}
		%>
		<tr>
			<td colspan="3"><input name="del" type="submit"
				value="ยกเลิกที่เลือก"></td>
			<td colspan="3" align="right"><b>ราคารวมทั้งหมด</b></td>
			<td align="center"><%=amount%> บาท</td>
		</tr>
		<%
			String receive = "0";
				receive = request.getParameter("receive");
				String receiveS = "0";
				float receiveI = 0;
				if (receive != null) {//check receive
					try {//check receive NumberFormatException
						receiveS = request.getParameter("receive");
						receiveI = Float.parseFloat(receiveS);
						receiveI = receiveI - amount;

						if (Integer.parseInt(receive) <= 0) {
							receive = "0";
						}
					} catch (NumberFormatException e) {
						receive = "1";
					}
		%>
		<%
			}
		%>
		<tr>
			<td colspan="5" align="right"><b>รับเงิน</b></td>
			<td align="center" colspan="2"><input name="receive" type="text"
				size="5" maxlength="5"
				<%if (receive == null) {
					receive = "0";
				}
				if (receive != null) {
					;
				}%>
				value="<%=receive%>"> บาท</td>
		</tr>
		<tr>
			<td colspan="5" align="right"><b>ราคารวมทั้งหมด</b></td>
			<td align="center" colspan="2"><%=amount%> บาท</td>
		</tr>
		<tr>
			<td colspan="5" align="right"><b>ทอนเงิน</b></td>
			<td align="center" colspan="2">
				<%
					if (receive != null) {
				%><%=receiveI%> <%
 	}
 %> บาท
			</td>
		</tr>
		<tr>
			<td colspan="7"><div align="center">
					<input name="cal" type="submit" value="คำนวณ"> <input
						name="pay" type="submit" value="ชำระเงิน">
				</div></td>
		</tr>
	</table>
</form>
<%
	} else {
%><br>
<center>ยังไม่มีหนังสือในรถเข็น</center>
<br>
<%
	}
%>
<br>
<%
	rs.close();
	con.close();
%>
