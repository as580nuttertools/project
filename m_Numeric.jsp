<%!//àÁ¸Í´ãªéµÃÇ¨ÊÍºÇèÒà»ç¹µÑÇàÅ¢ËÃ×ÍäÁè ¶éÒà»ç¹µÑÇàÅ¢¨Ð¤×¹¤èÒà»ç¹ true
	public boolean isNumeric(String data) {
		try {
			Integer.parseInt(data);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}%>
