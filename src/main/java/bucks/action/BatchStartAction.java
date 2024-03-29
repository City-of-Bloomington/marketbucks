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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import bucks.model.*;
import bucks.list.*;
import bucks.utils.*;

public class BatchStartAction extends TopAction{

    static final long serialVersionUID = 22L;	
    static Logger logger = LogManager.getLogger(BatchStartAction.class);
    BuckConf buckConf = null;
    List<BuckConf> buckConfs = null; // most recent confs
    private List<Type> buck_types = null;
    private List<Batch> batches = null;
    private Batch recentBatch = null; // we need this to find the last printed batch for Audit Sheet printing

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
	else if(!id.equals("")){
	    buckConf = new BuckConf(debug, id);
	    back = buckConf.doSelect();
	    if(!back.equals("")){
		addActionError(back);
		ret = ERROR;
	    }
	}
	return ret;
    }

    public BuckConf getBuckConf(){
	if(buckConf == null){
	    buckConf = new BuckConf(debug);
	}		
	return buckConf;
    }
    public void setBuckConf(BuckConf val){
	if(val != null)
	    buckConf = val;
    }
    @Override
    public String getId(){
	if(id.equals("") && buckConf != null){
	    id = buckConf.getId();
	}
	return id;
    }
    public String getBatchesTitle(){
	return "Current batches in this Configuration";
    }	
    public boolean hasRecentDate(){
		
	return !getRecentBatchDate().equals("");
    }
    public String getRecentBatchDate(){
	String ret = "";
	if(recentBatch == null){
	    if(batches == null)
		getBatches();
	}
	if(recentBatch == null && batches != null){
	    recentBatch = batches.get(0);
	}
	if(recentBatch != null){
	    ret = recentBatch.getDate();
	}
	return ret;
    }
    public List<BuckConf> getBuckConfs(){
	if(buckConfs == null){
	    BuckConfList bcl = new BuckConfList(debug);
	    bcl.setExcludeOldYears();
	    String back = bcl.find();
	    if(back.equals("") && (bcl.getBuckConfs() != null)){
		buckConfs = bcl.getBuckConfs();
	    }
	}		
	return buckConfs;
    }
    public List<Type> getBuck_types(){
	if(buck_types == null){
	    TypeList bcl = new TypeList(debug, "buck_types");
	    String back = bcl.find();
	    if(back.equals("")){
		buck_types = bcl.getTypes();
	    }
	}		
	return buck_types;
    }
    public List<Batch> getBatches(){
	BatchList bl = new BatchList(debug);
	String back = bl.find();
	if(back.equals("") && bl.getBatches() != null){
	    batches = bl.getBatches();
	}
	return batches;
    }	
    public String populate(){
	String ret = SUCCESS;
	if(!id.equals("")){
	    buckConf = new BuckConf(debug, id);
	    String back = buckConf.doSelect();
	    if(!back.equals("")){
		addActionError(back);
	    }
	}
	return ret;
    }

}





































