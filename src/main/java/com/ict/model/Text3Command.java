package com.ict.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ict.db.DAO;

public class Text3Command {
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		String result = "";
		int res = DAO.getDelete(request.getParameter("idx"));
		result = String.valueOf(res);
		return result;
	}
}