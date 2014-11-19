<%@ page contentType="text/html; charset=windows-874"%>
<style type='text/css'>
a.Button {
	border-style: solid;
	border-width: 1px;
	color: #000000;
	font-family: "MS Sans Serif", Arial, Tahoma, sans-serif;
	font-size: 12pt;
	font-style: normal;
	font-weight: normal;
	padding: 2px;
	padding-left: 6px;
	padding-right: 6px;
	position: relative;
	text-decoration: none;
}

a.Button:hover {
	border-color: #f0f0f0 #505050 #505050 #f0f0f0;
	text-decoration: none;
	border-style: solid;
	border-width: 1px;
	font-family: "MS Sans Serif", Arial, Tahoma, sans-serif;
	font-size: 12pt;
	font-style: normal;
	font-weight: normal;
	padding: 2px;
	padding-left: 6px;
	padding-right: 6px;
	position: relative;
}
</style>
<body topmargin="0" leftmargin="0">
	<div id="Layer1"
		style="position: absolute; left: 500px; top: 56px; width: 261px; height: 18px; z-index: 1">
		<div align="right">
			<%
				if (session.getAttribute("j_fname") != null) {
			%>
			เข้าสู่ระบบโดย
			<%=session.getAttribute("j_fname")%>
			<%=session.getAttribute("j_lname")%>
			<%
				}
			%>
		</div>
	</div>
	<table width="100%">
		<tr>
			<td width="100%" height="90" colspan="0" bordercolor="#CCCCCC">
				<table width="100%" border="0" align="left" cellpadding="0"
					cellspacing="0">
					<tr>
						<td><input name="image" type="image" src="Image/header.gif"
							align="top" width="100%" height="75" border="0"></td>
					</tr>
					<tr>
						<td bordercolor="#ECE9D8" bgcolor="#CCCCCC"><div
								align="right" class="style1">
								<a href="index.jsp" class=Button>หน้าแรก</a>
								<%
									if (session.getAttribute("j_fname") == null) {
								%>
								<a href="register.jsp" class=Button>สมัครสมาชิก</a> <a
									href="product.jsp" class=Button>รายการหนังสือ</a>
								<%
									}
								%>
								<%
									if (session.getAttribute("j_fname") != null) {
								%>
								<a href="edit_data.jsp" class="button">ข้อมูลส่วนตัว</a>
								<%
									if (session.getAttribute("status").equals("customer")) {
								%>
								<a href="customer_data_orders_menu.jsp" class="button">ข้อมูลการสั่งซือ</a>
								<a href="product.jsp" class=Button>รายการหนังสือ</a> <a
									href="view_cart.jsp" class=Button>รถเข็น</a>
								<%
									}
										if (session.getAttribute("status").equals("admin")) {
								%>
								<a href="admin_data_orders_menu.jsp" class=Button>รายการสั่งซื้อ</a>
								<a href="book_type_list_menu.jsp" class=Button>ประเภทหนังสือ</a>
								<a href="book_list_menu.jsp" class=Button>รายการหนังสือ</a>
								<%
									}
									}
								%>
							</div></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
