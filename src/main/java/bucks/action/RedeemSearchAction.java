/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 */
package bucks.action;

import java.util.*;
import java.io.*;
import java.text.*;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import bucks.model.*;
import bucks.list.*;
import bucks.utils.*;

public class RedeemSearchAction extends TopAction{

    static final long serialVersionUID = 226L;	
    static Logger logger = LogManager.getLogger(RedeemSearchAction.class);
    //
    List<Redeem> redeems = null;
    RedeemList redeemList = null;
    String bucksTitle = "Redeemed Bucks";
    String redeemsTitle = "Redemptions";
    String disputesTitle = "Dispute Cases in This Redemption";
    public String execute(){
	String ret = SUCCESS;
	String back = doPrepare();
	if(!back.equals("")){
	    try{
		HttpServletResponse res = ServletActionContext.getResponse();
		String str = url+"Login";
		res.sendRedirect(str);
		return super.execute();
	    }catch(Exception ex){
		System.err.println(ex);
	    }	
	}		
	if(action.equals("Search")){
	    ret = SUCCESS;			
	    back = redeemList.find();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		redeems = redeemList.getRedeems();
		if(redeems == null || redeems.size() == 0){
		    redeemsTitle = "No match found ";
		}
		else{
		    redeemsTitle = "Found "+redeems.size()+" records";
		}
	    }
	}		
	return ret;
    }
    public RedeemList getRedeemList(){ // starting a new redeem
	if(redeemList == null){
	    redeemList = new RedeemList(debug);
	}		
	return redeemList;
    }
    public List<Redeem> getRedeems(){
	return redeems;
    }
    public String getBucksTitle(){
	return bucksTitle;
    }
    public String getRedeemsTitle(){
	return redeemsTitle;
    }

    // we need this for auto_complete
    public void setVendorName(String val){
	// just ignore 
    }	
    public String populate(){
	String ret = SUCCESS;
	redeemList = new RedeemList(debug);
	return ret;
    }

}





































