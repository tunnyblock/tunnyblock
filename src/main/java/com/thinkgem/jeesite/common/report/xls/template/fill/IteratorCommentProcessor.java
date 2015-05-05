package com.thinkgem.jeesite.common.report.xls.template.fill;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Comment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import ognl.Ognl;
import ognl.OgnlException;




import com.thinkgem.jeesite.common.report.XLSReportCfgException;
import com.thinkgem.jeesite.common.report.XLSReportException;
import com.thinkgem.jeesite.common.report.XLSUtil;
import com.thinkgem.jeesite.common.report.xls.data.XLSReportBeanDataSource;

/**
 * Implementation of {@link CommentProcessor},
 * it fills a list in the XLS horizontally.
 * Besides 'type', 'expression', 'firstIndex' and 'dataMapping' are added to finish that,
 * 1) expression, mandatory, a OGNL expression, is used to get the list from XLS data
 * 2) firstIndex, mandatory, the beginning row index of filling list
 * 3) dataMapping, mandatory, a Map<Integer, String> value, 
 * 		whose key is the cell column index and value is a OGNL expression to 
 * 		get the cell value from list element.
 * In filling, the list element is transfered by {@link XLSReportBeanDataSource},
 * and the index of element is put in the transfered data as key 'index'.
 * A typical configuration is like this,
 * { type : 'I', expression : 'students', dataMapping : { 1 : 'index', 2 : 'name'...} }
 * @author 俞超
 *
 */
public class IteratorCommentProcessor implements CommentProcessor {
	
	public static String TYPE_ID = "I";
	
	private static Log logger = LogFactory.getLog(IteratorCommentProcessor.class);
	
	private boolean inited;
	
	private final Comment comment;
	
	private String expression;
	
	private int firstIndex;
	
	private Map<String, String> dataMapping;
	
	public IteratorCommentProcessor(Comment comment) {
		this.comment = comment;
	}

	public String getExpression() {
		return expression;
	}

	public void setExpression(String expression) {
		this.expression = expression;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public Map<String, String> getDataMapping() {
		return dataMapping;
	}

	public void setDataMapping(Map<String, String> dataMapping) {
		this.dataMapping = dataMapping;
	}

	@SuppressWarnings("unchecked")
	@Override
	public void init() {
		try {
			Map<String, Object> classMap = new HashMap<String, Object>();
			classMap.put("dataMapping", Map.class);
			Map<String, Object> cfg = (Map<String, Object>) JSONObject.toBean(
					JSONObject.fromObject(this.comment.getString().toString()),
					Map.class,
					classMap);
			Object expresionCfg = cfg.get("expression");
			Object firstIndexCfg = cfg.get("firstIndex");
			Object dataMappingCfg = cfg.get("dataMapping");
			if (expresionCfg == null || !(expresionCfg instanceof String)) {
				throw new XLSReportCfgException("expresion must be configured and its type must be String");
			}
			this.expression = (String) expresionCfg;
			if (firstIndexCfg == null || !(firstIndexCfg instanceof Integer)) {
				throw new XLSReportCfgException("firstIndex must be configured and its type must be Integer");
			}
			this.firstIndex = (Integer) firstIndexCfg;
			if (dataMappingCfg == null || !(dataMappingCfg instanceof Map)) {
				throw new XLSReportCfgException("dataMapping must be configured and its type must be Map");
			}
			this.dataMapping = (Map<String, String>) dataMappingCfg;
			this.inited = true;
		} catch (JSONException e) {
			throw new XLSReportCfgException("the comment configuration at [" + 
					comment.getRow() + "," + comment.getColumn() + "] " + comment.getString().toString() + 
					" is error", e);
		}
	}

	@Override
	public boolean isInited() {
		return this.inited;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void process(Sheet sheet, Map dataSource) {
		// TODO Auto-generated method stub
		try {
			if (!isInited()) 
				throw new XLSReportException("the CommentProcessor has not inited yet");
			Object content = Ognl.getValue(this.expression, dataSource);
			if (content == null) {
				content = Collections.EMPTY_LIST;
			}
			if (!(content instanceof Iterable)) {
				content = Arrays.asList(content);
			}
			int index = 0;
			for (Object element : (Iterable) content) {
				//insert a new row
				logger.debug("insert a new row at index " + (this.firstIndex + index));
				sheet.shiftRows(this.firstIndex + index, sheet.getLastRowNum(), 1, true, false);
				//clone row
				logger.debug("clone the row at index[" + (this.firstIndex + index + 1) + "] to the new row at index[" + (this.firstIndex + index) + "]");
				XLSUtil.cloneRow(sheet, sheet.getRow(this.firstIndex + index + 1), sheet.createRow(this.firstIndex + index));
				Row aimedRow = sheet.getRow(this.firstIndex + index);
				//fill data
				for (String key : this.dataMapping.keySet()) {
					int cellIndex = Integer.parseInt(key);
					Map rowDS = new XLSReportBeanDataSource(element).getData();
					rowDS.put("index", index);
					Cell aimedCell = aimedRow.getCell(cellIndex);
					if (aimedCell == null)
						aimedCell = aimedRow.createCell(cellIndex);
					Object value = Ognl.getValue(this.dataMapping.get(key), rowDS);
					logger.debug("set the value of cell[" + (this.firstIndex + index) + ", " + cellIndex + "] to " + value);
					XLSUtil.setCellValue(aimedCell, value);
				}
				index++;
			}
			// remove template row if having inserted new rows
			if (index > 0) {
			if(this.firstIndex + index==sheet.getLastRowNum()){
					logger.debug("remove the template row at index " + (this.firstIndex + index + 1));
					sheet.shiftRows(this.firstIndex + index+1, this.firstIndex + index+1, -1, true, false);	
				}
				else{
					logger.debug("remove the template row at index " + (this.firstIndex + index + 1));
					sheet.shiftRows(this.firstIndex + index + 1, sheet.getLastRowNum(), -1, true, false);
				}
				
			}
			// remove comment
			XLSUtil.removeComment(sheet, this.comment);
		} catch (OgnlException e) {
			throw new XLSReportException("extracting data error while using OGNL expression[" + 
					this.expression + "] with root object : " + dataSource);
		}
	}

}
