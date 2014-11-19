<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*"%>
<%@ include file="header.jsp"%>
<%@ include file="config.jsp"%>
<%
	String b_id = request.getParameter("b_id");
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql = "select * from book where b_id=" + b_id;
	ResultSet rs = stmt.executeQuery(sql);
	while (rs.next()) {
%>
<table width="80%" align="center">
	<tr>
		<td colspan="3"><strong>ชื่อหนังสือ :</strong> <a
			href="product_detail.jsp?b_id=<%=rs.getString("b_id")%>"><%=new String(rs.getString("title")
						.getBytes("ISO8859_1"), "windows-874")%></a></td>
	</tr>
	<tr>
		<td width="14%">&nbsp;</td>
		<td width="15%"><strong>ผู้เขียน</strong></td>
		<td width="71%"><%=new String(rs.getString("author").getBytes(
						"ISO8859_1"), "windows-874")%></td>
	</tr>
	<tr>
		<td rowspan="4"><img
			src="Image/pic_book/<%=rs.getString("image")%>" width="80"
			height="100" /></td>
		<td><strong>ISBN</strong></td>
		<td><%=rs.getString("isbn")%></td>
	</tr>
	<tr>
		<td><strong>จำนวนหน้า</strong></td>
		<td><%=rs.getString("n_page")%></td>
	</tr>
	<tr>
		<td><strong>สำนักพิมพ์</strong></td>
		<td><%=new String(rs.getString("publisher").getBytes(
						"ISO8859_1"), "windows-874")%></td>
	</tr>
	<tr>
		<td><strong>จัดพิมพ์ครั้งที่</strong></td>
		<td><%=rs.getString("time")%></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><strong>ราคา</strong></td>
		<td><%=rs.getString("price")%></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td valign="top"><strong>รายละเอียด</strong></td>
		<td><%=new String(rs.getString("description").getBytes(
						"ISO8859_1"), "windows-874")%></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="2">
				<%
					if (session.getAttribute("j_fname") != null) {
								if (session.getAttribute("status").equals("customer")) {
				%> <a href="add_to_cart.jsp?b_id=<%=rs.getString("b_id")%>"
				class=Button>หยิบใส่รถเข็น</a> <%
 	}
 			}
 %>
			</td>
	</tr>
</table>
<%
	}
%>
