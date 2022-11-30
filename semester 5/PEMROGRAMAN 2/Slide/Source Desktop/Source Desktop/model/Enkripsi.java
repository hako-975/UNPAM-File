/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.security.MessageDigest;

/**
 *
 * @author YULIANTI
 */
public class Enkripsi {
    public String hashMD5(String value) throws Exception{
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(value.getBytes());
 
        byte byteData[] = md.digest();
        
        StringBuilder hexString = new StringBuilder();
    	for (int i=0;i<byteData.length;i++) {
    		String hex=Integer.toHexString(0xff & byteData[i]);
   	     	if (hex.length()==1) {
                    hexString.append('0');
                }
   	     	hexString.append(hex);
    	}
    	
        return hexString.toString();
    }
}
