package org.moon.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.moon.domain.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml"
})
public class MemberMapperTests {
	
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Test
	public void testRead() {
		MemberVO vo = mapper.read("admin9");
		
		log.info(vo);
		
		vo.getAuthList().forEach(auth -> {
			log.info(auth);
		});
	}
	
}
