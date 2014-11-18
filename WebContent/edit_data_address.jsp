<%@ include file="ck_session_customer.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="header.jsp"%>
<%@ include file="config.jsp"%>
<%@ include file="m_Numeric.jsp"%>
<%
	String pay = request.getParameter("pay");
	if (pay.equals("yes")) {
		out.println("<center><a href='pay.jsp'>กลับไปหน้าสั่งซื้อ</a></center>");
	}
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
	if (request.getParameter("Submit") != null) {
		Vector errors = new Vector();
		String address = request.getParameter("address");
		String province = request.getParameter("province");
		String city = request.getParameter("city");
		String country = request.getParameter("country");
		String zip = request.getParameter("zip");
		if (address.equals("")) {
			errors.add("ตรวจสอบที่อยู่");
		}
		if (province.equals("")) {
			errors.add("ตรวจสอบอำเภอ/เขต");
		}
		if (city.equals("")) {
			errors.add("ตรวจสอบจังหวัด");
		}
		if ((!isNumeric(zip)) || zip.length() != 5) {
			errors.add("ตรวจสอบรหัสไปรษณีย์");
		}
		if (errors.size() > 0) {
%><%@ include file="ckError.jsp"%>
<%
	} else {
			sql = "update user set address='" + address
					+ "',province='" + province + "',city='" + city
					+ "',zip='" + zip + "' where username='"
					+ session.getAttribute("j_username") + "'";
			int row = stmt.executeUpdate(sql);
			if (row > 0) {
				//ถ้าเป็นการแก้ไขขณะที่ทำการชำระเงิน
				if (pay.equals("yes")) {
					response.sendRedirect("pay.jsp");
				} else {
					response.sendRedirect("edit_data.jsp");
				}
			}
		}
	} else {
		sql = "select * from user where username='"
				+ session.getAttribute("j_username") + "'";
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
%>
<form method="post" action="edit_data_address.jsp">
	<table width="55%" border="0" align="center" cellspacing="0">
		<tr bgcolor="#ECE9D8">
			<td colspan="2"><span style="font-weight: bold">แก้ไขข้อมูลที่อยู่</span></td>
		</tr>
		<tr>
			<td>ชื่อ-นามสกุล</td>
			<td><%=session.getAttribute("j_fname")%> <%=session.getAttribute("j_lname")%>
			</td>
		</tr>
		<tr>
			<td>ที่อยู่</td>
			<td><input name="address" type="text"
				value="<%=new String(rs.getString("address").getBytes(
							"ISO8859_1"), "windows-874")%>"
				size="40"> *</td>
		</tr>
		<tr>
			<td>อำเภอ/เขต</td>
			<td><input name="province" type="text"
				value="<%=new String(rs.getString("province").getBytes(
							"ISO8859_1"), "windows-874")%>">
				*</td>
		</tr>
		<tr>
			<td>จังหวัด</td>
			<td><input name="city" type="text"
				value="<%=new String(rs.getString("city").getBytes(
							"ISO8859_1"), "windows-874")%>">
				*</td>
		</tr>
		<td>รหัสไปรษณีย์</td>
		<td><input name="zip" type="text"
			value="<%=rs.getString("zip")%>" size="10"> *</td>
		</tr>
		<tr>
			<td colspan="2"><div align="center">
					<input name="pay" type="hidden" id="pay" value="<%=pay%>">
					<input type="submit" name="Submit" value="แก้ไข">
				</div></td>
		</tr>
	</table>
</form>
<%
	}
		rs.close();
	}
%>
