package org.moon.mapper;

import java.util.List;

import org.moon.domain.Criteria;
import org.moon.domain.FileBoardVO;

public interface FileBoardMapper {
	
	public List<FileBoardVO> fileBoardList(Criteria cri);
	
	public void fileBoardRegister(FileBoardVO vo);
	
	public int totalCount(Criteria cri);
	
	public FileBoardVO fileBoardRead(Long bno);
	
	public int fileBoardModify(FileBoardVO vo);
	
	public int fileBoardRemove(FileBoardVO vo);
	
}
