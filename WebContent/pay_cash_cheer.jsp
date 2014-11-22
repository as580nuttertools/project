<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="header.jsp"%>
<%@ include file="config.jsp"%>
<jsp:useBean id="cart" class="ktpbook.ProductCart" scope="session" />
<%
	String[] temp;
	if (request.getParameter("cal") != null) {
		Enumeration e = cart.getItem();
		while (e.hasMoreElements()) {
			temp = (String[]) e.nextElement();
			cart.setQuantity(temp[0], request.getParameter(temp[0]));
		}
	}
	if (request.getParameter("buy") != null) {
		response.sendRedirect("product.jsp");
	}
	if (request.getParameter("ok") != null) {
		response.sendRedirect("confirm_pay.jsp");
	}
	if (cart.getItem().hasMoreElements()) {
%><br>
<table width="85%" border="1" align="center" bordercolor="black"
	cellspacing="0" bgcolor="#79CDCD">
	<tr>
		<td align="center"><b>ยืนยันการสั่งซื้อ</b></td>
	</tr>
</table>
<br>
<form method="post" action="pay_cash_cheer.jsp">
	<table width="90%" border="1" align="center" cellspacing="0"
		bordercolor="black" bgcolor="#E1EEEE">
		<tr bgcolor="#79CDCD">
			<td width="15%" align="center"><b>ISBN</b></td>
			<td width="40%" align="center"><b>ชื่อหนังสือ</b></td>
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
					Connection con = DriverManager.getConnection(url, user, pw);
					Statement stmt = con.createStatement();
					String sql = "select * from book where b_id=" + temp[0];
					ResultSet rs = stmt.executeQuery(sql);

					sum = Integer.parseInt(temp[2]);//จำนวนที่จะซื้อ
					//rs.getInt("quantity")จำนวนที่เหลือ
					while (rs.next()) {
						if (sum < 1) {
							response.sendRedirect("cash_cheer_menu.jsp");
						} if (sum > rs.getInt("quantity")) {
							response.sendRedirect("cash_cheer_menu.jsp");
						}
						sum = sum * Float.parseFloat(temp[3]);
						amount += sum;
		%>
		<tr>
			<td align="center"><%=rs.getString("isbn")%></td>
			<td><%=new String(temp[1].getBytes("ISO8859_1"),
								"windows-874")%></td>
			<td align="center"><%=temp[2]%></td>
			<td align="center"><%=temp[3]%></td>
			<td align="center"><%=sum%></td>
		</tr>
		<%
			}
					rs.close();
					con.close();
				}
		%>
		<tr>
			<td colspan="4" align="right"><b>ราคารวมทั้งหมด</b></td>
			<td align="center"><%=amount%></td>
		</tr>
	</table>
	<br>
	<table width="70%" align="center" cellspacing="0" align="center">
		<tr align="center">
			<td colspan="2"><input name="ok" type="submit" value="ตกลง">
				<input name="buy" type="submit" value="เลือกซื้อสิ้นค้า "></td>
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
<%@ include file="footer.jsp"%>
