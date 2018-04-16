package com.zjitc.service;

import com.zjitc.pojo.Category;
import java.util.List;

/**
 * Create By IntelliJ IDEA
 *
 * @author:Admin
 * @create-Time:${DATETIME}
 * @description:${DESCRIPTION}
 */
public interface CategoryService {

  Category findByCid(String cid);

  List<Category> findAll();

}
