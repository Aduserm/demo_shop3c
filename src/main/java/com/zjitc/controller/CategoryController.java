package com.zjitc.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.zjitc.pojo.Category;
import com.zjitc.service.CategoryService;
import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Create By IntelliJ IDEA
 *
 * @author:Admin
 * @create-Time:2018/4/11 22:13
 * @description:${DESCRIPTION}
 */
@Controller
public class CategoryController {

  @Autowired
  private  CategoryService categoryService;

  @RequestMapping("/getCategory")
  @ResponseBody
  public void get(HttpServletResponse response) throws IOException {
    List<Category> categories = categoryService.findAll();

    Gson gson = new GsonBuilder().create();
    String jsonText = gson.toJson(categories);
    response.setHeader("Content-type", "html/text;charset=utf-8");
    response.getWriter().println(jsonText);
  }

}
