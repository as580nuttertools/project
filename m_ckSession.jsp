<%@ page contentType="text/html; charset=windows-874"%>
<%!public boolean isSession(Object username, Object status, String select) {
		try {
			if (!(username.equals("") || username == null || (!status
					.equals(select))))
				return true;
			else
				return false;
		} catch (NullPointerException e) {
			return false;
		}
	}%>
