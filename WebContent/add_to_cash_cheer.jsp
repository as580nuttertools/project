<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*"%>
<%@ include file="config.jsp"%>
<jsp:useBean id="cart" class="ktpbook.ProductCart" scope="session" />
<%
	String b_id = request.getParameter("b_id");
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql = "select * from book where b_id=" + b_id;
	ResultSet rs = stmt.executeQuery(sql);
	while (rs.next()) {
		if (Integer.parseInt(rs.getString("quantity")) == 0) {
%><SCRIPT LANGUAGE="JavaScript">
	alert("ขอภัย หนังสือหมด");
	history.back();
</script>
<%
	} else {
			cart.addItem(rs.getString("b_id"), rs.getString("title"),
					1, rs.getString("price"));
			response.sendRedirect("cash_cheer_menu.jsp");
		}
	}
	rs.close();
	con.close();
%>
