package bucks.action;
/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 */
import java.util.*;
import java.io.*;
import java.text.*;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import bucks.model.*;
import bucks.list.*;
import bucks.utils.*;

public class BuckSearchAction extends TopAction{

    static final long serialVersionUID = 227L;	
    static Logger logger = LogManager.getLogger(BuckSearchAction.class);
    //
    BuckList buckList = null;
    List<Buck> bucks = null;
    String bucksTitle = "Bucks";
    String batchesTitle = "Batches";
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
	if(!action.equals("")){
	    ret = SUCCESS;
	    buckList.setNoLimit();
	    back = buckList.find();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		bucks = buckList.getBucks();
		if(bucks == null || bucks.size() == 0){
		    bucksTitle = "No match found ";
		}
		else{
		    bucksTitle = "Found "+bucks.size()+" records";
		}
	    }
	}		
	return ret;
    }

    public BuckList getBuckList(){ 
	if(buckList == null){
	    buckList = new BuckList(debug);
	}		
	return buckList;
    }
    public List<Buck> getBucks(){
	return bucks;
    }
    public String getBucksTitle(){
	return bucksTitle;
    }
    public String getBatchesTitle(){
	return batchesTitle;
    }

    public String populate(){
	String ret = SUCCESS;
	buckList = new BuckList(debug);
	return ret;
    }

}





































