/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.pojo;


/**
 *
 * @author Developer
 */

public class Company {
    private String id;
    private String host;
    private String port;
    private String username;
    private String password;
    private String auth;
    private String starttls;

    public Company() {
    }

    public Company(String id, String host, String port, String username, String password, String auth, String starttls) {
        this.id = id;
        this.host = host;
        this.port = port;
        this.username = username;
        this.password = password;
        this.auth = auth;
        this.starttls = starttls;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getPort() {
        return port;
    }

    public void setPort(String port) {
        this.port = port;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAuth() {
        return auth;
    }

    public void setAuth(String auth) {
        this.auth = auth;
    }

    public String getStarttls() {
        return starttls;
    }

    public void setStarttls(String starttls) {
        this.starttls = starttls;
    }

    @Override
    public String toString() {
        return "EmailConfig{" + "id=" + id + ", host=" + host + ", port=" + port + ", username=" + username + ", password=" + password + ", auth=" + auth + ", starttls=" + starttls + '}';
    }

}
