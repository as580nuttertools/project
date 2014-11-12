<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="header.jsp"%>
<%@ include file="config.jsp"%>
<jsp:useBean id="cart" class="ktpbook.ProductCart" scope="session" />
<%
	//ถ้ายังไม่ได้ login ให้ไป login เข้ามาก่อน
	String status = "" + session.getAttribute("status");
	if ((!status.equals("customer"))
			&& cart.getItem().hasMoreElements()) {
		out.println("<center>ให้ล็อกอินเข้าสู่ระบบก่อน");
%>
<jsp:include page="form_customer_login.jsp" />
<%
	} else {
		String[] temp;
		float sum = 0;
		float amount = 0;
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, user, pw);
		Statement stmt = con.createStatement();
		String sql = "";
		ResultSet rs = null;
		if (request.getParameter("buy") != null) {
		}
		//ถ้าคลิกปุ่ม "ตกลง" ตรวจสอบว่าเลือกชำระเงินประเภทใด
		if (request.getParameter("ok") != null) {
			response.sendRedirect("confirm_pay.jsp");
		}
		//ถ้ารถเข็นมีสินค้าให้อ่านค่าออกมาแสดง
		if (cart.getItem().hasMoreElements()) {
			Enumeration enu = cart.getItem();
%><br>
<table width="85%" border="1" align="center" bordercolor="black"
	cellspacing="0" bgcolor="#79CDCD">
	<tr>
		<td align="center"><b>ยืนยันการสั่งซื้อ</b></td>
	</tr>
</table>
<br>
<form method="post" action="pay.jsp">
	<table width="70%" align="center" cellspacing="0" bgcolor="#E1EEEE"
		bordercolor="black" border="1">
		<tr bgcolor="#79CDCD">
			<td width="17%" align="center"><b>รหัสหนังสือ</b></td>
			<td width="38%" align="center"><b>ชื่อหนังสือ</b></td>
			<td width="10%" align="center"><b>จำนวน</b></td>
			<td width="22%" align="center"><b>ราคา/หน่วย</b></td>
			<td width="13%" align="center"><b>ราคารวม</b></td>
		</tr>
		<%
			while (enu.hasMoreElements()) {
						temp = (String[]) enu.nextElement();
						sum = Integer.parseInt(temp[2])
								* Float.parseFloat(temp[3]);
						amount += sum;
		%>
		<tr>
			<td align="center"><%=temp[0]%></td>
			<td><%=new String(temp[1].getBytes("ISO8859_1"),
								"windows-874")%></td>
			<td align="center"><%=temp[2]%></td>
			<td align="center"><%=temp[3]%></td>
			<td align="center"><%=sum%></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="3">&nbsp;</td>
			<td align="center"><b>ราคารวมทั้งหมด</b></td>
			<td align="center"><%=amount%></td>
		</tr>
	</table>
	<br>
	<%
		sql = "select * from customer where username='"
						+ session.getAttribute("j_username") + "'";
				rs = stmt.executeQuery(sql);
				rs.next();
	%>
	<table width="70%" align="center" cellspacing="0" align="center">

		<tr align="center">
			<td colspan="2"><input name="ok" type="submit" value="ตกลง">
				<input name="buy" type="submit" value=" เลือกซื้อสิ้นค้าต่อ "></td>
		</tr>
	</table>
</form>
<%
	rs.close();
		}
	}
%>
<jsp:include page="footer.jsp" />
