package com.rabbit.manage.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.uncode.schedule.ConsoleManager;
import cn.uncode.schedule.ZKScheduleManager;
import cn.uncode.schedule.core.TaskDefine;

import com.alibaba.fastjson.JSONObject;
import com.rabbit.manage.model.TaskDefineShow;

@Controller
@RequestMapping("/main")
public class MainController {
	private Logger log = LoggerFactory.getLogger(MainController.class);

	@RequestMapping("/page")
	public String mPage(){
		return "manage";
	}
	
	@RequestMapping(value="/servers", method =RequestMethod.GET)
	@ResponseBody
	public String servers(){
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
		log.info("获取到的所有的server node：{}", JSONObject.toJSONString(servers));
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
	
	@RequestMapping(value="/server/ips", method =RequestMethod.GET)
	@ResponseBody
	public String serverIps(){
		List<String> serverIps = null;
		try {
			serverIps = ConsoleManager.getServerIps();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		log.info("获取到的所有的server ip：{}", JSONObject.toJSONString(serverIps));
		return JSONObject.toJSONString(serverIps);
	}
	
	@RequestMapping(value="/tasks", method =RequestMethod.GET)
	@ResponseBody
	public String tasks(){
		List<TaskDefineShow> tasksShow = new ArrayList<TaskDefineShow>();
		List<TaskDefine> tasks = ConsoleManager.queryScheduleTask();
		log.info("获取到的所有的task list：{}", JSONObject.toJSONString(tasks));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(TaskDefine task : tasks){
			TaskDefineShow taskDefineShow = new TaskDefineShow(task);
			if(task.getLastRunningTime() > 0){
				taskDefineShow.setLastRunningTimeShow(sdf.format(task.getLastRunningTime()));
			}else{
				taskDefineShow.setLastRunningTimeShow("-");
			}
			
			tasksShow.add(taskDefineShow);
		}
		return JSONObject.toJSONString(tasksShow);
	}
	
	@RequestMapping(value="/task/del", method =RequestMethod.GET)
	@ResponseBody
	public String delTask(String targetBean, String targetMethod){
		JSONObject result = new JSONObject();
		if(StringUtils.isEmpty(targetBean) || StringUtils.isEmpty(targetMethod)){
			result.put("returnCode", "9999");
			result.put("returnMsg", "bean or method is null");
			return result.toJSONString();
		}
		TaskDefine taskDefine = new TaskDefine();
		taskDefine.setTargetBean(targetBean);
		taskDefine.setTargetMethod(targetMethod);
		ConsoleManager.delScheduleTask(taskDefine);
		
		result.put("returnCode", "0000");
		result.put("returnMsg", "del success");
		return result.toJSONString();
	}
	
	@RequestMapping(value="/task", method =RequestMethod.POST)
	@ResponseBody
	public String addTask(TaskDefine taskDefine){
		log.info("添加定时任务：{}", JSONObject.toJSONString(taskDefine));
		JSONObject result = new JSONObject();
		taskDefine.setType(TaskDefine.TASK_TYPE_UNCODE);
		// || StringUtils.isNotEmpty(taskDefine.getPeriod()+"")
		if(StringUtils.isNotEmpty(taskDefine.getCronExpression())){
			ConsoleManager.addScheduleTask(taskDefine);
		}
		
		result.put("returnCode", "0000");
		result.put("returnMsg", "add success");
		return result.toJSONString();
	}
	
}
