package com.zjitc.utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

/**
 * Create By IntelliJ IDEA
 *
 * @author:Admin
 * @create-Time:2018/4/12 10:49
 * @description:${DESCRIPTION}
 */
public class Utils {

  public static String md5Password(String password) {
    try {
      MessageDigest digest = MessageDigest.getInstance("md5");
      digest.update(password.getBytes());
      return new BigInteger(1, digest.digest()).toString(32);
    } catch (NoSuchAlgorithmException e) {
      e.printStackTrace();
      return null;
    }
  }

  public static String getUUID() {
    UUID uuid = UUID.randomUUID();
    String str = uuid.toString();
    return UUID.randomUUID().toString().replace("-", "");
  }

}
