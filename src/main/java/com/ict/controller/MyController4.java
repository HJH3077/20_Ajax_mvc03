package com.ict.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ict.model.Text3Command;

@WebServlet("/MyController4")
public class MyController4 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/plain; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		// 성공하면 1이고, 실패하면 0
		Text3Command  txt = new Text3Command();
		String msg = txt.exec(request, response);
		out.println(msg);
	}
}