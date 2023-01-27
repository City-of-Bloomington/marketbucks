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

public class BatchSearchAction extends TopAction{

    static final long serialVersionUID = 227L;	
    static Logger logger = LogManager.getLogger(BatchSearchAction.class);
    //
    List<Batch> batches = null;
    BatchList batchList = null;
    private List<Type> buck_types = null;
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
	    batchList.setNoLimit();
	    back = batchList.find();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		batches = batchList.getBatches();
		if(batches == null || batches.size() == 0){
		    batchesTitle = "No match found ";
		}
		else{
		    batchesTitle = "Found "+batches.size()+" records";
		}
	    }
	    if(action.startsWith("Printable")){
		try{
		    HttpServletResponse res = ServletActionContext.getResponse();
		    String all = "";
		    for(String key:paramMap.keySet()){
			String[] vals = paramMap.get(key);
			if(key.equals("action")) continue;
			if(vals != null && !vals[0].equals("")){
			    // we remove the batchList. from keys
			    all +="&"+key.substring(key.indexOf(".")+1)+"="+vals[0];
			    // System.err.println(" key "+key+" "+vals[0]);
			}
		    }
		    System.err.println(all);
		    String str = url+"AuditSheet.do?"+all;
		    res.sendRedirect(str);
		    return super.execute();
		}catch(Exception ex){
		    System.err.println(ex);
		}					
	    }
	}		
	return ret;
    }

    public BatchList getBatchList(){ 
	if(batchList == null){
	    batchList = new BatchList(debug);
	}		
	return batchList;
    }
    public List<Batch> getBatches(){
	return batches;
    }
    public String getBucksTitle(){
	return bucksTitle;
    }
    public String getBatchesTitle(){
	return batchesTitle;
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
    // we need this for auto_complete
    public void setVendorName(String val){
	// just ignore 
    }	
    public String populate(){
	String ret = SUCCESS;
	batchList = new BatchList(debug);
	return ret;
    }

}





































