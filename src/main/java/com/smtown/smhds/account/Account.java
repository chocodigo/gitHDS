package com.smtown.smhds.account;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class Account implements UserDetails{
    private String user_name;
    private String pass_word;
    private boolean enab_ledd;
    private Collection<? extends GrantedAuthority> authorities;
    private String birt_hday;
    private String user_mail;
    private String real_name;
    private String dept_ment;

    public String getBirt_hday() {
        return birt_hday;
    }

    public void setBirt_hday(String birt_hday) {
        this.birt_hday = birt_hday;
    }

    public String getUser_mail() {
        return user_mail;
    }

    public void setUser_mail(String user_mail) {
        this.user_mail = user_mail;
    }

    public String getReal_name() {
        return real_name;
    }

    public void setReal_name(String real_name) {
        this.real_name = real_name;
    }

    public String getDept_ment() {
        return dept_ment;
    }

    public void setDept_ment(String dept_ment) {
        this.dept_ment = dept_ment;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public void setPass_word(String pass_word) {
        this.pass_word = pass_word;
    }

    public void setEnabl_ledd(boolean enab_ledd) {
        this.enab_ledd = enab_ledd;
    }

    public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
        this.authorities = authorities;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // TODO Auto-generated method stub
        return authorities;
    }

    @Override
    public String getPassword() {
        // TODO Auto-generated method stub
        return pass_word;
    }

    @Override
    public String getUsername() {
        // TODO Auto-generated method stub
        return user_name;
    }

    @Override
    public boolean isAccountNonExpired() {
        // TODO Auto-generated method stub
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        // TODO Auto-generated method stub
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        // TODO Auto-generated method stub
        return true;
    }

    @Override
    public boolean isEnabled() {
        // TODO Auto-generated method stub
        return enab_ledd;
    }

}
