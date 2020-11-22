package org.zerock.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//Java설정을 이용하는 경우
//@ContextConfiguration(Classes = {RootConfig.class})
@Log4j
public class DataSourceTests {
	
	//HikariCP Test
	@Setter(onMethod_ = {@Autowired})
	private DataSource dataSource;
	
	@Test
	public void testConnection() {
		try {
			
			Connection conn = dataSource.getConnection();
			log.info(conn);
			
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
	
	//Mybatis Test
	@Setter(onMethod_ = {@Autowired})
	private SqlSessionFactory sqlSessionFactory;
	
	@Test
	public void testMybatis() {
		try {
			SqlSession session = sqlSessionFactory.openSession();
			Connection con = session.getConnection();
			
			log.info("*** SqlSessioin Test ***");
			log.info(session);
			log.info(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
}
