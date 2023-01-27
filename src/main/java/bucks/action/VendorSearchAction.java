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
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import bucks.model.*;
import bucks.list.*;
import bucks.utils.*;

public class VendorSearchAction extends TopAction{

    static final long serialVersionUID = 150L;	
    static boolean debug = false;
    static Logger logger = LogManager.getLogger(VendorSearchAction.class);
    VendorList vendLst = null;
    List<Vendor> vendors = null;
    String vendorsTitle = "Vendors";
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
	if(!action.isEmpty()){
	    back = vendLst.find();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		vendors = vendLst.getVendors();
		if(vendors != null && vendors.size() > 0)
		    addActionMessage("Found "+vendors.size()+" vendors");
		else
		    addActionMessage("No match found ");
	    }
	}
	else{
	    getVendLst();
	    back = vendLst.find();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		vendors = vendLst.getVendors();
		if(vendors != null && vendors.size() > 0)
		    addActionMessage("Found "+vendors.size()+" vendors");
	    }						
	}
	return ret;
    }

    public List<Vendor> getVendors(){
	return vendors;
    }
    public void setVendLst(VendorList val){
	if(val != null)
	    vendLst = val;
    }
    public VendorList getVendLst(){
	if(vendLst == null){
	    vendLst = new VendorList();
	}
	return vendLst;
    }
    public boolean hasVendors(){
	getVendors();
	return vendors != null && vendors.size() > 0;
    }
    public String populate(){
	String ret = SUCCESS;
	return ret;
    }
    public String getVendorsTitle(){
	return vendorsTitle;
    }

		
}





































