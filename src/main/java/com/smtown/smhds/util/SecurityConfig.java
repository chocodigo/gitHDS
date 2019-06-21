package com.smtown.smhds.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import com.smtown.smhds.account.AccountService;


//@EnableWebSecurity : springSecurityFilterChain 자동 포함
@EnableWebSecurity
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter{

    @Autowired AccountService accountService;

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception{
        auth.userDetailsService(accountService);
    }



    //http 설정
    //001 admin
    //002 user
    protected void configure(HttpSecurity http) throws Exception{
        http.headers().contentTypeOptions();
        http.headers().httpStrictTransportSecurity().disable();
        http.csrf().ignoringAntMatchers("/forgotProc");
        http.csrf().ignoringAntMatchers("/resetPWProc");

        http.authorizeRequests().antMatchers("/admin/**").hasAuthority("001")
                .antMatchers("/forgot").permitAll()
                .antMatchers("/forgotProc").permitAll()
                .antMatchers("/resetPWProc").permitAll()
                .antMatchers("/notice_insert/**").hasAuthority("001")
                .antMatchers("/noticeInsertProc").hasAuthority("001")
                .antMatchers("/notice_update/**").hasAuthority("001")
                .antMatchers("/notice_updateProc").hasAuthority("001")
                .antMatchers("/notice_delete/**").hasAuthority("001")
                .antMatchers("/updateStatProc").hasAuthority("001")
                .antMatchers("/faq_insert").hasAuthority("001")
                .antMatchers("/faqInsertProc").hasAuthority("001")
                .antMatchers("/faq_delete/**").hasAuthority("001")
                .antMatchers("/faq_update/**").hasAuthority("001")
                .antMatchers("/faq_updateProc").hasAuthority("001")
                .antMatchers("/comment/**").hasAuthority("001");

        http.authorizeRequests().antMatchers("/resources/**").permitAll()
                .antMatchers("/**").hasAnyAuthority("001","002");



        http.formLogin()
                .loginPage("/login")
                .failureUrl("/login?error")
                .defaultSuccessUrl("/main")
                .usernameParameter("USER_NAME")
                .passwordParameter("PASS_WORD")
                .permitAll();

        http.logout()
                .logoutSuccessUrl("/login")
                .permitAll();

        //rememberMe() : return RememberMeConfigurer
        //key(String key) :
        //rememberMeCookieName(String rememberMeCookieName) : 이름
        //tokenValiditySeconds(int tokenValiditySeconds) : 유효기간
        http.rememberMe().key("remember_key")
                .rememberMeParameter("remember-me")
                .rememberMeCookieName("HDS-login-rememberMe")
                //60 * 60 * 24 * 14 (2주일)
                .tokenValiditySeconds(60*60*24*14);
    }
}
