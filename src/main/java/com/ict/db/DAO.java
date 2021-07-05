package com.ict.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

public class DAO {
	private static SqlSession ss;

	private synchronized static SqlSession getSession() {
		if (ss == null) { 
			ss = DBService.getFactory().openSession(false);
		}
		return ss;
	}

	public static List<VO> getList() {
		List<VO> list = new ArrayList<VO>();
		list = getSession().selectList("list");
		return list;
	}

	public static List<VO> getIdChk(String id){
		List<VO> list = null;
		list = getSession().selectList("idchk", id);
		return list;
	}
	
	public static int getInsert(VO vo) {
		int result = 0 ;
		result = getSession().insert("insert", vo);
		ss.commit();
		return result;
	}
	
	public static int getDelete(String idx) {
		int result = 0 ;
		result = getSession().insert("delete", idx);
		ss.commit();
		return result;
	}

}
