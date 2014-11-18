<%@ page import="java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%!//เมธอดเปลี่ยนรูปแบบวันที่จาก yyyy-mm-dd ในฐานข้อมูลเป็น วัน เดือน ปี รูปแบบภาษาไทย
	public static String dateTH(String date) {
		String[] month = { "มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน",
				"พฤษภาคม", "มิถุนายน", "กรกฎาคม", "สิงหาคม", "กันยายน",
				"ตุลาคม", "พฤษจิกายน", "ธันวาคม" };
		String yy = "" + (Integer.parseInt(date.substring(0, 4)) + 543);
		String mm = month[(Integer.parseInt(date.substring(5, 7)) - 1)];
		String dd = "" + (Integer.parseInt(date.substring(8, 10)));
		String dateTH = dd + " " + mm + " " + yy;
		return dateTH;
	}%>
