package com.thinkgem.jeesite.common.report.xls.template.fill;

import java.util.Map;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.Comment;

import com.thinkgem.jeesite.common.report.XLSReportCfgException;

/**
 * Implementation of factory design pattern,
 * it is used to generate a {@link CommentProcessor} according to
 * the comment content. 
 * The comment content must match the JSON format, e.g. {type:'I'...},
 * and must contain a value for 'type' which is used to determine the class type
 * of {@link CommentProcessor}.
 * For more configuration @see CommentProcessor
 * 
 * @author 俞超
 *
 */
public class CommentProcessorFactory {
	
	private static Log logger = LogFactory.getLog(CommentProcessorFactory.class);
	
	/**
	 * @param comment
	 * @return a corresponding {@link CommentProcessor}
	 * @throws XLSReportCfgException
	 * 	1.if 'type' is not configured
	 *  2.if the value of 'type' is not supported, 
	 *  	currently two types are legal, S and I.
	 */
	public static CommentProcessor getCommentProcessor(Comment comment) {
		CommentProcessor commentProcessor = null;
		logger.debug("generate a corresponding CommentProcessor for " + comment.getString());
		Map<String, Object> cfg = analyzeComment(comment);
		String type = (String) cfg.get("type");
		if (StringUtils.isBlank(type)) {
			throw new XLSReportCfgException("type must be configured in the comment");
		}
		if (SingleCommentProcessor.TYPE_ID.equals(type)) {
			commentProcessor = new SingleCommentProcessor(comment);
		} else if (IteratorCommentProcessor.TYPE_ID.equals(type)) {
			commentProcessor = new IteratorCommentProcessor(comment);
		} else {
			throw new XLSReportCfgException("type[" + type + 
					"]is not included in [S, I] which are supported currently");
		}
		commentProcessor.init();
		return commentProcessor;
	}
	
	/**
	 * convert the comment content to Map by json-lib
	 * @param comment
	 * @return
	 * @throws XLSReportCfgException
	 * 	wrapped the JSONException thrown by json-lib in converting
	 */
	@SuppressWarnings("unchecked")
	private static Map<String, Object> analyzeComment(Comment comment) {
		try {
			return (Map<String, Object>) JSONObject.toBean(
					JSONObject.fromObject(comment.getString().toString()),
					Map.class);
		} catch (JSONException e) {
			throw new XLSReportCfgException("the comment configuration at [" + 
					comment.getRow() + "," + comment.getColumn() + "] " + comment.getString().toString() + 
					" must be type of JSON", e);
		}
	}
	
	
	
}
