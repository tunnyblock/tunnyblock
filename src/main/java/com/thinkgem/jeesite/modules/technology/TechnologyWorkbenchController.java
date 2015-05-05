package com.thinkgem.jeesite.modules.technology;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thinkgem.jeesite.modules.sys.entity.User;


@Controller
@RequestMapping(value = "${adminPath}/technology/workbench")
public class TechnologyWorkbenchController {
	
	@RequestMapping({"list", ""})
	public String list(User user, HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/technology/technologyWorkbench";
	}

}
