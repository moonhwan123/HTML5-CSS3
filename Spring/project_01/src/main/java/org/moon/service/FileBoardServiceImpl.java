package org.moon.service;

import java.util.List;

import org.moon.domain.Criteria;
import org.moon.domain.FileBoardVO;
import org.moon.mapper.BoardMapper;
import org.moon.mapper.FileBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@AllArgsConstructor //모든 파라미터를 이용하는 생성자
@Log4j
@Service
public class FileBoardServiceImpl implements FileBoardService {
	
	@Setter(onMethod_ = @Autowired)
	private FileBoardMapper mapper;
	
	
	@Override
	public List<FileBoardVO> fileBoardList(Criteria cri) {
		return mapper.fileBoardList(cri);
	}

	@Override
	public void fileBoardRegister(FileBoardVO vo) {
		mapper.fileBoardRegister(vo);
	}

	@Override
	public int totalCount(Criteria cri) {
		return mapper.totalCount(cri);
	}

	@Override
	public FileBoardVO fileBoardRead(Long bno) {
		
		return mapper.fileBoardRead(bno);
	}

	@Override
	public boolean fileBoardModify(FileBoardVO vo) {
		boolean modifyResult = mapper.fileBoardModify(vo) == 1;
		
		return modifyResult;
	}

	@Override
	public boolean fileBoardRemove(FileBoardVO vo) {
		boolean removeResult = mapper.fileBoardRemove(vo) == 1;
		
		return removeResult;
	}

}
