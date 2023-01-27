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
import org.apache.struts2.ServletActionContext;  
import org.apache.struts2.util.ServletContextAware;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import bucks.model.*;
import bucks.list.*;
import bucks.utils.*;

public class CancelledSearchAction extends TopAction{

    static final long serialVersionUID = 228L;	
    static Logger logger = LogManager.getLogger(CancelledSearchAction.class);
    //
    List<CancelledBuck> bucks = null;
    CancelledBuckList bucksList = null;
    private List<Type> buck_types = null;
    String bucksTitle = "Cancelled MB's & GC's";
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
	    bucksList.setNoLimit();
	    back = bucksList.find();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		bucks = bucksList.getBucks();
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

    public CancelledBuckList getBucksList(){ 
	if(bucksList == null){
	    bucksList = new CancelledBuckList(debug);
	}		
	return bucksList;
    }
    public List<CancelledBuck> getBucks(){
	return bucks;
    }
    public String getBucksTitle(){
	return bucksTitle;
    }

    public List<Type> getBuck_types(){
	if(buck_types == null){
	    TypeList bcl = new TypeList(debug, "buck_types");
	    String back = bcl.find();
	    if(back.equals("")){
		buck_types = bcl.getTypes();
	    }
	}
	Type tt = new Type(debug, "-1","All");
	buck_types.add(0,tt);
	return buck_types;
    }	

    public String populate(){
	String ret = SUCCESS;
	bucksList = new CancelledBuckList(debug);
	return ret;
    }

}





































