package org.moon.service;


import org.moon.domain.BoardVO;
import org.moon.domain.Criteria;
import org.moon.domain.ReplyPageDTO;
import org.moon.domain.ReplyVO;
import org.moon.mapper.BoardMapper;
import org.moon.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardmapper;
	
	@Override
	public ReplyPageDTO getReplyList(Criteria cri, Long bno) {
		log.info("............At ReplyServieImpl.............");
		log.info("getReplyList................bno : "+bno+".............cri : " + cri);
		return new ReplyPageDTO(mapper.replyCount(bno),mapper.getReplyList(cri, bno));
	}
	
	@Transactional
	@Override
	public int replyDelete(Long rno) {
		log.info("............At ReplyServieImpl.............");
		log.info("replyDelete.............rno : " + rno);
		
		ReplyVO vo = mapper.replyRead(rno);
		
		boardmapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.replyDelete(rno);
	}
	
	@Transactional
	@Override
	public int replyInsert(ReplyVO vo) {
		log.info("............At ReplyServieImpl.............");
		log.info(".........replyInsert..........vo : " + vo);
		
		boardmapper.updateReplyCnt(vo.getBno(), 1);
		
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
