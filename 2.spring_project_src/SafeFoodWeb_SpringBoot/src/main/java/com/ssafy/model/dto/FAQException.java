package com.ssafy.model.dto;

public class FAQException extends RuntimeException {

	public FAQException() {
		super("## FAQ Exception 발생 ##");
	}
	public FAQException(String message) {
		super(message);
	}
}
