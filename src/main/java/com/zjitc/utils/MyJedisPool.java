package com.zjitc.utils;

import java.util.Map;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * Create By IntelliJ IDEA
 *
 * @author:Admin
 * @create-Time:2018/4/12 10:33
 * @description:${DESCRIPTION}
 */
public class MyJedisPool {

  @Autowired
  private JedisPool pool;

  public MyJedisPool(JedisPool pool) {
    this.pool = pool;
  }

  //=============================key============================
  /**
   * 指定缓存失效时间
   * @param key 键
   * @param time 时间(秒)
   * @return
   */
  public boolean expire(String key,int time){
    Jedis jedis = pool.getResource();
    try {
      if(time>0){
        jedis.expire(key, time);
      }
      return true;
    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }finally {
      jedis.close();
    }
  }

  /**
   * 根据key 获取过期时间
   * @param key 键 不能为null
   * @return 时间(秒) 返回0代表为永久有效
   */
  public long getExpire(String key){
    Jedis jedis = pool.getResource();
    try {
      return jedis.ttl(key);
    }finally {
      jedis.close();
    }
  }

  /**
   * 移除key的过期时间
   * @param key
   * @return
   */
  public long moveExpire(String key){
    Jedis jedis = pool.getResource();
    try {
      return jedis.persist(key);
    }finally {
      jedis.close();
    }
  }

  /**
   * 判断key是否存在
   * @param key 键
   * @return true 存在 false不存在
   */
  public boolean exists(String key){
    Jedis jedis = pool.getResource();
    try {
      return jedis.exists(key);
    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }finally {
      jedis.close();
    }
  }

  /**
   * 删除缓存
   * @param keys 可以传一个值 或多个
   */
  @SuppressWarnings("unchecked")
  public long del(String ... keys){
    Jedis jedis = pool.getResource();
    long count = 0;
    try{
      for(int i = 0;i < keys.length ;i ++){
        Long del = jedis.del(keys[i]);
        count += del;
      }
      return count;
    }finally {
      jedis.close();
    }
  }

  //============================String=============================
  /**
   * 普通缓存获取
   * @param key 键
   * @return 值
   */
  public Object get(String key){
    Jedis jedis = pool.getResource();
    try {
      return key == null ? null : jedis.get(key);
    }finally {
      jedis.close();
    }
  }

  /**
   * 普通缓存放入
   * @param key 键
   * @param value 值
   * @return true成功 false失败
   */
  public boolean set(String key,String value) {
    Jedis jedis = pool.getResource();
    try {
      jedis.set(key, value);
      return true;
    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }finally {
      jedis.close();
    }

  }

  /**
   * 普通缓存放入并设置时间
   * @param key 键
   * @param value 值
   * @param time 时间(秒) time要大于0 如果time小于等于0 将设置无限期
   * @return true成功 false 失败
   */
  public boolean set(String key,String value, int time){
    Jedis jedis = pool.getResource();
    try {
      if(time>0) {
        jedis.set(key, value);
        expire(key, time);
      }
      return true;
    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }finally {
      jedis.close();
    }
  }

  /**
   * 递增
   * @param key 键
   * @param delta 要增加几(大于0)
   * @return
   */
  public long increase(String key, long delta){
    Jedis jedis = pool.getResource();
    if(delta<0){
      throw new RuntimeException("递增因子必须大于0");
    }
    try {
      return jedis.incrBy(key, delta);
    }finally {
      jedis.close();
    }
  }

  /**
   * 递减
   * @param key 键
   * @param delta 要减少几(小于0)
   * @return
   */
  public long decrease(String key, long delta){
    Jedis jedis = pool.getResource();
    if(delta<0){
      throw new RuntimeException("递减因子必须大于0");
    }
    try {
      return jedis.decrBy(key, delta);
    }finally {
      jedis.close();
    }
  }

  //================================Hash=================================
  /**
   * HashGet
   * @param key 键 不能为null
   * @param field 项 不能为null
   * @return 值
   */
  public Object hashget(String key,String field){
    Jedis jedis = pool.getResource();
    try {
      return jedis.hget(key,field);
    }finally {
      jedis.close();
    }
  }

