package com.ssafy.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.model.dto.FAQ;
import com.ssafy.model.dto.Food;
import com.ssafy.model.dto.FoodPageBean;
import com.ssafy.model.dto.Notice;
import com.ssafy.model.dto.Reply;
import com.ssafy.model.service.EatInfoService;
import com.ssafy.model.service.FAQService;
import com.ssafy.model.service.FoodService;
import com.ssafy.model.service.MemberService;
import com.ssafy.model.service.NoticeService;
import com.ssafy.model.service.ReplyService;

import io.swagger.annotations.ApiOperation;

@CrossOrigin(origins = {"*"}, maxAge = 6000)
@RestController
public class MainRestController {
	@Autowired
	private FAQService faqService;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private NoticeService noticeService;
	
	@ExceptionHandler
	public ResponseEntity<Map<String, Object>> handle(Exception e){
		return handleFail(e.getMessage(), HttpStatus.OK);
	}
	
	// FAQ
	@ApiOperation("전체 FAQ 목록을 조회하는 기능")
	@GetMapping("/faq")
	public ResponseEntity<Map<String, Object>> faqs(){
		List<FAQ> list = faqService.searchAll();
		return handleSuccess(list);
	}
	
	@ApiOperation("번호에 해당하는 FAQ를 조회하는 기능")
	@GetMapping("/faq/{no}")
	public ResponseEntity<Map<String, Object>> faq(@PathVariable String no){
		return handleSuccess(faqService.search(no));
	}
	
	@ApiOperation("FAQ 등록")
	@PostMapping("/faqinsert")
	public ResponseEntity<Map<String, Object>> insert(@RequestBody FAQ faq){
		faqService.insert(faq);
		return handleSuccess("등록 완료");
 	}
	
	@ApiOperation("FAQ 삭제")
	@DeleteMapping("/faq/{no}")
	public ResponseEntity<Map<String, Object>> delete(@PathVariable String no){
		faqService.delete(no);
		return handleSuccess("삭제 완료");
 	}
	
	@ApiOperation("FAQ 수정")
	@PutMapping("/faq/{no}")
	public ResponseEntity<Map<String, Object>> update(@RequestBody FAQ faq){
		System.out.println(faq.toString());
		faqService.update(faq);
		return handleSuccess("수정 완료");
 	}
	
	// Reply
	@ApiOperation("REPLY 등록")
	@PostMapping("/replyinsert")
	public ResponseEntity<Map<String, Object>> replyInsert(@RequestBody Reply reply){
		System.out.println(reply.toString());
		replyService.insert(reply);
		return handleSuccess("등록 완료");
 	}
	
	@ApiOperation("REPLY 삭제")
	@DeleteMapping("/reply/{no}")
	public ResponseEntity<Map<String, Object>> replyDelete(@PathVariable String no){
		replyService.delete(no);
		return handleSuccess("삭제 완료");
 	}
	
	@ApiOperation("REPLY 수정")
	@PutMapping("/reply/{no}")
	public ResponseEntity<Map<String, Object>> replyUpdate(@RequestBody Reply reply){
		replyService.update(reply);
		return handleSuccess("수정 완료");
 	}
	
	@ApiOperation("글에 해당하는 REPLY 전체를 조회하는 기능")
	@GetMapping("/reply/{qno}")
	public ResponseEntity<Map<String, Object>> replySearchAll(@PathVariable String qno){
		return handleSuccess(replyService.searchAll(qno));
	}
	
	// Notice
	@ApiOperation("전체 Notice 목록을 조회하는 기능")
	@GetMapping("/notice")
	public ResponseEntity<Map<String, Object>> notices() {
		List<Notice> list = noticeService.searchAll();
		for (Notice notice : list) {
			System.out.println(notice.toString());
		}
		return handleSuccess(list);
	}

	@ApiOperation("번호에 해당하는 notice를 조회하는 기능")
	@GetMapping("/notice/{no}")
	public ResponseEntity<Map<String, Object>> notice(@PathVariable String no) {
		return handleSuccess(noticeService.search(no));
	}

	@ApiOperation("notice 등록")
	@PostMapping("/noticeinsert")
	public ResponseEntity<Map<String, Object>> insert(@RequestBody Notice notice) {
		noticeService.insert(notice);
		return handleSuccess("등록 완료");
	}

	@ApiOperation("notice 삭제")
	@DeleteMapping("/notice/{no}")
	public ResponseEntity<Map<String, Object>> deleteNotice(@PathVariable String no) {
		noticeService.delete(no);
		return handleSuccess("삭제 완료");
	}

	@ApiOperation("notice 수정")
	@PutMapping("/notice/{no}")
	public ResponseEntity<Map<String, Object>> update(@RequestBody Notice notice) {
		System.out.println(notice.toString());
		noticeService.update(notice);
		return handleSuccess("수정 완료");
	}
	
	// Exception Handle
	public ResponseEntity<Map<String, Object>> handleFail(Object data, HttpStatus state){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("state", "fail");
		resultMap.put("data", data);
		return new ResponseEntity<Map<String,Object>>(resultMap, state);
	}
	public ResponseEntity<Map<String, Object>> handleSuccess(Object data){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("state", "ok");
		resultMap.put("data", data);
		return new ResponseEntity<Map<String,Object>>(resultMap, HttpStatus.OK);
	}
	
}
