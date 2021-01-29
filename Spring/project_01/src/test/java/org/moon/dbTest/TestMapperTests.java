package org.moon.dbTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.moon.mapper.TestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
// Java 설정의 경우
// @ContextConfiguration(classes = { org.zerock.config.RootConfig.class })
@Log4j
public class TestMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private TestMapper mapper;
	
	
//	@Test
//	public void testGetTime() {
//		log.info(mapper.getClass().getName());
//		log.info(mapper.getTime());
//	}
	
	@Test
	public void tetGetTime2() {

		log.info("getTime2");
		log.info(mapper.getTime2());

	}
}
