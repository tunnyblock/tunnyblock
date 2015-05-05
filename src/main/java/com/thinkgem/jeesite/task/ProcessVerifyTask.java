package com.thinkgem.jeesite.task;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


@Component
public class ProcessVerifyTask {
	
	//@Scheduled(cron="0/30 * *  * * ? ")
	public void checkProcessStatus() {
		//TODO:查询这一个星期内的所有流程..对过期的任务进行标记
		System.out.println("==================================");
	}

}
