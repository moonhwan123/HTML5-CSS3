package org.moon.service;

import java.util.List;

import org.moon.domain.BoardAttachVO;
import org.moon.domain.Criteria;
import org.moon.domain.FileBoardVO;

public interface FileBoardService {
	
	public List<FileBoardVO> fileBoardList(Criteria cri);
	
	public void fileBoardRegister(FileBoardVO vo);
	
	public int totalCount(Criteria cri);
	
	public FileBoardVO fileBoardRead(Long bno);
	
	public boolean fileBoardModify(FileBoardVO vo);
	
	public boolean fileBoardRemove(FileBoardVO vo);
	
	public List<BoardAttachVO> getAttachList(Long bno);
	
}
