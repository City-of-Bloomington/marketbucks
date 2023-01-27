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


public class IssueAction extends TopAction{

    static final long serialVersionUID = 25L;	
    static Logger logger = LogManager.getLogger(IssueAction.class);
    //
    Ebt ebt = null;
    String bucksTitle = "Market Bucks issued to this custmer";
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
	if(action.equals("Next")){ // carried over from ebtAction
	    ebt.doSelect();
	    ret = SUCCESS;
	}
	else if(action.equals("Add")){ // adding a buck
	    ret = SUCCESS;			
	    back = ebt.doSelect();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		back = ebt.handleAddingBuck();
		if(!back.equals("")){
		    addActionError(back);
		}
		else{
		    addActionMessage("Added Successfully");
		}
	    }
	}		
	else if(!id.equals("")){
	    ret = populate();
	}
	return ret;
    }
    public Ebt getEbt(){ // starting a new ebt
	if(ebt == null){
	    ebt = new Ebt(debug);
	}		
	return ebt;
    }

    public void setEbt(Ebt val){
	if(val != null)
	    ebt = val;
    }
    @Override
    public String getId(){
	if(id.equals("") && ebt != null){
	    id = ebt.getId();
	}
	return id;
    }
    public String getBucksTitle(){
	return bucksTitle;
    }	

    public String populate(){
	String ret = SUCCESS;
	if(!id.equals("")){
	    ebt = new Ebt(debug, id);
	    String back = ebt.doSelect();
	    if(!back.equals("")){
		addActionError(back);
	    }
	}
	return ret;
    }

}





































