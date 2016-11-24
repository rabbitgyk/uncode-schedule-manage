package com.rabbit.manage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;

import cn.uncode.schedule.ConsoleManager;
import cn.uncode.schedule.ZKScheduleManager;

@Controller
@RequestMapping("/main")
public class MainController {
	private Logger log = LoggerFactory.getLogger(MainController.class);

	@RequestMapping("/page")
	public String mPage(){
		return "manage";
	}
	
	@RequestMapping("/servers")
	@ResponseBody
	public String name(){
		ZKScheduleManager manager = null;
		try {
			manager = ConsoleManager.getScheduleManager();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		List<String> servers = null;
		try {
			servers = manager.getScheduleDataManager().loadScheduleServerNames();
		} catch (Exception e) {
			e.printStackTrace();
		}
		log.info("获取到的所有的server node：" + JSONObject.toJSONString(servers));
		List<Map<String, String>> result = new ArrayList<Map<String,String>>();
		if(servers != null){
    		for(int i=0; i< servers.size();i++){
    			String ser = servers.get(i);
    			Map<String, String> server = new HashMap<String, String>();
    			server.put("serverName", ser);
				if(manager.getScheduleDataManager().isLeader(ser, servers)){ //是调度节点
					server.put("isLeader", "1");
				}else{
					server.put("isLeader", "0");
				}
				result.add(server);
    		}
		}
		return JSONObject.toJSONString(result);
	}
}
