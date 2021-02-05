package org.moon.service;


import org.moon.domain.Criteria;
import org.moon.domain.ReplyPageDTO;
import org.moon.domain.ReplyVO;
import org.moon.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	
	
	@Override
	public ReplyPageDTO getReplyList(Criteria cri, Long bno) {
		log.info("............At ReplyServieImpl.............");
		log.info("getReplyList................bno : "+bno+".............cri : " + cri);
		return new ReplyPageDTO(mapper.replyCount(bno),mapper.getReplyList(cri, bno));
	}
	@Override
	public int replyDelete(int rno) {
		log.info("............At ReplyServieImpl.............");
		log.info("replyDelete.............rno : " + rno);
		return mapper.replyDelete(rno);
	}
	@Override
	public int replyInsert(ReplyVO vo) {
		log.info("............At ReplyServieImpl.............");
		log.info(".........replyInsert..........vo : " + vo);
		return mapper.replyInsert(vo);
	}
	@Override
	public int replyModify(ReplyVO vo) {
		log.info("............At ReplyServieImpl.............");
		log.info("...........replyModify...........vo : " + vo);
		return mapper.replyModify(vo);
	}
	@Override
	public ReplyVO replyRead(Long rno) {
		log.info("............At ReplyServieImpl.............");
		log.info("...........replyRead...........rno : " + rno);
		return mapper.replyRead(rno);
	}
	@Override
	public int replyCount(Long bno) {
		return mapper.replyCount(bno);
	}

}
