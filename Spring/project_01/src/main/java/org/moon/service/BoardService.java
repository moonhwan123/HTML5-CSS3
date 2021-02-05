package org.moon.service;

import java.util.List;

import org.moon.domain.BoardVO;
import org.moon.domain.Criteria;

public interface BoardService {
	
	public List<BoardVO> boardList(Criteria cri);
	
	public void boardRegister(BoardVO vo);
	
	public int totalCount(Criteria cri);
	
	public BoardVO boardRead(Long bno);
	
	public boolean boardModify(BoardVO vo);
	
	public boolean boardRemove(BoardVO vo);
	
}
