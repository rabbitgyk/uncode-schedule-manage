package com.rabbit.manage.model;

import cn.uncode.schedule.core.TaskDefine;

public class TaskDefineShow extends TaskDefine {

	private String lastRunningTimeShow;
	private String startTimeShow;
	private String periodShow;
	
	public TaskDefineShow(){
		
	}
	
	public TaskDefineShow(TaskDefine taskDefine){
		this.setCronExpression(taskDefine.getCronExpression());
		this.setCurrentServer(taskDefine.getCurrentServer());
		this.setLastRunningTime(taskDefine.getLastRunningTime());
		this.setParams(taskDefine.getParams());
		this.setPeriod(taskDefine.getPeriod());
		this.setRunTimes(taskDefine.getRunTimes());
		this.setStartTime(taskDefine.getStartTime());
		this.setTargetBean(taskDefine.getTargetBean());
		this.setTargetMethod(taskDefine.getTargetMethod());
		this.setType(taskDefine.getType());
	}

	public String getLastRunningTimeShow() {
		return lastRunningTimeShow;
	}

	public void setLastRunningTimeShow(String lastRunningTimeShow) {
		this.lastRunningTimeShow = lastRunningTimeShow;
	}

	public String getStartTimeShow() {
		return startTimeShow;
	}

	public void setStartTimeShow(String startTimeShow) {
		this.startTimeShow = startTimeShow;
	}

	public String getPeriodShow() {
		return periodShow;
	}

	public void setPeriodShow(String periodShow) {
		this.periodShow = periodShow;
	}
}