  /**
   * 查看哈希表key中，指定的字段是否存在
   * @param key
   * @param field
   * @return
   */
  public boolean existshash(String key,String field){
    Jedis jedis = pool.getResource();
    try{
      return jedis.hexists(key,field);
    }finally {
      jedis.close();
    }
  }


  /**
   * 获取存储在哈希表中指定字段的值。
   * @param key
   * @param field
   * @return
   */
  public String hashMapget(String key, String field){
    Jedis jedis = pool.getResource();
    try {
      return jedis.hget(key,field);
    }finally {
      jedis.close();
    }
  }

  /**
   * 获取hashKey对应的所有键值
   * @param key 键
   * @return 对应的多个键值
   */
  public Map<String, String> hashMapGetAll(String key){
    Jedis jedis = pool.getResource();
    try {
      return jedis.hgetAll(key);
    }finally {
      jedis.close();
    }
  }

  /**
   * 同时将多个 key-value (域-值)对设置到哈希表 key 中。
   * @param key 键
   * @param map 对应多个键值
   * @return true 成功 false 失败
   */
  public String hashMapset(String key, Map<String,String > map){
    Jedis jedis = pool.getResource();
    try {
      return jedis.hmset(key, map);
    } catch (Exception e) {
      e.printStackTrace();
      return "存储中出错";
    }finally {
      jedis.close();
    }
  }

  /**
   * 同时将多个 key-value (域-值)对设置到哈希表 key 中 并设置时间
   * @param key 键
   * @param map 对应多个键值
   * @param time 时间(秒)
   * @return true成功 false失败
   */
  public String hashMapset(String key, Map<String,String> map, int time){
    Jedis jedis = pool.getResource();
    try {
      String hmset = jedis.hmset(key, map);
      expire(key,time);
      return hmset;
    } catch (Exception e) {
      e.printStackTrace();
      return "存储中出错";
    }finally {
      jedis.close();
    }
  }

  /**
   * 只有在字段 field 不存在时，设置哈希表字段的值。
   * @param key 键
   * @param field 项
   * @param value 值
   * @return true 成功 false失败
   */
  public Long hashExistset(String key,String field,String value) {
    Jedis jedis = pool.getResource();
    try {
      Long count = jedis.hsetnx(key, field, value);
      return count;
    } finally {
      jedis.close();
    }
  }

  /**
   * 只有在字段 field 不存在时，设置哈希表字段的值。 并设置时间
   * @param key 键
   * @param field 项
   * @param value 值
   * @param time 时间(秒)  注意:如果已存在的hash表有时间,这里将会替换原有的时间
   * @return true 成功 false失败
   */
  public Long hashExistset(String key,String field,String  value,int time) {
    Jedis jedis = pool.getResource();
    try {
      Long aLong = jedis.hsetnx(key, field, value);
      if(time>0){
        expire(key, time);
      }
      return aLong;
    } finally {
      jedis.close();
    }
  }

  /**
   * 删除hash表中的值
   * @param key 键 不能为null
   * @param field 项 可以使多个 不能为null
   */
  public void delHash(String key, String... field){
    Jedis jedis = pool.getResource();
    try {
      jedis.hdel(key, field);
    }finally {
      jedis.close();
    }
  }


  //============================set=============================
  /**
   * 根据key获取Set中的所有值
   * @param key 键
   * @return
   */
  public Set<String> getAllSet(String key){
    Jedis jedis = pool.getResource();
    try {
      return jedis.smembers(key);
    } finally {
      jedis.close();
    }
  }

  /**
   * 根据value从一个set中查询,是否存在
   * @param key 键
   * @param value 值
   * @return true 存在 false不存在
   */
  public boolean existsSet(String key,String value){
    Jedis jedis = pool.getResource();
    try {
      return jedis.sismember(key,value);
    }finally {
      jedis.close();
    }
  }

