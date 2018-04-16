package com.zjitc.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import com.zjitc.pojo.Msg;
import com.zjitc.pojo.User;
import com.zjitc.service.UserService;

import com.zjitc.utils.Utils;
import javax.mail.Session;
import javax.servlet.ServletException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.InternalResourceView;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Create by IntelliJ IDEA
 *
 * @author: Admin
 * @create-Time: 2018/3/19
 * @description: ${DESCRIPTION}
 */
@Controller
@RequestMapping("/user")
public class  UserController {

  @Autowired
  private UserService userService;

  @RequestMapping("/login")
  public void login(
      @RequestParam(name = "username") String username,
      @RequestParam(name = "password") String password,
      @RequestParam(name = "inputCode") String inputCode,
      HttpServletRequest request,
      HttpServletResponse response
      ) throws IOException {
    String msgCode = String.valueOf(request.getSession().getAttribute("msgCode"));
    password = Utils.md5Password(password);
    if (inputCode.equalsIgnoreCase(msgCode)) {
      User user = userService.login(username, password);

      if (user != null) {
        request.getSession().setAttribute("user", user);
        response.getWriter().println(1);
      } else {
        response.getWriter().println(0);
      }
    } else {
      response.getWriter().println(0);
    }
  }

  @RequestMapping("/register")
  public ModelAndView register(User user) {
    String msg, address;
    ModelAndView mv = new ModelAndView();
    boolean success = userService.register(user);
    if (success) {
      msg = "注册成功，请去邮箱激活";
      mv.setView(new InternalResourceView("/login.do"));
      address = mv.getViewName();
      Msg m = new Msg(msg, address);
      Gson gson = new GsonBuilder().create();
      String toJson = gson.toJson(m);
      mv.addObject("json", toJson);
    }
    mv.setViewName("/jsp/register.jsp");
    return mv;
  }

  @RequestMapping("/verification")
  @ResponseBody
  public void verification(HttpServletRequest request,
      HttpServletResponse response)
      throws IOException {

    int charNum = 4;
    int width = 30 * 4;
    int height = 30;

    // 1. 创建一张内存图片
    BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

    // 2.获得绘图对象
    Graphics graphics = bufferedImage.getGraphics();

    // 3、绘制背景颜色
    graphics.setColor(Color.CYAN);
    graphics.fillRect(0, 0, width, height);

    // 4、绘制图片边框
    graphics.setColor(Color.BLUE);
    graphics.drawRect(0, 0, width - 1, height - 1);

    // 5、输出验证码内容
    graphics.setColor(Color.RED);
    graphics.setFont(new Font("宋体", Font.BOLD, 20));

    // 随机输出4个字符
    Graphics2D graphics2d = (Graphics2D) graphics;
    String s = "ABCDEFGHGKLMNPQRSTUVWXYZ23456789";
    Random random = new Random();
    // session中要用到
    String msgCode = "";
    int x = 5;
    for (int i = 0; i < 4; i++) {
      int index = random.nextInt(32);
      String content = String.valueOf(s.charAt(index));
      msgCode += content;
      double theta = random.nextInt(45) * Math.PI / 180;
      // 让字体扭曲
      graphics2d.rotate(theta, x, 18);
      graphics2d.drawString(content, x, 18);
      graphics2d.rotate(-theta, x, 18);
      x += 30;
    }
    request.getSession().setAttribute("msgCode", msgCode);

    // 6、绘制干扰线
    graphics.setColor(Color.GRAY);
    for (int i = 0; i < 5; i++) {
      int x1 = random.nextInt(width);
      int x2 = random.nextInt(width);

      int y1 = random.nextInt(height);
      int y2 = random.nextInt(height);
      graphics.drawLine(x1, y1, x2, y2);
    }
    ImageIO.setUseCache(false);

    // 释放资源
    graphics.dispose();

    // 图片输出 ImageIO
    ImageIO.write(bufferedImage, "jpg", response.getOutputStream());
  }

  @RequestMapping("/check")
  public void check(
      @RequestParam(name = "username") String username,
      HttpServletResponse response) throws IOException {
    ModelAndView mv = new ModelAndView();
    User user = userService.check(username);
    if (user == null) {
      response.getWriter().println("1");
    } else {
      response.getWriter().println("0");
    }
  }


  /**
   * 退出登录
   * @param request
   * @param response
   * @throws ServletException
   * @throws IOException
   */
  @RequestMapping("/loginOut")
  public void loginOut(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    request.getSession().invalidate();
    request.getRequestDispatcher("/index").forward(request, response);
  }
}
