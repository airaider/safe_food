package com.ssafy.model.dto;

public class NoticeException extends RuntimeException {

	public NoticeException() {
		super("## Notice Exception 발생 ##");
	}
	public NoticeException(String message) {
		super(message);
	}
}
