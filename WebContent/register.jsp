<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.Vector"%>
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
		//ร้องขอค่าจากฟอร์ม
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String cpassword = request.getParameter("cpassword");
		String email = request.getParameter("email");
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String tel = request.getParameter("tel");
		String address = request.getParameter("address");
		String province = request.getParameter("province");
		String city = request.getParameter("city");
		String zip = request.getParameter("zip");
		String status = request.getParameter("status");

		//ตรวจสอบว่าชื่อ username ซ้ำหรือไม่
		sql = "select username from user where username='"
				+ username + "'";
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			errors.add("ซื่อเข้าสู่ระบบมีคนใช้แล้ว");
		}
		//ตรวจสอบความถูกต้องของข้อมูลจากฟอร์ม
		if (username.equals("")) {
			errors.add("กรุณากรอกชื่อเข้าสู่ระบบ");
		}
		if (password.equals("")) {
			errors.add("กรุณากรอกรหัสผ่าน");
		}
		if (!password.equals("")) {
			if (password.length() < 6) {
				errors.add("กรุณากรอกรหัสผ่านมากกว่า 6 ตัวอักษรเท่านั้น");
			}
		}
		if (cpassword.equals("")) {
			errors.add("กรุณากรอกยืนยันรหัสผ่าน");
		}
		if (!password.equals(cpassword)) {
			errors.add("รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน");
		}
		if (email.equals("")) {
			errors.add("กรุณากรอกชื่ออีเมล์");
		}
		if (!email.equals("")) {
			if ((email.equals("")) || (email.indexOf('@') == -1)
					|| (email.indexOf('.') == -1)) {
				errors.add("ชื่ออีเมล์ไม่ถูกต้อง");
			}
		}
		//ตรวจสอบว่าชื่อ username ซ้ำหรือไม่
		sql = "select username from user where email='" + email
				+ "'";
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			errors.add("ชื่ออีเมล์มีคนใช้แล้ว");
		}
		if (fname.equals("")) {
			errors.add("กรุณากรอกชื่อ");
		}
		if (lname.equals("")) {
			errors.add("กรุณากรอกนามสกุล");
		}
		if (tel.equals("")) {
			errors.add("กรุณากรอกเบอร์โทรศัพท์");
		}
		if (!tel.equals("")) {
			if (!isNumeric(tel)) {
				errors.add("กรุณากรอกเบอร์โทรศัพท์ที่เป็นตัวเลขเท่านั้น");
			}
			if (tel.length() != 10) {
				errors.add("กรุณากรอกเบอร์โทรศัพท์ที่มีตัวเลข 10 ตัวเลขเท่านั้น");
			}
		}
		if (address.equals("")) {
			errors.add("กรุณากรอกที่อยู่");
		}
		if (province.equals("")) {
			errors.add("กรุณากรอกอำเภอ/เขต");
		}
		if (city.equals("")) {
			errors.add("กรุณากรอกจังหวัด");
		}
		if (zip.equals("")) {
			errors.add("กรุณากรอกรหัสไปรษณีย์");
		}
		if (!zip.equals("")) {
			if (!isNumeric(zip)) {
				errors.add("กรุณากรอกรหัสไปรษณีย์ที่เป็นตัวเลขเท่านั้น");
			}
			if (zip.length() != 5) {
				errors.add("กรุณากรอกรหัสไปรษณีย์ที่มีตัวเลข 5 ตัวเลขเท่านั้น");
			}
		}

		rs.close();
		if (errors.size() > 0) {
%>
<%@ include file="ckError.jsp"%>
<%
	} else {
			sql = "insert into user (username,password,email,fname,lname,tel,address,province,city,zip,status) VALUES ('"
					+ username
					+ "','"
					+ password
					+ "','"
					+ email
					+ "','"
					+ fname
					+ "','"
					+ lname
					+ "','"
					+ tel
					+ "','"
					+ address
					+ "','"
					+ province
					+ "','"
					+ city
					+ "','"
					+ zip
					+ "','customer') ";

			int row = stmt.executeUpdate(sql);
			if (row != 0) {
				out.println("<center><a href='customer_login.jsp?j_username="
						+ username
						+ "&j_password="
						+ password
						+ "'>เข้าสู่ระบบ</a></center>");
			}
		}

		rs.close();
	} else {
%>
<br>
<form method="post" action="register.jsp">
	<table width="60%" border="0" align="center" cellspacing="0"
		bgcolor="#E1EEEE">
		<tr bgcolor="#0000FF">
			<td colspan="2"><div align="center"
					style="font-weight: bold; color: #FFFFFF;">ลงทะเบียนสมาชิก</div></td>
		</tr>
		<tr bgcolor="#79CDCD">
			<td colspan="2"><span style="font-weight: bold">ข้อมูลที่ใช้เข้าสู่ระบบ</span></td>
		</tr>
		<tr>
			<td width="24%">ชื่อเข้าสู่ระบบ</td>
			<td width="76%"><input name="username" type="text" size="12"
				maxlength="12"></td>
		</tr>
		<tr>
			<td>รหัสผ่าน</td>
			<td><input name="password" type="password" size="12"
				maxlength="12"></td>
		</tr>
		<tr>
			<td>ยืนยันรหัสผ่าน</td>
			<td><input name="cpassword" type="password" size="12"
				maxlength="12"></td>
		</tr>
		<tr>
		<tr bgcolor="#79CDCD">
			<td colspan="2"><span style="font-weight: bold">ข้อมูลส่วนตัว</span></td>
		</tr>
		<tr>
			<td>อีเมล์</td>
			<td><input name="email" type="text"></td>
		</tr>
		<tr>
			<td>ชื่อ</td>
			<td><input name="fname" type="text"></td>
		</tr>
		<tr>
			<td>นามสกุล</td>
			<td><input name="lname" type="text" size="35"></td>
		</tr>
		<tr>
			<td>เบอร์โทรศัพท์</td>
			<td><input name="tel" type="text" size="10" maxlength="10"></td>
		</tr>
		<tr>
			<td>ที่อยู่</td>
			<td><input name="address" type="text" size="50"></td>
		</tr>
		<tr>
			<td>อำเภอ/เขต</td>
			<td><input name="province" type="text"></td>
		</tr>
		<tr>
			<td>จังหวัด</td>
			<td><input name="city" type="text"></td>
		</tr>
		<tr>
			<td>รหัสไปรษณีย์</td>
			<td><input name="zip" type="text" size="5" maxlength="5"></td>
		</tr>
		<tr>
			<td colspan="2"><div align="center">
					<input name="Submit" type="submit" value="ตกลง"> <input
						name="Reset" type="reset" value="ล้างข้อความ">
				</div></td>
		</tr>
	</table>
</form>
<%
	}
	con.close();
%>
<%@ include file="footer.jsp"%>
