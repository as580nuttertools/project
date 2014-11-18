<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="header.jsp"%>
<%@ include file="config.jsp"%>
<%
	if (request.getParameter("Submit") != null) {
		String username = request.getParameter("username");
		Vector errors = new Vector();
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, user, pw);
		Statement stmt = con.createStatement();
		String sql = "select * from customer where username like'"
				+ username + "' ";
		ResultSet rs = stmt.executeQuery(sql);
		if (!rs.next()) {
			errors.add("ชื่อผู้ใช้งานไม่ถูกต้อง");
		}
		if (errors.size() > 0) {
%><%@ include file="ckError.jsp"%>
<%
	} else {
%>
<jsp:forward page="forget_pw2.jsp" />
<%
	}
	} else {
%>
<form action="forget_pw1.jsp" method="post">
	<table width="35%" border="1" align="center" cellpadding="0"
		cellspacing="0">
		<tr bgcolor="#0000FF">
			<td colspan="2"><span style="font-weight: bold; color: #FFFFFF;">ลืมรหัสผ่าน
					1 </span></td>
		</tr>
		<tr>
			<td width="40%">กรอกชื่อเข้าสู่ระบบ</td>
			<td width="60%"><input name="username" type="text"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type="submit" name="Submit" value="ตกลง"></td>
		</tr>
	</table>
</form>
<%
	}
%>
