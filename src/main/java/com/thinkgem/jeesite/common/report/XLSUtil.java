package com.thinkgem.jeesite.common.report;

import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Comment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;

/**
 * a utility class of XLS operators
 * @author 俞超
 *
 */
public class XLSUtil {
	
	private static Log logger = LogFactory.getLog(XLSUtil.class);
	
	/**
	 * clone the height, cells and cellRangeAddress to destRow from srcRow
	 * @param sheet
	 * @param srcRow
	 * @param destRow
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static void cloneRow(Sheet sheet, Row srcRow, Row destRow) {
		if (sheet == null || srcRow == null || destRow == null)
			return;
		Set mergedRegions = new HashSet();
		destRow.setHeight(srcRow.getHeight());
		if (srcRow.getFirstCellNum() >= 0 && srcRow.getLastCellNum() >= 0) {
            for (int i = srcRow.getFirstCellNum(), j = srcRow.getLastCellNum(); i <= j; i++) {
				Cell srcCell = srcRow.getCell(i);
				Cell destCell = destRow.getCell(i);
                if (srcCell != null) {
                	logger.debug("cell is found at col[" + i + 
                			"], will be cloned to the destRow");
                    if (destCell == null) {
                        destCell = destRow.createCell(i);
                    }
                    cloneCell(srcCell, destCell);
                    CellRangeAddress mergedRegion = getMergedRegion(sheet, srcRow.getRowNum(), 
                    		srcCell.getColumnIndex());
                    if (mergedRegion != null) {
                    	CellRangeAddress newMergedRegion = new CellRangeAddress(
                    			destRow.getRowNum(), 
                    			destRow.getRowNum() + mergedRegion.getLastRow() - mergedRegion.getFirstRow(), 
                    			mergedRegion.getFirstColumn(), 
                    			mergedRegion.getLastColumn());
                        if (isNewMergedRegion(newMergedRegion, mergedRegions)) {
                        	logger.debug("CellRangeAddress is found at col[" + i + 
                        			"], will be cloned to the destRow");
                            mergedRegions.add(newMergedRegion);
                            sheet.addMergedRegion(newMergedRegion);
                        }
                    }
                }
            }
		}
	}
	
	/**
	 * get the CellRangeAddress of sheet at [rowNum, colNum] if exists
	 * @param sheet
	 * @param rowNum
	 * @param colNum
	 * @return null if not exists
	 */
	public static CellRangeAddress getMergedRegion(Sheet sheet, int rowNum, int colNum) {
        for (int i = 0, c = sheet.getNumMergedRegions(); i < c; i++) {
            CellRangeAddress merged = sheet.getMergedRegion(i);
            if (isRangeContainsCell(merged, rowNum, colNum)) {
                return merged;
            }
        }
        return null;
    }
	
	/**
	 * to judge whether the CellRangeAddress includes the cell at [row, col]
	 * @param range
	 * @param row
	 * @param col
	 * @return 
	 * 	true if the CellRangeAddress includes the cell at [row, col]
	 */
    public static boolean isRangeContainsCell(CellRangeAddress range, int row, int col) {
        if ((range.getFirstRow() <= row) && (range.getLastRow() >= row)
                && (range.getFirstColumn() <= col)
                && (range.getLastColumn() >= col)) {
            return true;
        }
        return false;
    }
    
    /**
     * to judge if the CellRangeAddress is not included in mergedRegions,
     * using {@link #areRegionsEqual(CellRangeAddress, CellRangeAddress)} to compare
     * @param region
     * @param mergedRegions
     * @return 
     * 	true if the CellRangeAddress is not included in mergedRegions
     */
    @SuppressWarnings("rawtypes")
	private static boolean isNewMergedRegion(CellRangeAddress region,
            Collection mergedRegions) {
        for (Iterator iterator = mergedRegions.iterator(); iterator.hasNext();) {
            CellRangeAddress cellRangeAddress = (CellRangeAddress) iterator.next();
            if (areRegionsEqual(cellRangeAddress, region)) {
                return false;
            }
        }
        return true;
    }
    
    /**
     * compares region1 with region2
     * @param region1
     * @param region2
     * @return 
     * 	true if both of them are null or 
     * 	their firstColumn, lastColumn, firstRow and lastRow are all the same
     */
    public static boolean areRegionsEqual(CellRangeAddress region1,
            CellRangeAddress region2) {
        if ((region1 == null && region2 != null)
                || (region1 != null && region2 == null)) {
            return false;
        }
        if (region1 == null) {
            return true;
        }
        return (region1.getFirstColumn() == region2.getFirstColumn()
                && region1.getLastColumn() == region2.getLastColumn()
                && region1.getFirstRow() == region2.getFirstRow() 
                && region2.getLastRow() == region2.getLastRow());
    }
    
