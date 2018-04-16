package com.zjitc.service;

import com.zjitc.pojo.Product;

import java.util.List;

/**
 * Create by IntelliJ IDEA
 *
 * @author: Admin
 * @create-Time: ${DATETIME}
 * @description: ${DESCRIPTION}
 */
public interface ProductService {

  /**
   * 查询最新商品
   * @return
   */
  List<Product> findHots();

  /**
   * 查询火热商品
   * @return
   */
  List<Product> findNest();

  /**
   * 根据id查询
   * @param pid
   * @return
   */
  Product findByPid(String pid);

  /**
   * 查找分类
   * @param cid
   * @return
   */
  List<Product> findByCid(String cid, Integer pageNum, Integer count);

  /**
   * 分页显示商品
   * @param pageNum
   * @param count
   * @return
   */
  List<Product> findPage(int pageNum, Integer count);
}
