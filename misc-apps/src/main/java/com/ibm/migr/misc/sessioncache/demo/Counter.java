/**
 * 
 */
package com.ibm.migr.misc.sessioncache.demo;

 

import java.io.Serializable;

 

/**
 * @author a7428
 *
 */
public class Counter implements Serializable {

 

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    
    private int count = 0;
    
    public void increment() {
        count++;
    }
    
    public void decrement() {
        count--;
    }
    
    public void reset() {
        count = 0;
    }
    
    public int getCount() {
        return count;
    }
}