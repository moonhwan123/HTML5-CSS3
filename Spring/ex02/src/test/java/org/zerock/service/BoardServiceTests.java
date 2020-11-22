package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//Java Config
//@ContextConfiguration(classes = {org.zerock.config.RootConfig.class})
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		
		board.setTitle("New Title!!");
		board.setContent("New Contents!!");
		board.setWriter("newbie");
		
		service.register(board);
		
		log.info("생성된 게시물의 번호 : " + board.getBno());
	}
	
	
	@Test
	public void testGetList() {
		List<BoardVO> list = new ArrayList<BoardVO>();
		
		list = service.getList();
		
		for(int a = 0; a < list.size(); a++) {
			log.info(list.get(a));
		}
	}
	
	@Test
	public void testRead() {
		log.info(service.get(1L));
	}
	
	@Test
	public void testDelete() {
		log.info("REMOVE RESULT : " + service.remove(2L));
	}
	@Test
	public void testUpdate() {
		BoardVO board = service.get(1L);
		
		if(board == null) {
			return;
		}
		
		board.setTitle("수정된 제목");
		
		log.info("MODIFY RESULT : " + service.modify(board));
	}
}
