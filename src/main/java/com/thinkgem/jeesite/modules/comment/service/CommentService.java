package com.thinkgem.jeesite.modules.comment.service;

import java.util.Date;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.comment.entity.Affix;
import com.thinkgem.jeesite.modules.comment.entity.Comment;
import com.thinkgem.jeesite.modules.comment.dao.AffixDao;
import com.thinkgem.jeesite.modules.comment.dao.CommentDao;
import com.thinkgem.jeesite.modules.process.dao.DynamicMessageDao;
import com.thinkgem.jeesite.modules.process.dao.ProcessDao;
import com.thinkgem.jeesite.modules.process.entity.DynamicMessage;
import com.thinkgem.jeesite.modules.process.entity.Process;

/**
 * 评论Service
 * @author 俞超
 * @version 2015-02-05
 */
@Service
@Transactional(readOnly=true)
public class CommentService extends BaseService {

	@Autowired
	private CommentDao commentDao;
	
	@Autowired
	private AffixDao aiAffixDao;
	
	@Autowired
	private DynamicMessageDao dynamicMessageDao;
	
	@Autowired
	private ProcessDao processDao;
	
	public Comment get(String id) {
		return commentDao.get(id);
	}
	
	public Page<Comment> find(Page<Comment> page, Comment comment) {
		DetachedCriteria dc = commentDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return commentDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(Comment comment) {
		commentDao.save(comment);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		commentDao.deleteById(id);
	}
	
	/**
	 * 获取某个流程下的评论
	 * @param processId
	 * @return
	 */
	public List<Comment> getCommentsByProcessId(String processId){
		DetachedCriteria dc = commentDao.createDetachedCriteria();
		dc.createAlias("process", "process");
		dc.add(Restrictions.eq("process.id", processId));
		dc.addOrder(Order.asc("generateTime"));
		return commentDao.find(dc);
	}
	
	/**
	 * 发表评论
	 * @param comment
	 */
	@Transactional(readOnly=false)
	public void saveComments(Comment comment){
		commentDao.save(comment);
		for(Affix affix:comment.getAffixList()){
			affix.setComment(comment);
			aiAffixDao.save(affix);
		}
		
		//生成动态消息
		Process process = processDao.get(comment.getProcess().getId());
		DynamicMessage dynamicMessage = new DynamicMessage();
		dynamicMessage.setFromUser(comment.getGenerateUser());
		if(comment.getGenerateUser().getId().equals(process.getStartUser().getId())){
			dynamicMessage.setToUser(process.getEndUser());
		}else{
			dynamicMessage.setToUser(process.getStartUser());
		}
		dynamicMessage.setBussinessId(comment.getId());
		dynamicMessage.setType(DynamicMessage.COMMENT_MESSAGE);
		dynamicMessage.setMessageContent(comment.getGenerateUser().getName()+"发表评论");
		dynamicMessage.setGenerateTime(new Date());
		dynamicMessageDao.save(dynamicMessage);
	}
	
	
}
