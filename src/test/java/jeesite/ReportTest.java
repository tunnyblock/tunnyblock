package jeesite;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.report.XLSReportCreator;
import com.thinkgem.jeesite.common.report.xls.data.XLSReportBeanDataSource;
import com.thinkgem.jeesite.common.report.xls.template.XLSReportClassPathTemplate;
import com.thinkgem.jeesite.common.report.xls.template.fill.XLSReportCommentFiller;

public class ReportTest {
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static void main(String[] args) throws IOException {
		OutputStream os = new FileOutputStream("C:/autoVerifyLoss.xls");
		Map fillData = new HashMap();
		fillData.put("brandName", "一汽XXX");
		fillData.put("licenseNo", "粤A12345");
		fillData.put("frameNo", "车架号XXXXX");
		fillData.put("engineNo", "型号XXXX");
		List autoLossItemList = new ArrayList();
		Map autoLossItem = new HashMap();
		autoLossItem.put("itemCode", "零件编码0001");
		autoLossItem.put("itemName", "零件名称0001");
		autoLossItem.put("itemSystemReferenceAmt", 1234);
		autoLossItemList.add(autoLossItem);
		Map autoLossItem1 = new HashMap();
		autoLossItem1.put("itemCode", "零件编码0002");
		autoLossItem1.put("itemName", "零件名称0002");
		autoLossItem1.put("itemSystemReferenceAmt", 2345);
		autoLossItemList.add(autoLossItem1);
		Map autoLossItem2 = new HashMap();
		autoLossItem1.put("itemCode", "零件编码0002");
		autoLossItem1.put("itemName", "零件名称0002");
		autoLossItem1.put("itemSystemReferenceAmt", 2345);
		autoLossItemList.add(autoLossItem2);
		Map autoLossItem3 = new HashMap();
		autoLossItem1.put("itemCode", "零件编码0002");
		autoLossItem1.put("itemName", "零件名称0002");
		autoLossItem1.put("itemSystemReferenceAmt", 2345);
		autoLossItemList.add(autoLossItem3);
		fillData.put("autoLossItemList", autoLossItemList);
		XLSReportCreator.createXLS(new XLSReportClassPathTemplate("autoVerifyLoss.xls"), new XLSReportBeanDataSource(fillData),new XLSReportCommentFiller(), os);
		os.close();
	}
}
