package org.moon.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.moon.domain.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardInsertTest {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
//	@Test
//	public void insertTest() {
//		BoardVO vo = new BoardVO();
//		
//		
//		for(int x=4; x < 100; x++) {
//			vo.setTitle("test"+x);
//			vo.setWriter("test"+x);
//			vo.setContent("test"+x);
//			
//			mapper.boardRegister(vo);
//		}
//	}
	
	@Test
	public void a() {
		int sum = 0;
		
		for(int i = 0 ; i <= 5 ; i ++) {
			sum += i;
			log.info(i);
		}
		
		log.info(sum);
		
	}
	
}
