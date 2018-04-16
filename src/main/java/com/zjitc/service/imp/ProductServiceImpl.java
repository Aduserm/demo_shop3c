package com.zjitc.service.imp;

import com.github.pagehelper.PageHelper;
import com.zjitc.dao.ProductDao;
import com.zjitc.pojo.Product;
import com.zjitc.service.ProductService;

import com.zjitc.utils.MyJedisPool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Create by IntelliJ IDEA
 *
 * @author: Admin
 * @create-Time: ${DATETIME}
 * @description: ${DESCRIPTION}
 */
@Service
public class ProductServiceImpl implements ProductService {

//    @Autowired
//    private MyJedisPool jedisPool;

    @Autowired
    private ProductDao productDao;

    @Override
    public List<Product> findHots() {
        return productDao.findHots();
    }

    @Override
    public List<Product> findNest() {
        return productDao.findNest();
    }

    @Override
    public Product findByPid(String pid) {
        return productDao.findByPid(pid);
    }

  @Override
  public List<Product> findByCid(String cid, Integer pageNum, Integer count) {
    PageHelper.startPage(pageNum, count);
    List<Product> pageCid = productDao.findPageCid(cid);
    return pageCid;
   }

  @Override
    public List<Product> findPage(int pageNum, Integer count) {
      PageHelper.startPage(pageNum, count);
      return null;
    }
}
