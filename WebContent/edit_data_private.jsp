<%@ include file="ck_session_customer.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="header.jsp"%>
<%@ include file="config.jsp"%>
<%@ include file="m_Numeric.jsp"%>
<%
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
	if (request.getParameter("Submit") != null) {
		Vector errors = new Vector();
		String email = request.getParameter("email");
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String tel = request.getParameter("tel");
		if (!email.equals("")) {
			if ((email.equals("")) || (email.indexOf('@') == -1)
					|| (email.indexOf('.') == -1)) {
				errors.add("ตรวจสอบชื่ออีเมล์");
			}
		}
		if (fname.equals("") || lname.equals("")) {
			errors.add("ตรวจสอบชื่อ -นามสกุล");
		}
		if (!tel.equals("")) {
			if (tel.length() != 9 || (!isNumeric(tel))) {
				errors.add("ตรวจสอบเบอร์โทรศัพท์");
			}
		}
		if (errors.size() > 0) {
%><%@ include file="ckError.jsp"%>
<%
	} else {
			sql = "update user set email='" + email + "',fname='"
					+ fname + "',lname='" + lname + "',tel='" + tel
					+ "' where username='"
					+ session.getAttribute("j_username") + "'";
			stmt.executeUpdate(sql);
			session.invalidate();
%>
<center>
	แก้ไขข้อมูลเรียบร้อยแล้วให้ทำการ Login เข้ามาใหม่
	<jsp:include page="form_customer_login.jsp" /></center>
<%
	}
	} else {
		sql = "select * from user where username='"
				+ session.getAttribute("j_username") + "'";
		rs = stmt.executeQuery(sql);
		rs.next();
%>
<form action="edit_data_private.jsp" method="post">
	<table width="55%" border="0" align="center" cellspacing="0">
		<tr bgcolor="#ECE9D8">
			<td colspan="2"><span style="font-weight: bold">แก้ไขข้อมูลส่วนตัว</span></td>
		</tr>
		<tr>
			<td>อีเมล์</td>
			<td><input name="email" type="text"
				value="<%=rs.getString("email")%>"email");"></td>
		</tr>
		<tr>
			<td>ชื่อ</td>
			<td><input name="fname" type="text"
				value="<%=new String(rs.getString("fname")
						.getBytes("ISO8859_1"), "windows-874")%>">
				*</td>
		</tr>
		<tr>
			<td>นามสกุล</td>
			<td><input name="lname" type="text"
				value="<%=new String(rs.getString("lname")
						.getBytes("ISO8859_1"), "windows-874")%>"
				size="35"> *</td>
		</tr>
		<tr>
			<td>เบอร์โทรศัพท์</td>
			<td><input name="tel" type="text"
				value="<%=rs.getString("tel")%>" size="20"></td>
		</tr>
		<tr>
			<td colspan="2"><div align="center">
					<input type="submit" name="Submit" value="แก้ไข">
				</div></td>
		</tr>
	</table>
</form>
<%
	rs.close();
	}
%>
