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
public class Role {
    private String rolename;
    private String privilege;

    public Role() {
    }

    public Role(String rolename, String privilege) {
        this.rolename = rolename;
        this.privilege = privilege;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    public String getPrivilege() {
        return privilege;
    }

    public void setPrivilege(String privilege) {
        this.privilege = privilege;
    }

    @Override
    public String toString() {
        return "Role{" + "rolename=" + rolename + ", privilege=" + privilege + '}';
    }
    
    
}
