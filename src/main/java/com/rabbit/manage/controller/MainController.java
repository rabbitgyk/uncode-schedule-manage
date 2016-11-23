package com.rabbit.manage.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/main")
public class MainController {
	private Logger log = LoggerFactory.getLogger(MainController.class);

	@RequestMapping("/page")
	public String mPage(){
		return "manage";
	}
	
	@RequestMapping("/name")
	@ResponseBody
	public String name(String name){
		log.info("name = " + name);
		return "abcv" + name;
	}
}
