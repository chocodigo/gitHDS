package com.smtown.smhds.account;

import java.util.List;

public interface AccountMapper {
    //user_name 읽어오기
    public Account accountName(String user_name) throws Exception;
    //권한받아오기
    public List<String> accountAuthority(String user_name) throws Exception;
}
