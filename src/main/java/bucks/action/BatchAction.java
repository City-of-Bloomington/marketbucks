package bucks.action;
/**
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 */
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

public class BatchAction extends TopAction{

    static final long serialVersionUID = 20L;	
    String conf_id="";
    static Logger logger = LogManager.getLogger(BatchAction.class);
    //
    // we need the latest buckConf to get the
    // buck face value and expire date for the season
    //
    boolean needBuckConf = false;
    Batch batch = null;
    List<Batch> batches = null;
    public String execute(){
	String ret = INPUT;
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
	    ret = SUCCESS;
	    batch.setUser_id(user.getId());
	    back = batch.doSave();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		back = batch.findBuckListSeq();
		if(!back.equals("")){
		    addActionError(back);
		}
		else{ // it should show pdf of bucks
		    addActionMessage("Ready To Print");
		}
	    }
	}
	else if(action.equals("Confirm")){
	    ret = SUCCESS;			
	    batch.setUser_id(user.getId());
	    back = batch.findBuckListSeq();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{ 
		back = batch.doInsert();
		if(!back.equals("")){
		    addActionError(back);
		}
		else{
		    addActionMessage("Saved Successfully");
		}
	    }
	}		
	else if(!id.equals("")){
	    ret = populate();
	}
	else if(!conf_id.equals("")){
	    batch = new Batch(debug);
	    batch.setConf_id(conf_id);
	}
	else{
	    addActionMessage("To add a new batch, start from configuration page");
	}
	return ret;
    }

    public Batch getBatch(){ // starting a new batch
	if(batch == null){
	    batch = new Batch(debug);
	}		
	return batch;
    }
    public List<Batch> getBatches(){
	BatchList bl = new BatchList(debug);
	String back = bl.find();
	if(back.equals("") && bl.getBatches() != null){
	    batches = bl.getBatches();
	}
	return batches;
    }
    public void setBatch(Batch val){
	if(val != null)
	    batch = val;
    }
    @Override
    public String getId(){
	if(id.equals("") && batch != null){
	    id = batch.getId();
	}
	return id;
    }
    public String getConf_id(){
	if(conf_id.equals("") && batch != null){
	    conf_id = batch.getConf_id();
	}
	return conf_id;
    }
    public void setConf_id(String val){
	if(val != null)
	    conf_id = val;
    }	
    public String getBatchesTitle(){
	return "Most recent batches";
    }	
    public String populate(){
	String ret = SUCCESS;
	if(!id.equals("")){
	    batch = new Batch(debug, id);
	    String back = batch.doSelect();
	    if(!back.equals("")){
		addActionError(back);
	    }
	}
	return ret;
    }

}





































