package com.zjitc.pojo;

/**
 * Create by IntelliJ IDEA
 *
 * @author: Admin
 * @create-Time: ${DATETIME}
 * @description: ${DESCRIPTION}
 */
public class Msg {
    private String msg;
    private String address;

    public Msg() {
    }

    public Msg(String msg, String address) {

        this.msg = msg;
        this.address = address;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Msg{" +
                "msg='" + msg + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}
