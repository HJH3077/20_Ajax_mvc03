package com.ict.model;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ict.db.DAO;
import com.ict.db.VO;

public class XmlCommand {
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		StringBuffer sb = new StringBuffer();
		List<VO> list = DAO.getList();
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		sb.append("<members>");
		for (VO k : list) {
			sb.append("<member>");
			sb.append("<idx>" + k.getIdx() + "</idx>");
			sb.append("<id>" + k.getId() + "</id>");
			sb.append("<pw>" + k.getPw() + "</pw>");
			sb.append("<name>" + k.getName() + "</name>");
			sb.append("<age>" + k.getAge() + "</age>");
			sb.append("<addr>" + k.getAddr() + "</addr>");
			sb.append("<reg>" + k.getReg().substring(0, 10) + "</reg>");
			sb.append("</member>");
		}
		sb.append("</members>");
		return sb.toString();
	}
}
