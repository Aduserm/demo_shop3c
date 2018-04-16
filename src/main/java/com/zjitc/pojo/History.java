package com.zjitc.pojo;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;

/**
 * Create By IntelliJ IDEA
 *
 * @author:Admin
 * @create-Time:${DATETIME}
 * @description:${DESCRIPTION}
 */
public class History {

  private static final int MAX_HISTORY_SIZE = 8;
  private Map<String, Product> products = new HashMap<>();
  Queue<String> keys = new LinkedList<>();

  public History() {
  }

  public History(Map<String, Product> products) {
    this.products = products;
  }

  public Map<String, Product> getProducts() {
    return products;
  }

  public void setProducts(Map<String, Product> products) {
    this.products = products;
  }

  public void add(Product product) {
    String pid = product.getPid();
    if (products.containsKey(pid)) {
      return;
    }

    products.put(pid, product);
    keys.add(pid);

    while (keys.size() >= MAX_HISTORY_SIZE) {
      String key = keys.poll();
      products.remove(key);
    }
  }
}
