package org.moon.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class FileBoardVO {
	
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	  
	  
	private List<BoardAttachVO> attachList;
}
