package com.zjitc.service;

import com.zjitc.pojo.User;

/**
 * Create by IntelliJ IDEA
 *
 * @author: Admin
 * @create-Time: 2018/4/3
 * @description: ${DESCRIPTION}
 */
public interface UserService {

  /**
   * 登陆
   * @param username
   * @param password
   * @return
   */
  User login(String username, String password);

  /**
   * 注册
   * @param user
   * @return
   */
  boolean register(User user);


  /**
   * 检查用户名和邮箱是否已注册
   * @param username
   * @return
   */
  User check(String username);
}
