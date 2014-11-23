<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ include file="config.jsp"%>
<%@ include file="m_date.jsp"%>
<jsp:useBean id="pa" class="ktpbook.PageBean" scope="session" />
<%
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
	try {
%>
<br>
<form name="frmSearch" method="post" action="circulation_menu.jsp">
	<table width="90%" border="1" align="center" cellspacing="0"
		bordercolor="black" bgcolor="#79CDCD">
		<tr align="center">
			<td><b>ยอดขาย</b></td>
		</tr>
	</table>
</form>
<%
	//ตรวจสอบค่าปุ่มที่กด
		String action = "";
		if (request.getParameter("bFirst") != "1") {
			action = "first";
		}
		if (request.getParameter("bPrevious") != null) {
			action = "previous";
		}
		if (request.getParameter("bNext") != null) {
			action = "next";
		}
		if (request.getParameter("bLast") != null) {
			action = "last";
		}
		if (request.getParameter("bPageNo") != null) {
			//ดักจับข้อผิดพลาดค่าของ pageNo ว่าเป็นตัวเลขหรือไม่
			try {
				pa.setPageNo(Integer.parseInt(request
						.getParameter("pageNo")));
				action = "pageNo";
			} catch (NumberFormatException e) {
			}
		}

		int totalRow = 0;
		//หาจำนวนหนังสือ
		sql = "select  count(*) as totalRow from book WHERE title like '%%' or isbn like '%%'";
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			totalRow = rs.getInt("totalRow");
		}
		rs.close();
		//กำหนดค่าต่างๆ ใน bean
		pa.setTotalRow(totalRow);
		pa.actionPage(action, 100);
		// แสดงหนังสือตามค่าที่กำหนด
		sql = "SELECT * FROM book WHERE title like '%%' or isbn like '%%' order by isbn";
		rs = stmt.executeQuery(sql);
		rs.absolute(pa.getStartRow()); //กำหนดแถวค่าแรกที่แสดง
		con.close();
%>
<table width="90%" border="1" align="center" cellspacing="0"
	bordercolor="black" bgcolor="#E1EEEE">
	<tr bgcolor="#79CDCD">
		<td align="center"><span style="font-weight: bold">ISBN</span></td>
		<td align="center"><span style="font-weight: bold">ชื่อหนังสือ</span></td>
		<td width="20%" align="center"><span style="font-weight: bold">จำนวนคงเหลือ</span></td>
		<td width="15%" align="center"><span style="font-weight: bold">ยอดขาย
		</span></td>
	</tr>
	<%
		do {
	%>
	<tr>
		<td align="center"><%=rs.getString("isbn")%></td>
		<td><%=new String(rs.getString("title").getBytes(
							"ISO8859_1"), "windows-874")%></td>
		<td align="center"><%=rs.getString("quantity")%> เล่ม</td>
		<td align="center"><%=rs.getString("score")%> เล่ม</td>
	</tr>
	<%
		} while (rs.next() && rs.getRow() <= pa.getEndRow());
	%>

	<tr>
		<td colspan="5"><div align="center">
					<input name="print" type="button" id="print"
						onClick="window.print()" value=" พิมพ์ "> <input
						name="close" type="button" id="close2" onClick="window.close()"
						value="ปิด  ">
				</div></td>
	</tr>
</table>
<%
	} catch (Exception e) {
		out.println("ไม่มีหนังสือ");
	}
	rs.close();
	con.close();
%>
<jsp:include page="footer.jsp" />
