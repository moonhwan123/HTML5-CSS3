package org.moon.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.moon.domain.Criteria;
import org.moon.domain.ReplyPageDTO;
import org.moon.domain.ReplyVO;

public interface ReplyService {
	
	public int replyInsert(ReplyVO vo);
	
	public ReplyVO replyRead(Long rno);
	
	public int replyDelete(Long rno);
	
	public int replyModify(ReplyVO vo);
	
	public ReplyPageDTO getReplyList(@Param("cri")Criteria cri , @Param("bno")Long bno);
	
	public int replyCount(Long bno);
	
}
