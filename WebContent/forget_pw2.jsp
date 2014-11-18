<%@ page contentType="text/html; charset=windows-874" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page import="java.util.*"%>
<%@ include file="header.jsp"%>
<%@ include file="config.jsp"%>
<%
	String username = request.getParameter("username");
	String que_forget = request.getParameter("que_forget");
	String ans_forget = request.getParameter("ans_forget");
	Vector errors = new Vector();
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
	if (request.getParameter("Submit2") != null) {
		sql = "select * from customer where username like '" + username
				+ "' and que_forget='" + que_forget
				+ "' and ans_forget like '" + ans_forget + "'";
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			out.println("<br><table align='center' border=1 width=200 ><tr><td>ชื่อผู้ใช้งาน คือ "
					+ rs.getString("username"));
			out.println("<br>รหัสผ่าน คือ " + rs.getString("password")
					+ "</td></tr></table>");
			out.println("<br><center>ทำการล็อกอินเข้าสู่ระบบ");
%>
<%@ include file="form_customer_login.jsp"%>
<%
	} else {
			errors.add("คำตอบไม่ถูกต้อง");
			if (errors.size() > 0) {
%><%@ include file="ckError.jsp"%>
<%
	}
		}
	} else {
		sql = "select * from customer where username like'" + username
				+ "' ";
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			que_forget = new String(rs.getString("que_forget")
					.getBytes("ISO8859_1"), "windows-874");
%>
<form action="forget_pw2.jsp" method="post">
	<table width="35%" border="1" align="center" cellpadding="0"
		cellspacing="0">
		<tr bgcolor="#0000FF">
			<td colspan="2"><span style="font-weight: bold; color: #FFFFFF;">ลืมรหัสผ่าน
					2 </span></td>
		</tr>
		<tr>
			<td width="31%">ชื่อเข้าสู่ระบบ</td>
			<td width="69%"><%=rs.getString("username")%></td>
		</tr>
		<tr>
			<td width="31%">คำถาม</td>
			<td><%=que_forget%></td>
		</tr>
		<tr>
			<td width="31%">คำตอบ</td>
			<td><input name="ans_forget" type="text"></td>
		</tr>
		<tr>
			<td><input name="username" type="hidden" value="<%=username%>">
				<input name="que_forget" type="hidden" value="<%=que_forget%>"></td>
			<td><input name="Submit2" type="submit" value="ตกลง"></td>
		</tr>
	</table>
</form>
<%
	}
		rs.close();
	}
%>
