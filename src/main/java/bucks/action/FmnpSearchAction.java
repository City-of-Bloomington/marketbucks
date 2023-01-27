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


public class FmnpSearchAction extends TopAction{

    static final long serialVersionUID = 237L;	
    static Logger logger = LogManager.getLogger(FmnpSearchAction.class);
    //
    List<FmnpWic> wics = null;
    List<FmnpSenior> seniors = null;		
    FmnpSearch fmnp = null;
    String wicsTitle = "FMNP WIC Transactions";
    String seniorsTitle = "FMNP Seniors Transactions";
    int wicsTotal = 0;
    int seniorsTotal = 0;
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
	    fmnp.setNoLimit();
	    back = fmnp.find();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		wics = fmnp.getWics();
		if(wics == null || wics.size() == 0){
		    wicsTitle = "FMNP WIC, no match found ";
		}
		else{
		    wicsTitle = "FMNP WIC "+wics.size()+" records";
		}
		seniors = fmnp.getSeniors();
		if(seniors == null || seniors.size() == 0){
		    seniorsTitle = "FMNP Senior, no match found ";
		}
		else{
		    seniorsTitle = "FMNP Senior "+seniors.size()+" records";
		}								
	    }
	}		
	return ret;
    }

    public FmnpSearch getFmnp(){ 
	if(fmnp == null){
	    fmnp = new FmnpSearch(debug);
	}		
	return fmnp;
    }
    public List<FmnpWic> getWics(){
	return wics;
    }
    public List<FmnpSenior> getSeniors(){
	return seniors;
    }		
    public int getWicsTotal(){
	if(hasWics()){
	    if(wicsTotal == 0){
		for(FmnpWic one:wics){
		    if(!one.isCancelled()){
			wicsTotal += one.getAmountInt();
		    }
		}
	    }
	}
	return wicsTotal;
    }
    public int getSeniorsTotal(){
	if(hasSeniors()){
	    if(seniorsTotal == 0){
		for(FmnpSenior one:seniors){
		    if(!one.isCancelled()){
			seniorsTotal += one.getAmountInt();
		    }
		}
	    }
	}
	return seniorsTotal;
    }		
    public boolean hasWics(){
	return wics != null && wics.size() > 0;
    }
    public boolean hasSeniors(){
	return seniors != null && seniors.size() > 0;
    }		
    public String getWicsTitle(){
	return wicsTitle;
    }
    public String getSeniorsTitle(){
	return seniorsTitle;
    }
    // we need this for auto_complete
    public String populate(){
	String ret = SUCCESS;
	getFmnp();
	return ret;
    }

}





































