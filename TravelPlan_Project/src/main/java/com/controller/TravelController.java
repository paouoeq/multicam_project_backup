package com.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dto.ApiDTO2;
import com.info.Info;
import com.service.ApiService;
import com.service.TravelService;

@Controller
public class TravelController {
	private Info info = new Info();
	
	@Autowired
	TravelService service;
	
	@Autowired
	ApiService apiService;
	
	// 메인UI
	@GetMapping("/travelUI")
	public String travelUI(HttpSession session) {
		session.setAttribute("client_id", info.getKakaoMapId());
		return "travelForm";
	}
	
	// 데이터 삽입
	
	
	// tourAPI json형식으로 jsp로 보냄
	@RequestMapping("/data_download")
	@ResponseBody
	public ArrayList<ApiDTO2> load_save(HttpSession session) throws Exception {
		String result = "";
		ArrayList<ApiDTO2> list = new ArrayList<ApiDTO2>();
		//http://apis.data.go.kr/B551011/KorService1/areaBasedList1?serviceKey=%2BZ2oseaIvHt%2BFFNkhvJA2vGpTcpF%2FydeQrkUsMt7W7SPky11jcfHaJ0HnB4VAR%2Bv3zvDnuyQRhL4zupPemFCAA%3D%3D&pageNo=1&numOfRows=7901&MobileOS=ETC&MobileApp=AppTest&_type=json&areaCode=39
		URL url = new URL("http://apis.data.go.kr/B551011/KorService1/areaBasedList1?serviceKey=" + info.getTourAPIKey() +
		   "&pageNo=3&numOfRows=1000&MobileOS=ETC&MobileApp=AppTest&_type=json&areaCode=39");
		BufferedReader bf;
		bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
		result = bf.readLine();
		System.out.println("result: "+result); // O
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject)jsonParser.parse(result);
		JSONObject response = (JSONObject)jsonObject.get("response");
		JSONObject body = (JSONObject)response.get("body");
		JSONObject items = (JSONObject)body.get("items");
		   
		JSONArray infoArr = (JSONArray) items.get("item");
		//System.out.println("infoArr: "+infoArr);
		   
		   
		for(int i=0;i<infoArr.size();i++){
			JSONObject tmp = (JSONObject)infoArr.get(i);
			       
			ApiDTO2 dto=new ApiDTO2((String)tmp.get("title"),(String)tmp.get("addr1"),(String)tmp.get("addr2"),(String)tmp.get("mapx"),(String)tmp.get("mapy"),(String)tmp.get("areacode"),(String)tmp.get("contenttypeid"));
			//System.out.println(dto);
			if(dto!=null) {
				list.add(dto);
			}
		}
		apiService.insertApi(list);
		return list;
	}
	
	// 세부 일정에 추가
	@GetMapping("/scheduleList")
	@ResponseBody
	public List<ApiDTO2> scheduleList(@RequestParam HashMap<String, String> map) {
		List<ApiDTO2> list = apiService.findSpot(map);
		
		return list;
	}
	
	// mapTest용
	@GetMapping("/map")
	public String map(HttpSession session) {
		session.setAttribute("client_id", info.getKakaoMapId());
		return "map/mapTest";
	}
	
	@GetMapping("/test")
	public String test(HttpSession session) {
		session.setAttribute("client_id", info.getKakaoMapId());
		return "test";
	}
}