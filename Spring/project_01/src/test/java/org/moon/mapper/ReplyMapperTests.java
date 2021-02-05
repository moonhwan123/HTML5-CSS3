package org.moon.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.moon.domain.Criteria;
import org.moon.domain.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
//	
//	@Test
//	public void mapperTest() {
//		log.info(mapper);
//	}
	
//	@Test
//	public void insertTest() {
//		ReplyVO vo = new ReplyVO();
//		
//		for(int x=0; x<9; x++) {
//		vo.setBno(108L);
//		vo.setReply("test");
//		vo.setReplyer("test");
//		
//		mapper.replyInsert(vo);
//		
//		}
//	}
	
//	@Test
//	public void readTest() {
//		Long rno = 1L;
//		
//		log.info("...................................read : "+mapper.replyRead(rno));
//		
//		
//	}
	
//	@Test
//	public void deleteTest() {
//		int rno = 1;
//		
//		log.info("...................................delete : "+mapper.replyDelete(rno));
//		
//		
//	}
	
//	@Test
//	public void modifyTest() {
//		ReplyVO vo = new ReplyVO();
//		
//		vo.setRno(2L);
//		vo.setReply("testModi");
//		
//		log.info("...................................modify : "+mapper.replyModify(vo));
//	}
	
	@Test
	public void replyListTest() {
		Long bno = 108L;
		Criteria cri = new Criteria(2,10);
		
		List<ReplyVO> list = mapper.getReplyList(cri, bno);

		list.forEach(reply -> log.info(reply));
	}

	

	
}
