package org.moon.mapper;

import org.apache.ibatis.annotations.Select;

public interface TestMapper {
	
	@Select("select sysdate from dual")
	public String getTime();
	
	public String getTime2();
}
