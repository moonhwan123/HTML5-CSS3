package org.moon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.moon.domain.BoardVO;
import org.moon.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> boardList(Criteria cri);
	
	public void boardRegister(BoardVO vo);
	
	public int totalCount(Criteria cri);
	
	public BoardVO boardRead(Long bno);
	
	public int boardModify(BoardVO vo);
	
	public int boardRemove(BoardVO vo);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
