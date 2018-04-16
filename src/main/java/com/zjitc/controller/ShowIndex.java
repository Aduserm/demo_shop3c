package com.zjitc.controller;

import com.zjitc.pojo.Product;
import com.zjitc.service.ProductService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Create by IntelliJ IDEA
 *
 * @author: Admin
 * @create-Time: ${DATETIME}
 * @description: ${DESCRIPTION}
 */
@Controller

public class ShowIndex {
    @Autowired
    private ProductService productService;

    @RequestMapping("/showIndex")
    public ModelAndView showIndex() {
        ModelAndView mv = new ModelAndView();
        List<Product> hots = productService.findHots();
        List<Product> nest = productService.findNest();
        mv.addObject("hots", hots);
        mv.addObject("nest", nest);
        mv.setViewName("/jsp/index.jsp");
        return mv;
    }
}
