package com.thinkgem.jeesite.modules.dynamicmessage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.modules.process.entity.DynamicMessage;
import com.thinkgem.jeesite.modules.process.service.DynamicMessageService;

@Controller
@RequestMapping(value = "${adminPath}/dynamicmessages")
public class DynamicMessageController {
	
	@Autowired
	private DynamicMessageService dynamicMessageService;
	
	/**
	 * 获取用户名下动态消息列表
	 * @param dynamicMessage
	 * @return
	 */
	@RequestMapping({"list", ""})
	@ResponseBody
	public String getDynamicMessagesByUserId(DynamicMessage dynamicMessage){
		Map<String,Object> dynamicMessageMap = new HashMap<String,Object>();
		List<DynamicMessage> list = dynamicMessageService.find(dynamicMessage);
		dynamicMessageMap.put("count", list.size());
		dynamicMessageMap.put("list", list);
		return JsonMapper.toJsonString(dynamicMessageMap);
	}
	
	/**
	 * 设置为已读
	 * @param messageId
	 * @return
	 */
	@RequestMapping(value="/{messageId}/read")
	@ResponseBody
	public String readMessage(@PathVariable String messageId){
		dynamicMessageService.readDynamicMessage(dynamicMessageService.get(messageId));
		return JsonMapper.toJsonString(true);
	}
	

}
