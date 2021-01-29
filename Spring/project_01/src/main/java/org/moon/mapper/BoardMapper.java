package org.moon.mapper;

import java.util.List;

import org.moon.domain.BoardVO;
import org.moon.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> boardList(Criteria cri);
	
	public void boardInsert(BoardVO vo);
	
	public int totalCount();
}
