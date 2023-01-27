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
import com.opensymphony.xwork2.ModelDriven;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;  
import org.apache.struts2.dispatcher.SessionMap;  
import org.apache.struts2.interceptor.SessionAware;  
import org.apache.struts2.util.ServletContextAware;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import bucks.model.*;
import bucks.list.*;
import bucks.utils.*;


public class DisputeSearchAction extends TopAction{

    static final long serialVersionUID = 29L;	
    static Logger logger = LogManager.getLogger(DisputeSearchAction.class);
    //
    DisputeList disputeList = null;
    List<Dispute> disputes = null;
    private User user;
    String bucksTitle = "Disputed Bucks";
    String disputesTitle = "Most Recent Disputes";
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
	if(action.equals("Find")){ 
	    ret = SUCCESS;			
	    back = disputeList.find();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		List<Dispute> list = disputeList.getDisputes();
		if(list == null || list.size() == 0){
		    disputesTitle = "No dispute cases found";
		}
		else{
		    disputesTitle = "Found "+list.size()+" record";
		    disputes = list;
		}
	    }
	}		
	return ret;
    }

    public DisputeList getDisputeList(){ // starting a new redeem
	if(disputeList == null){
	    disputeList = new DisputeList(debug);
	}		
	return disputeList;
    }
    public void setDisputeList(DisputeList val){
	if(val != null)
	    disputeList = val;
    }
    public List<Dispute> getDisputes(){ // starting a new redeem
	if(disputes == null){
	    disputes = new ArrayList<Dispute>();
	}		
	return disputes;
    }	
    public String getBucksTitle(){
	return bucksTitle;
    }
    public String getDisputesTitle(){
	return disputesTitle;
    }	

}





































