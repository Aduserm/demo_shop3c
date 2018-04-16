package com.zjitc.dao;

import com.zjitc.pojo.Category;
import java.util.List;

/**
 * Create By IntelliJ IDEA
 *
 * @author:Admin
 * @create-Time:${DATETIME}
 * @description:${DESCRIPTION}
 */
public interface CategoryDao {

  Category findByCid(String cid);

  List<Category> findAll();

}
