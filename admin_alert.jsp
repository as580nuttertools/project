<%@ include file="m_ckSession.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ include file="header_admin.jsp"%>
<%@ page import="java.sql.*,java.util.Vector"%>
<%@ include file="config.jsp"%>
<%
	//ตรวจสอบว่าเข้าสู่ระบบแล้วโดยผู้ดูแลระบบแล้วหรือยัง
	if (!isSession(session.getAttribute("j_username"),
			session.getAttribute("status"), "admin")) {
		response.sendRedirect("session_er.jsp");
	}

	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
	Vector errors = new Vector();
	sql = "select * from orders where status='1'";
	rs = stmt.executeQuery(sql);
	if (rs.next())
	{
		rs.close();
%>
<script>
	if (confirm("มีรายการสั่งซื้อ  คุณต้องการที่จะไปยังหน้ารายการสั่งซื้อหรือไม่ ?")) {
		location = "admin_data_orders.jsp";
	} else {
		rs.close();
		location = "admin.jsp";
	}
</script>
<%
	}
%>
