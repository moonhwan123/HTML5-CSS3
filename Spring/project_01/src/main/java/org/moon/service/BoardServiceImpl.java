package org.moon.service;

import java.util.List;

import org.moon.domain.BoardVO;
import org.moon.domain.Criteria;
import org.moon.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor //모든 파라미터를 이용하는 생성자
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_= @Autowired)
	private BoardMapper boardMapper;

	@Override
	public List<BoardVO> boardList(Criteria cri) {
		return boardMapper.boardList(cri);
	}
	
	@Override
	public void boardInsert(BoardVO vo) {
		
		boardMapper.boardInsert(vo);
		
	}
	
	@Override
	public int totalCount() {
		
		return boardMapper.totalCount();
	}

}
