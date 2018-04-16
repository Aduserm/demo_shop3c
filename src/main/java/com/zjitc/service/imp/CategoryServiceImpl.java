package com.zjitc.service.imp;

import com.zjitc.dao.CategoryDao;
import com.zjitc.pojo.Category;
import com.zjitc.service.CategoryService;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Create By IntelliJ IDEA
 *
 * @author:Admin
 * @create-Time:${DATETIME}
 * @description:${DESCRIPTION}
 */
@Service
public class CategoryServiceImpl implements CategoryService {

  private static Logger logger = Logger.getLogger(CategoryServiceImpl.class);
  private static List<Category> categories;
  private static LocalDateTime lastUpDateTime;
  private static int MAX_UPDATE_DURATION = 1000 * 1000 * 60;

  @Autowired
  private CategoryDao categoryDao;

  @Override
  public Category findByCid(String cid) {
    return categoryDao.findByCid(cid);
  }

  @Override
  public List<Category> findAll() {
    if (lastUpDateTime == null) {
      categories = categoryDao.findAll();
      lastUpDateTime = LocalDateTime.now();
    } else {
      LocalDateTime now = LocalDateTime.now();
      Duration duration = Duration.between(lastUpDateTime, now);
      if (Math.abs(duration.toMillis()) > MAX_UPDATE_DURATION) {
        categories = categoryDao.findAll();
        lastUpDateTime = LocalDateTime.now();
        logger.warn("update time and to read from db");
      }
    }
    return categories;
  }
}
