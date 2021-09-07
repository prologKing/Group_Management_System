/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.pojo;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Developer
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="companies")
public class Companies {
    private Company[] company = new Company[1];

    public Company[] getCompany() {
        return company;
    }

    public void setCompany(Company[] company) {
        this.company = company;
    }
    
    
}
