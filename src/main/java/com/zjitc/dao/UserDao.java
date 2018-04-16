package com.zjitc.dao;

import com.zjitc.pojo.User;

/**
 * Create by IntelliJ IDEA
 *
 * @author: Admin
 * @create-Time: 2018/4/3
 * @description: ${DESCRIPTION}
 */
public interface UserDao {

    User findByUsername(String username);

    boolean add(User user);


}
