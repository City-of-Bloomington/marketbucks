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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;  
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import bucks.model.*;
import bucks.list.*;
import bucks.utils.*;

public class RedeemAction extends TopAction{

    static final long serialVersionUID = 26L;	
    static Logger logger = LogManager.getLogger(RedeemAction.class);
    //
    Redeem redeem = null;
    List<Redeem> redeems = null;
    List<Vendor> vendors = null;
    String bucksTitle = "Redeemed MB & GC";
    String redeemsTitle = "Most Recent Redemptions";
    String disputesTitle = "Disputes in This Redemption";
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
	if(action.equals("Next")){
	    // do nothing here
	    ret = SUCCESS;
	}
	else if(action.equals("Finalize")){ 
	    ret = SUCCESS;			
	    back = redeem.doFinalize();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		back = redeem.doSelect();				
		if(!back.equals("")){
		    addActionError(back);
		}
		else{
		    addActionMessage("Finalized Successfully");
		}
	    }
	}		
	else if(action.equals("Add")){ // adding a buck
	    ret = SUCCESS;			
	    back = redeem.doSelect();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		back = redeem.redeemBuck();
		if(!back.equals("")){
		    addActionError(back);
		}
		else{
		    addActionMessage("Added Successfully");
		}
	    }
	}
	else if(action.equals("Cancel")){ // adding a buck
	    ret = SUCCESS;			
	    back = redeem.doCancel();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		ret = "cancel";
		addActionMessage("Transaction Cancelled Successfully");
	    }
	}		
	else if(action.startsWith("Scan")){ // go to adding more bucks
	    back = redeem.doSelect();	
	    ret = "redeem";
	}		
	else if(action.equals("Update")){ // adding a buck
	    ret = SUCCESS;			
	    back = redeem.updateNotes();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		addActionMessage("Updated Successfully");
	    }
	    redeem.doSelect();
	}		
	else if(!id.equals("")){
	    ret = populate();
	}
	return ret;
    }
    public Redeem getRedeem(){ // starting a new redeem
	if(redeem == null){
	    redeem = new Redeem(debug);
	}		
	return redeem;
    }
    public List<Redeem> getRedeems(){
	RedeemList bl = new RedeemList(debug);
	bl.setLimit("50");
	String back = bl.find();
	if(back.equals("") && bl.getRedeems() != null){
	    redeems = bl.getRedeems();
	}
	return redeems;
    }
    public List<Vendor> getVendors(){
	VendorList vl = new VendorList(debug);
	String back = vl.find();
	if(back.equals("")){
	    vendors = vl.getVendors();
	}
	return vendors;
    }
    public void setRedeem(Redeem val){
	if(val != null)
	    redeem = val;
    }
    @Override
    public String getId(){
	if(id.equals("") && redeem != null){
	    id = redeem.getId();
	}
	return id;
    }
    public String getBucksTitle(){
	return bucksTitle;
    }
    public String getRedeemsTitle(){
	return redeemsTitle;
    }
    public String getDisputesTitle(){
	return disputesTitle;
    }	
    // we need this for auto_complete
    public void setVendorName(String val){
	// just ignore 
    }	
    public String populate(){
	String ret = SUCCESS;
	if(!id.equals("")){
	    redeem = new Redeem(debug, id);
	    String back = redeem.doSelect();
	    if(!back.equals("")){
		addActionError(back);
	    }
	}
	return ret;
    }

}





































