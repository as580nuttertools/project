<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
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
					Connection con = DriverManager.getConnection(url, user, pw);
					Statement stmt = con.createStatement();
					String sql = "select * from book where b_id=" + temp[0];
					ResultSet rs = stmt.executeQuery(sql);

					int quantityB = Integer.parseInt(temp[2]);//จำนวนที่จะซื้อ
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
			<td align="center"><%=rs.getString("quantity")%> เล่ม</td>
			<td><input name="<%=temp[0]%>" type="text" value="<%=temp[2]%>"
				size="3" maxlength="3"><a
				href="add_to_cart.jsp?b_id=<%=temp[0]%>" class="button">เพิ่ม</a><a
				href="reduce_to_car.jsp?b_id=<%=temp[0]%>" class="button">ลด</a></td>
			<td align="center"><%=temp[3]%> บาท</td>
			<td align="center"><%=sum%> บาท</td>
		</tr>
		<%
			}
					rs.close();
					con.close();
				}
		%>
		<tr>
			<td colspan="3"><input name="del" type="submit"
				value="ยกเลิกที่เลือก"></td>
			<td colspan="3" align="right"><b>ราคารวมทั้งหมด</b></td>
			<td align="center"><%=amount%> บาท</td>
		</tr>
		<tr>
			<td colspan="7"><div align="center">
					<input name="cal" type="submit" value="คำนวณราคา"><input
						name="buy" type="submit" value="เลือกซื้อสินค้า"><input
						name="pay" type="submit" value="ซื้อ">
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
<%@ include file="footer.jsp"%>
