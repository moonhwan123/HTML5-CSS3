package org.moon.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.moon.domain.BoardAttachVO;
import org.moon.domain.Criteria;
import org.moon.domain.FileBoardVO;
import org.moon.domain.PageDTO;
import org.moon.service.FileBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/fileBoard/*")
@AllArgsConstructor
public class FileBoardController {
	
	@Setter(onMethod_ = @Autowired)
	private FileBoardService fileBoardService;
	
	
	@GetMapping("/fileBoardList")
	public void fileBoardListGet(Criteria cri,Model model) {
		
		log.info("At fileBoardController ...... fileBoardListGet()......");
		log.info("Board pageNum : " + cri.getPageNum() + " // Board Amount : " + cri.getAmount());
		log.info("Board type : " + cri.getType() + " // Board keyword : " + cri.getKeyword());
		
		int total = fileBoardService.totalCount(cri);
		
		log.info("Total count : " + total);
		
		List<FileBoardVO> fileBoardList = fileBoardService.fileBoardList(cri);
		
		model.addAttribute("boardList",fileBoardList);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	@GetMapping("/fileBoardRegister")
	public void fileBoardRegisterGet() {
		log.info("At fileBoardController ...... fileBoardRegisterGet()......");
	}
	
	@PostMapping("/fileBoardRegister")
	public String fileBoardRegisterPost(FileBoardVO vo,RedirectAttributes rttr) {
		log.info("At fileBoardController ...... fileBoardRegisterPost()......");
		
		log.info(vo.getBno());
		
		log.info("넘어온 FileBoardVO 정보 - " + vo);
		
		if(vo.getAttachList() != null) {
			vo.getAttachList().forEach(attach -> {
				log.info(attach);
				log.info("uploadPath : "+attach.getUploadPath());
			});
		}
		
		log.info("");
		
		
		fileBoardService.fileBoardRegister(vo);
		
		rttr.addFlashAttribute("result",vo.getBno());
		
		return "redirect:/fileBoard/fileBoardList";
	}
	
	@GetMapping({"/fileBoardRead","/fileBoardModify"})
	public void fileBoardReadGet(@RequestParam("bno") Long bno,@ModelAttribute("cri") Criteria cri,Model model) {
		log.info("At FileBoardController ...... fileBoardReadGet()......or fileBoardModify");
		log.info("Read Bno : " + bno);
		log.info("이전 페이지에서 넘어온 cri 정보 : " + cri);
		
		model.addAttribute("board",fileBoardService.fileBoardRead(bno));
		
	}
	
	@PostMapping("/fileBoardModify")
	public String fileBoardModifyPost(FileBoardVO vo, @ModelAttribute("cri")Criteria cri,RedirectAttributes rttr) {
		log.info("At fileBoardController ......  fileBoardModifyPost()");
		log.info("수정 할려는 게시물 번호 : " + vo.getBno());
		log.info("이전 페이지에서 넘어온 cri 정보 : " + cri);
		
		if(fileBoardService.fileBoardModify(vo)) {
			rttr.addFlashAttribute("result","success modify");
		}
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/fileBoard/fileBoardList";
	}
	
	@PostMapping("/fileBoardRemove")
	public String fileBoardRemovePost(FileBoardVO vo,@ModelAttribute("cri")Criteria cri,RedirectAttributes rttr) {
		log.info("===========================At fileBoardController ......  fileBoardRemovePost()=========================");
		log.info("삭제 하는 게시물 번호 : " + vo.getBno());
		log.info("이전 페이지에서 넘어온 cri 정보 : " + cri);
		
		List<BoardAttachVO> list = fileBoardService.getAttachList(vo.getBno());
		
		if(fileBoardService.fileBoardRemove(vo)) {
			rttr.addFlashAttribute("result","success remove");
			
			//실제 폴더에 업로드 된 첨부파일 같이 삭제
			deleteFiles(list);
		}
		
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/fileBoard/fileBoardList";
		//return "redirect:/fileBoard/fileBoardList" + cri.getListLink();
	}
	
	@GetMapping(value = "/getAttachList" , produces =MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("==================getAttachList()=====================");
		
		return new ResponseEntity<>(fileBoardService.getAttachList(bno),HttpStatus.OK);
	}
	
	//실제 파일 삭제
	private void deleteFiles(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("============================deleteFiles()================================");
		log.info("넘어온 파일 리스트 : " + attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_"
						+ attach.getFileName());
				log.info("삭제할 파일....." + file);
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					
					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_"
						+ attach.getFileName());
					log.info("섬네일 삭제......" + thumbNail);
					Files.delete(thumbNail);
					
				}//end if
				
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}//end try/catch
			
		});//end forEach
		
	}
	
}
