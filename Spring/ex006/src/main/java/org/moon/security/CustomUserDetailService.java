package org.moon.security;

import org.moon.domain.CustomUser;
import org.moon.domain.MemberVO;
import org.moon.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailService implements UserDetailsService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {

		log.warn("Load User By UserName : " + userName);
		
		MemberVO vo = mapper.read(userName);
		
		log.warn("querid by member mapper : " + vo);
		
		return vo == null ? null : new CustomUser(vo);
	}
	
}
