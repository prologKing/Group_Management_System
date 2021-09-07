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
public class Counter {
    private int count;
  
    public Counter() {
    }
  

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }


    public Counter(int count) {
        this.count = count;
    }

    @Override
    public String toString() {
        return "Counter{" + "count=" + count + '}';
    }
    
    
}
