package com.hobby.security;
/**
 * 작성자: 김지영
 */
import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomNoOpPasswordEncoder implements PasswordEncoder {

	public String encode(CharSequence rawPassword) {

		log.warn("before encode :" + rawPassword);

		return rawPassword.toString();
	}

	public boolean matches(CharSequence rawPassword, String encodedPassword) {

		log.warn("matches: " + rawPassword + ":" + encodedPassword);

		return rawPassword.toString().equals(encodedPassword);
	}

}