    /**
     * clone the style and value to destCell from srcCell
     * @param srcCell
     * @param destCell
     */
    public static void cloneCell(Cell srcCell, Cell destCell) {
		if (srcCell == null || destCell == null)
			return;
		destCell.setCellStyle(srcCell.getCellStyle());
		switch (srcCell.getCellType()) {
			case Cell.CELL_TYPE_NUMERIC :
				destCell.setCellValue(srcCell.getNumericCellValue());
				break;
			case Cell.CELL_TYPE_STRING :
				destCell.setCellValue(srcCell.getRichStringCellValue());
				break;
			case Cell.CELL_TYPE_FORMULA :
				destCell.setCellFormula(srcCell.getCellFormula());
				break;
			case Cell.CELL_TYPE_ERROR :
				destCell.setCellErrorValue(srcCell.getErrorCellValue());
				break;
			case Cell.CELL_TYPE_BOOLEAN :
				destCell.setCellValue(srcCell.getBooleanCellValue());
				break;
			default :
				destCell.setCellType(Cell.CELL_TYPE_BLANK);
				break;
		}
	}
    
    /**
     * Set a value for the cell.
     * Value whose type is {@link Calendar}, {@link Date}, {@link Number}, {@link String}
     * is supported directly, otherwise will be processed as string.
     * @param cell
     * @param value
     */
    public static void setCellValue(Cell cell, Object value) {
    	if (cell == null)
    		return;
    	if (value == null) {
    		cell.setCellType(Cell.CELL_TYPE_BLANK);
    	} else if (value instanceof Calendar) {
    		cell.setCellValue((Calendar) value);
		} else if (value instanceof Date) {
			cell.setCellValue((Date) value);
		} else if (value instanceof Number) {
			setCellValue(cell, (Number) value);
		} else if (value instanceof String) {
			cell.setCellValue((String) value);
		} else {
			logger.warn("value type [" + value.getClass().getName() + 
					"] is not directly supported, will be processed as String");
			cell.setCellValue((String) value.toString());
		}
    }
	
    /**
     * set a number value for the cell
     * @param cell
     * @param value
     * @throws XLSReportException
     * 	if the Number can not be unwrapped
     */
	private static void setCellValue(Cell cell, Number value) {
		double doubleContent = 0.0;
		if (value instanceof Byte) {
			doubleContent = (Byte) value;
		} else if (value instanceof Double) {
			doubleContent = (Double) value;
		} else if (value instanceof Float) {
			doubleContent = (Float) value;
		} else if (value instanceof Integer) {
			float tmp = (Integer) value;
			doubleContent = tmp;
		} else if (value instanceof Long) {
			float tmp = (Long) value;
			doubleContent = tmp;
		} else if (value instanceof Short) {
			short tmp = (Short) value;
			doubleContent = tmp;
		} else {
			throw new XLSReportException("value type [" + value.getClass().getName() + 
					"] can not be processed as double");
		}
		cell.setCellValue(doubleContent);
	}
	
	/**
	 * get the string value of a cell
	 * @param cell
	 * @return "" if type of the cell is not in 
	 * 	{CELL_TYPE_NUMERIC, CELL_TYPE_STRING and CELL_TYPE_BOOLEAN}
	 * @see Cell#CELL_TYPE_BLANK
     * @see Cell#CELL_TYPE_NUMERIC
     * @see Cell#CELL_TYPE_STRING
     * @see Cell#CELL_TYPE_FORMULA
     * @see Cell#CELL_TYPE_BOOLEAN
     * @see Cell#CELL_TYPE_ERROR
	 */
	public static String getCellStringValue(Cell cell) {
		String cellStringValue = null;
		switch (cell.getCellType()) {
			case Cell.CELL_TYPE_NUMERIC :
				cellStringValue = cell.getNumericCellValue() + "";
				break;
			case Cell.CELL_TYPE_STRING :
				cellStringValue = cell.getStringCellValue();
				break;
			case Cell.CELL_TYPE_BOOLEAN :
				cellStringValue = cell.getBooleanCellValue() + "";
				break;
			default :
				logger.warn("can not get the string value of a cell whose type is " + cell.getCellType());
				cellStringValue = "";
				break;
		}
		return cellStringValue;
	}
	
	/**
	 * remove a comment from sheet
	 * @param sheet
	 * @param comment
	 */
	public static void removeComment(Sheet sheet, Comment comment) {
		if (sheet != null && comment != null) {
			sheet.getRow(comment.getRow())
				.getCell(comment.getColumn())
				.removeCellComment();
		}
	}
	
}
