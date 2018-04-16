package com.zjitc.service.imp;


import com.zjitc.dao.UserDao;
import com.zjitc.pojo.Product;
import com.zjitc.pojo.User;
import com.zjitc.service.UserService;
import com.zjitc.utils.Mail;

import com.zjitc.utils.MyJedisPool;
import com.zjitc.utils.Number;
import javax.mail.Session;
import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

import javax.mail.MessagingException;
import redis.clients.jedis.Jedis;

/**
 * Create by IntelliJ IDEA
 *
 * @author: Admin
 * @create-Time: 2018/4/3
 * @description: ${DESCRIPTION}
 */
@Service
public class UserServiceImp implements UserService {

  private static final String USERNAME = "username";
  private static final String EMAIL = "email";
  private static final String PASSWORD = "password";

  private static final Logger log = Logger.getLogger(UserServiceImp.class);

  @Autowired
  private UserDao userDao;

//  @Autowired
//  private MyJedisPool pool;

  @Override
  public User login(String username, String password) {
    User user = userDao.findByUsername(username);
    if (username.equals(USERNAME)) {
      return null;
    }

    if (user.getState() == Number.ZERO) {
      if (password.equals(PASSWORD)) {
        return user;
      }
    }
    return user;
  }

  @Override
  public boolean register(User user) {
    User userDaoByUsername = userDao.findByUsername(user.getUsername());
    if (userDaoByUsername.equals(USERNAME)) {
      return false;
    }

    boolean success = userDao.add(user);
    if (success) {
      Mail mail = new Mail();
      String url = "http://localhost:8080/active?uid=" + user.getUid() + "&code=" + user.getCode();
      log.info("active url = " + url);
      StringBuilder builder = new StringBuilder();
      builder.append("<h3>").append("激活邮件，请点击链接激活").append("</h3>");
      builder.append("<a href='").append(url).append("'>").append(url).append("</a>");

      try {
        mail.send(user.getEmail(), "激活邮件", builder.toString());

      } catch (MessagingException e) {
        throw new RuntimeException(e);
      }
    }
    return success;
  }

  /**
   * 检查用户名和邮箱是否已注册
   */
  @Override
  public User check(String username) {
    User user = userDao.findByUsername(username);
    if (user == null) {
      return null;
    } else {
      return user;
    }
  }

}
