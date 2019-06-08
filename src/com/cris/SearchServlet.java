package com.cris;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

public class SearchServlet extends HttpServlet{
	 static List<String> datas;

	/**
	 * 模拟数据
	 */
	static{
		datas = new ArrayList<String>();
		datas.add("ajax");
		datas.add("ajax2");
		datas.add("ajax3");
		datas.add("ajax4");
		datas.add("ajax5");
		datas.add("Aldin");
		datas.add("bell");
		datas.add("Camilla");
		datas.add("Candace");
		datas.add("Julian");
		datas.add("Julie");
		datas.add("Grady");
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
		String keyword = req.getParameter("keyword");
		List<String> listData=getData(keyword); 
		response.getWriter().write(JSONArray.fromObject(listData).toString());
	}
	
	public List<String> getData(String keyword){
		List<String> list = new ArrayList<String>();
		for(String data:datas){		
			if(data.contains(keyword)){
				list.add(data);
			}
		}
		return list;
	}
}
