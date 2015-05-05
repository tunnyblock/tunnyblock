package com.thinkgem.jeesite.common.report.xls.data;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.thinkgem.jeesite.common.report.XLSReportException;

/**
 * Implementation of XLSReportDataSource, which is constructed by a original bean.
 * The original bean will be processed as following,
 * 1. Collections.emptyMap() if it is null
 * 2. used directly if its type is Map
 * 3. otherwise it will be transformed to Map, {@link #transformPropertiesToMap(Object)}
 * @author 俞超
 */
public class XLSReportBeanDataSource implements XLSReportDataSource {
	
	private static Log logger = LogFactory.getLog(XLSReportBeanDataSource.class);
	
	/**
	 * the original bean 
	 */
	private Object dataSource;
	
	public XLSReportBeanDataSource(Object dataSource) {
		this.dataSource = dataSource;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public Map getData() {
		Map ds = null;
		if (this.dataSource == null) {
			ds = Collections.emptyMap();
		} else if (this.dataSource instanceof Map) {
			ds = (Map) this.dataSource;
		} else {
			logger.debug("the type of dataSource is [" + dataSource.getClass() + 
					"], will be transformed to Map");
			ds = transformPropertiesToMap(this.dataSource);
		}
		return ds;
	}
	
	/**
	 * Used locally to transform a bean to Map.
	 * The property names are transformed to the keys,
	 * theirs values are transformed to the value of the corresponding key.
	 * Besides, the property named 'class' is excluded.
	 * @param bean
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private Map transformPropertiesToMap(Object bean) {
		Map properties = new HashMap();
		BeanInfo beanInfo;
		try {
			beanInfo = Introspector.getBeanInfo(bean.getClass());
			PropertyDescriptor[] pds = beanInfo.getPropertyDescriptors();
			for (PropertyDescriptor pd : pds) {
				if (!"class".equals(pd.getName())) {
					properties.put(pd.getName(), pd.getReadMethod().invoke(bean));
				}
			}
		} catch (Exception e) {
			throw new XLSReportException(e);
		}
		return properties;
	}

}
