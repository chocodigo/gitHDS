package com.smtown.smhds.account;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class AccountService implements UserDetailsService{

    @Autowired AccountMapper accountMapper;

    @Override
    public UserDetails loadUserByUsername(String user_name) throws UsernameNotFoundException {
        try {
            Account account = accountMapper.accountName(user_name);
            account.setAuthorities(getAuthorities(user_name));
            System.out.println("user_name : " + user_name);
            return account;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public Collection<GrantedAuthority> getAuthorities(String user_name) throws Exception{
        List<String> str_authorities = accountMapper.accountAuthority(user_name);
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        for (String authority : str_authorities) {
            authorities.add(new SimpleGrantedAuthority(authority));
        }
        System.out.println("authority : "+authorities);
        return authorities;
    }

}
