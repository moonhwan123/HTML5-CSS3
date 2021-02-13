package org.moon.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.moon.domain.BoardVO;
import org.moon.domain.FileBoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class FileBoardMapperTests {
	
	
	@Setter(onMethod_ = @Autowired)
	private FileBoardMapper mapper;
	
	@Test
	public void insetTests() {
		FileBoardVO vo = new FileBoardVO();
		
		
		for(int x=0; x <= 100; x++) {
			vo.setTitle("test"+x);
			vo.setWriter("test"+x);
			vo.setContent("test"+x);
			
			mapper.fileBoardRegister(vo);
		}
	}

}
