package com.thinkgem.jeesite.modules.sys.web;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.utils.DateUtils;

@Controller
@RequestMapping(value = "${adminPath}/upload")
public class UploadController {

	@RequestMapping(value="/client",method=RequestMethod.POST)
	@ResponseBody
	public String uploadClientFile(HttpServletRequest request, HttpServletResponse response) throws IOException{
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
	    Iterator<String> fileNames = multipartRequest.getFileNames();
	    MultipartFile multipartFile = multipartRequest.getFile(fileNames.next());
	    //加上操作内容加箱号
	    String requestFilePath = request.getParameter("filepath");
	    String tankCode = request.getParameter("tankcode");
	    String name = multipartFile.getOriginalFilename();
	    String realPath = request.getSession().getServletContext().getRealPath("/upload"); 
	    String filePath = "/upload";
	    if(!StringUtils.isEmpty(tankCode)){
	    	realPath = realPath+File.separator+tankCode;
	    	filePath  = filePath+ "/"+tankCode;
	    }
	    if(!StringUtils.isEmpty(requestFilePath)){
	    	realPath = realPath+File.separator+requestFilePath;
	    	filePath  = filePath+ "/"+requestFilePath;
	    }
	    
	    //加上时间戳
	    String nowDate = DateUtils.formatDate(new Date(), "yyyyMMdd");
	    realPath = realPath+File.separator+nowDate;
    	filePath  = filePath+ "/"+nowDate;
	    
	    filePath = filePath+"/" + name;
	    saveFile(realPath+File.separator+name, multipartFile.getBytes());
		Map<String, String> resultMap = new HashMap<String, String>();
	    resultMap.put("result", "success");
	    resultMap.put("filePath", filePath);
	    resultMap.put("fileName", name);
	    Object[] result = this.getFileType(name);
	    resultMap.put("isImage", result[0].toString());
	    resultMap.put("fileType", result[1].toString());
	    return JsonMapper.toJsonString(resultMap);
	}
	
	/**
	 * 获取文件类型，判断是否是图片格式
	 * @param fileName
	 * @return
	 */
	public Object[] getFileType(String fileName){
		Boolean flag = false;
		String type="others";
		List<String> knowTypes=Arrays.asList("doc","pdf","ppt","txt","xls","zip");
		if(!StringUtils.isEmpty(fileName)){
			String[] tempArray = fileName.split("\\.");
			type= tempArray[1];
			if("gif".equalsIgnoreCase(type)||"png".equalsIgnoreCase(type)||"jpg".equalsIgnoreCase(type)||"jpeg".equalsIgnoreCase(type)||"bmp".equalsIgnoreCase(type)){
				flag = true;
				return new Object[]{flag,type};
			}
			type = type.toLowerCase();
			if(!knowTypes.contains(type)){
				type = "others";
			}
		}
		return new Object[]{flag,type};
	}
	
	/**
	 * 保存文件
	 * @param filePath
	 * @param content
	 * @throws IOException
	 */
	public void saveFile(String filePath, byte[] content) throws IOException{
		BufferedOutputStream bos = null;
		try {
			File file = new File(filePath);
			if (!file.getParentFile().exists()){
				file.getParentFile().mkdirs();
			}
			file.createNewFile();
		    bos = new BufferedOutputStream(new FileOutputStream(file));
		    bos.write(content);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(bos!=null){
				bos.close();
			}
		}
	}
}
