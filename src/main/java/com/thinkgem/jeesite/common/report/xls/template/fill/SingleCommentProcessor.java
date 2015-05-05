package com.thinkgem.jeesite.common.report.xls.template.fill;

import java.util.Map;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import ognl.Ognl;
import ognl.OgnlException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Comment;
import org.apache.poi.ss.usermodel.Sheet;

import com.thinkgem.jeesite.common.report.XLSReportCfgException;
import com.thinkgem.jeesite.common.report.XLSReportException;
import com.thinkgem.jeesite.common.report.XLSUtil;

/**
 * Implementation of {@link CommentProcessor},
 * it set the cell where the comment positioned a new value.
 * Besides 'type', 'expression' and 'append' are added to finish that,
 * 1) expression, mandatory, a OGNL expression, is used by the OGNL
 * 		to get the cell value from XLS data
 * 2) append, optional, if set to true, the cell value extracted by the OGNL
 * 		is appended to the end of current cell value, default is false
 * A typical configuration is like this,
 * { type : 'S', expression : 'name', append : true }
 * @author 俞超
 */
public class SingleCommentProcessor implements CommentProcessor {
	
	public static String TYPE_ID = "S";
	
	private static final Log logger = LogFactory.getLog(SingleCommentProcessor.class);
	
	private boolean inited;
	
	private final Comment comment;

	private String expression;
	
	private boolean append;
	
	public SingleCommentProcessor(Comment comment) {
		this.comment = comment;
	}
	
	public String getExpression() {
		return expression;
	}

	public void setExpression(String expression) {
		this.expression = expression;
	}

	public boolean isAppend() {
		return append;
	}

	public void setAppend(boolean append) {
		this.append = append;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void init() {
		try {
			Map<String, Object> cfg = (Map<String, Object>) JSONObject.toBean(JSONObject.fromObject(this.comment.getString().toString()),Map.class);
			Object expresionCfg = cfg.get("expression");
			Object appendCfg = cfg.get("append");
			if (expresionCfg == null || !(expresionCfg instanceof String)) {
				throw new XLSReportCfgException("expresion must be configured and its type must be String");
			}
			this.expression = (String) expresionCfg;
			if (appendCfg != null && !(appendCfg instanceof Boolean)) {
				throw new XLSReportCfgException("the type of append must be Boolean");
			} else if (appendCfg instanceof Boolean) {
				this.append = (Boolean) appendCfg;
			}
			this.inited = true;
		} catch (JSONException e) {
			throw new XLSReportCfgException("the comment configuration at [" + comment.getRow() + "," + comment.getColumn() + "] " + comment.getString().toString() + " must be type of JSON", e);
		}
	}

	@Override
	public boolean isInited() {
		return this.inited;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public void process(Sheet sheet, Map dataSource) {
		try {
			if (!isInited()) 
				throw new XLSReportException("the CommentProcessor has not inited yet");
			Object content = Ognl.getValue(this.expression, dataSource);
			int row = this.comment.getRow();
			int column = this.comment.getColumn();
			Cell aimedCell = sheet.getRow(row).getCell(column);
			String value = this.append ? (XLSUtil.getCellStringValue(aimedCell) + content) : content.toString();
			logger.debug("set the value of cell[" + row + ", " + column + "] to " + value);
			if (this.append) {
				String cellValue = XLSUtil.getCellStringValue(aimedCell) + content;
				logger.debug("set the value of cell[" + row + ", " + column + "] to " + cellValue);
				XLSUtil.setCellValue(aimedCell, cellValue);
			} else {
				logger.debug("set the value of cell[" + row + ", " + column + "] to " + content);
				XLSUtil.setCellValue(aimedCell, content);
			}
			aimedCell.removeCellComment();
		} catch (OgnlException e) {
			throw new XLSReportException("extracting data error while using OGNL expression[" + 
					this.expression + "] with root object : " + dataSource);
		}
	}

}
