package com.thinkgem.jeesite.common.report.xls.template.fill;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Comment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

/**
 * Implementation of XLSReportFiller,
 * it will scan the XLS template, a corresponding {@link CommentProcessor}
 * will be used while coming across a comment.
 * In other word, XLS template is configured by comment.
 * @author ex_zhusiyuan
 *
 */
public class XLSReportCommentFiller implements XLSReportFiller {
	
	private static final Log logger = LogFactory.getLog(XLSReportCommentFiller.class);
	
	@SuppressWarnings("rawtypes")
	@Override
	public void fill(Workbook template, Map dataSource) {
		int sheetCount = template.getNumberOfSheets();
		for (int i = 0; i < sheetCount; i++) {
			logger.debug("scan the sheet at index[" + i + "]");
			fillSheet(template.getSheetAt(i), dataSource);
		}
	}
	
	/**
	 * fill the XLS sheet by data
	 * @param template
	 * @param dataSource
	 */
	@SuppressWarnings("rawtypes")
	private void fillSheet(Sheet sheet, Map dataSource) {
		int rowCount = sheet.getLastRowNum();
		for (int i = 0; i <= rowCount; i++) {
			Row row = sheet.getRow(i);
			if (row != null) {
				int cellCount = row.getLastCellNum();
				for (int j = 0; j <= cellCount; j++) {
					Cell cell = row.getCell(j);
					if (cell != null ) {
						Comment comment = cell.getCellComment();
						if (comment != null) {
							logger.debug("comment is found at [" + i + ", " + j + "]");
							CommentProcessor processor = CommentProcessorFactory.getCommentProcessor(comment);
							processor.process(sheet, dataSource);
							//refresh rowCount
							rowCount = sheet.getLastRowNum();
						}
					}
				}
			}
		}
	}
	
}
