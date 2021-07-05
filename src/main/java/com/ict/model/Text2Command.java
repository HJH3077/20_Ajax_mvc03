package com.ict.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ict.db.DAO;
import com.ict.db.VO;

public class Text2Command {
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		String result = "";
		VO vo = new VO();
		vo.setId(request.getParameter("id"));
		vo.setPw(request.getParameter("pw"));
		vo.setName(request.getParameter("name"));
		vo.setAge(request.getParameter("age"));
		vo.setAddr(request.getParameter("addr"));
		
		int res = DAO.getInsert(vo);
		result = String.valueOf(res);
		return result;
	}
}