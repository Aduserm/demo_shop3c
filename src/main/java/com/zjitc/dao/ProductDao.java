package com.zjitc.dao;

import com.zjitc.pojo.Product;

import java.util.List;

/**
 * Create by IntelliJ IDEA
 *
 * @author: Admin
 * @create-Time: ${DATETIME}
 * @description: ${DESCRIPTION}
 */
public interface ProductDao {

  List<Product> findHots();

  List<Product> findNest();

  Product findByPid(String pid);

  List<Product> findPageCid(String cid);
}
