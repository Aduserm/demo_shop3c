package com.zjitc.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zjitc.pojo.Category;
import com.zjitc.pojo.History;
import com.zjitc.pojo.Product;
import com.zjitc.service.CategoryService;
import com.zjitc.service.ProductService;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.InternalResourceView;

/**
 * Create by IntelliJ IDEA
 *
 * @author: Admin
 * @create-Time: ${DATETIME}
 * @description: ${DESCRIPTION}
 */
@Controller
@RequestMapping("/product")
public class ProducrController {
  private static final Integer count = 12;

  @Autowired
  private ProductService productService;

  @Autowired
  private CategoryService categoryService;

  public void makeHistory(HttpSession session, Product product) {

    Object o = session.getAttribute("history");
    History history = null;

    if (o == null) {
      history = new History();
      session.setAttribute("history", history);
    } else {
      history = (History) o;
    }

    history.add(product);
  }

  @RequestMapping("/productInfo")
  public ModelAndView info(
      @RequestParam(name = "pid") String pid,
      HttpSession session) {
    ModelAndView mv = new ModelAndView();
    Product product  = productService.findByPid(pid);
    Category category = categoryService.findByCid(product.getCid());
    product.setCategory(category);
    makeHistory(session, product);
    mv.addObject("product", product);
    mv.setViewName("/jsp/product_info.jsp");
    return mv;
  }

  @RequestMapping("/productList")
  public ModelAndView list(
      @RequestParam(name = "cid") String cid,
      @RequestParam(name = "pageNum", defaultValue = "1") Integer pageNum) {
    List<Product> list = productService.findByCid(cid, pageNum, count);
    PageInfo<Product> info = new PageInfo<Product>(list);
    ModelAndView mv = new ModelAndView();
    mv.addObject("list", list);
    mv.addObject("page", info);
    mv.addObject("cid", cid);
    mv.setViewName("/jsp/product_list.jsp");

     return mv;
  }

  @RequestMapping("/page_info")
  public ModelAndView pageInfo(
      @RequestParam(name = "pageNum", defaultValue = "1") int pageNum
  ) {
    List<Product> list = productService.findPage(pageNum, count);
    PageInfo<Product> info = new PageInfo<Product>(list);
    ModelAndView mv = new ModelAndView();
    mv.addObject("list", list);
    mv.addObject("page", info);
    mv.setView(new InternalResourceView("/page_info.do"));
    return mv;
  }

  public ModelAndView add2Car(
      @RequestParam(name = "pid") String pid,
      @RequestParam(name = "count") int count
      ) {
    return null;
  }

}
