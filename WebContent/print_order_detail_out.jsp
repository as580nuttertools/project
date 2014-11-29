<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="config.jsp"%>
<%@ include file="m_date.jsp"%>
<jsp:useBean id="cart" class="ktpbook.ProductCart" scope="session" />
<%
	String order_id = request.getParameter("order_id");
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql = "";
	ResultSet rs = null;
%>
<br>
<table width="90%" border="1" align="center" cellspacing="0"
	bordercolor="black" bgcolor="#E1EEEE">
	<tr>
		<td align="center" colspan="5"><b>ใบสั่งซื้อ</b></td>
	</tr>
	<tr>
		<td align="left" colspan="5"><b>บริษัท สยามบุค จำกัด</b><br>6/1
			ซ.โชคชัยจงจำเริญ (พระราม 3 ซ.53)<br> ถ.พระราม 3 แขวงบางโพงพาง <br>เขตยามนาวา
			กรุงเทพ 10120</td>
	</tr>
	<tr>
		<td align="left" colspan="5"><b>ผู้ส่ง</b><br> <b>ร้านน้องหลิว</b><br>72/126
			ตำบลในเมือง อำเภอเมือง<br> จังหวัดลำพูน 51000 โทร : (02)
			8906896-8 <br>Fax. : (02) 8906899 กด 0</td>
	</tr>
	<tr>
		<td align="center" colspan="5"><b>การชำระเงิน</b></td>
	</tr>
	<tr>
		<td colspan="5"><input type="checkbox" name="v1">
			ส่งของพร้อมเก็บเงินสด <br> <input type="checkbox" name="v1">
			ส่งของพร้อมรับเช็ค<br> <input type="checkbox" name="v1">
			โอนเงินผ่านธนาคาร<br> <input type="checkbox" name="v1">
			ส่งของพร้อมรับเช็ค (กรุณาแฟกซ์สำเนาใบโอนเงินพร้อมใบสั่งซื้อ)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
			type="checkbox" name="v1"> กรุงเทพ ชื่อบัญชี บริษัท สยามบุค
			จำกัด สาขา พลับพลาไชย กระแสรายวัน 002-3-26756-2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
			type="checkbox" name="v1"> กสิกรไทย ชื่อบัญชี บริษัท สยามบุค
			จำกัด สาขา ถนนพระราม 3 ออมทรัพย์ 057-2-65811-2</td>
	</tr>
	<tr bgcolor="#79CDCD">
		<td width="15%" align="center"><b>ISBN</b></td>
		<td width="40%" align="center"><b>ชื่อหนังสือ</b></td>
		<td width="15%" align="center"><b>จำนวน</b></td>
		<td width="15%" align="center"><b>ราคา/หน่วย</b></td>
		<td width="20%" align="center"><b>ราคารวม</b></td>
	</tr>
	<%
			sql = "select * from order_items,book where book.b_id=order_items.b_id and order_id='"
					+ order_id + "'";
			rs = stmt.executeQuery(sql);
			float sum = 0;
			float amount = 0;
			while (rs.next()) {
				sum = rs.getInt("item_price") * rs.getInt("quantity");
				amount += sum;
		%>
	<tr>
			<td align="center"><%=rs.getString("ISBN")%></td>
			<td><%=new String(rs.getString("title")
						.getBytes("ISO8859_1"), "windows-874")%></td>
			<td align="center"><%=rs.getString("item_price")%> บาท</td>
			<td align="center"><%=rs.getString("quantity")%> เล่ม</td>
			<td align="center"><%=sum%> บาท</td>
		</tr>
	<%
			}
			rs.close();
			con.close();
		%>
	<tr>
		<td colspan="4" align="right"><b>ราคารวมทั้งหมด</b></td>
		<td align="center"><%=amount%></td>
	</tr>
	<%
		float vat = (amount * 7) / 100;
			amount = amount + vat;
	%>
	<tr>
		<td colspan="4" align="right"><b>ภาษี7%</b></td>
		<td align="center"><%=vat%> บาท</td>
	</tr>
	<tr>
		<td colspan="4" align="right"><b>รวมภาษี7%แล้ว</b></td>
		<td align="center"><%=amount%> บาท</td>
	</tr>
</table>
<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ลงชื่อผู้สั่งซื้อ</b>
<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;........................................
<table width="70%" align="center" cellspacing="0" align="center">
	<tr align="center">
		<td colspan="2"><input name="print" type="button" id="print"
			onClick="window.print()" value=" พิมพ์ "> <input name="close"
			type="button" id="close2" onClick="window.close()" value="ปิด  "></td>
	</tr>
</table>
</form>
<%
	cart.close();
%>
