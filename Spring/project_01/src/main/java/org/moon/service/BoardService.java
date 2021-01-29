package org.moon.service;

import java.util.List;

import org.moon.domain.BoardVO;
import org.moon.domain.Criteria;

public interface BoardService {
	
	public List<BoardVO> boardList(Criteria cri);
	
	public void boardInsert(BoardVO vo);
	
	public int totalCount();
	
}