  /**
   * 向集合添加一个或多个成员
   * @param key 键
   * @param values 值 可以是多个
   * @return 成功个数
   */
  public long addSet(String key, String...values) {
    Jedis jedis = pool.getResource();
    try {
      return jedis.sadd(key, values);
    } catch (Exception e) {
      e.printStackTrace();
      return 0;
    }finally {
      jedis.close();
    }
  }

  /**
   * 向集合添加一个或多个成员  并设置时间
   * @param key 键
   * @param time 时间(秒)
   * @param values 值 可以是多个
   * @return 成功个数
   */
  public long addSet(String key,int time,String...values) {
    Jedis jedis = pool.getResource();
    try {
      Long count = jedis.sadd(key, values);
      if(time>0){
        expire(key, time);
      }
      return count;
    } catch (Exception e) {
      e.printStackTrace();
      return 0;
    }finally {
      jedis.close();
    }
  }

  /**
   * 获取set缓存的长度
   * @param key 键
   * @return
   */
  public long getSetLength(String key){
    Jedis jedis = pool.getResource();
    try {
      return jedis.scard(key);
    } finally {
      jedis.close();
    }
  }

  /**
   * 移除值为value的
   * @param key 键
   * @param values 值 可以是多个
   * @return 移除的个数
   */
  public long removeSetby(String key, String ...values) {
    Jedis jedis = pool.getResource();
    try {
      Long count = jedis.srem(key, values);
      return count;
    }finally {
      jedis.close();
    }
  }
  //===============================list=================================

  /**
   * 获取list缓存的长度
   * @param key 键
   * @return
   */
  public long getListSize(String key){
    Jedis jedis = pool.getResource();
    try {
      return jedis.llen(key);
    } finally {
      jedis.close();
    }
  }

  /**
   * 通过索引 获取list中的值
   * @param key 键
   * @param index 索引  index>=0时， 0 表头，1 第二个元素，依次类推；index<0时，-1，表尾，-2倒数第二个元素，依次类推
   * @return
   */
  public Object getListIndex(String key,long index){
    Jedis jedis = pool.getResource();
    try {
      return jedis.lindex(key, index);
    } finally {
      jedis.close();
    }
  }

  /**
   * 将list放入缓存 从头开始
   * @param key 键
   * @param value 值
   * @return
   */
  public boolean addListL(String key, String... value) {
    Jedis jedis = pool.getResource();
    try {
      jedis.lpush(key, value);
      return true;
    } finally {
      jedis.close();
    }
  }

  /**
   * 将list放入缓存
   * @param key 键
   * @param value 值
   * @param time 时间(秒)
   * @return
   */
  public boolean addListL(String key, String value, int time) {
    Jedis jedis = pool.getResource();
    try {
      addListL(key,value);
      if (time > 0){ expire(key, time);}
      return true;
    } finally {
      jedis.close();
    }
  }

  /**
   * 将list放入缓存
   * @param key 键
   * @param value 值
   * @return
   */
  public boolean addListR(String key, String... value) {
    Jedis jedis = pool.getResource();
    try {
      jedis.rpush(key, value);
      return true;
    } finally {
      jedis.close();
    }
  }

  /**
   * 将list放入缓存
   * @param key 键
   * @param value 值
   * @param time 时间(秒)
   * @return
   */
  public boolean addListR(String key, int time, String... value) {
    Jedis jedis = pool.getResource();
    try {
      addListR(key, value);
      if (time > 0){ expire(key, time);}
      return true;
    } finally {
      jedis.close();
    }
  }

  /**
   * 根据索引修改list中的某条数据
   * @param key 键
   * @param index 索引
   * @param value 值
   * @return
   */
  public boolean setByIndex(String key, int index,String value) {
    Jedis jedis = pool.getResource();
    try {
      jedis.lset(key,index,value);
      return true;
    } finally {
      jedis.close();
    }
  }

  /**
   * 移除N个值为value
   * @param key 键
   * @param count 移除多少个
   * @param value 值
   * @return 移除的个数
   */
  public long lRemove(String key,long count,String value) {
    Jedis jedis = pool.getResource();
    try {
      Long remove = jedis.lrem(key, count, value);
      return remove;
    }finally {
      jedis.close();
    }
  }

}
