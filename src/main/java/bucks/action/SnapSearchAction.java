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

public class SnapSearchAction extends TopAction{

    static final long serialVersionUID = 237L;	
    static Logger logger = LogManager.getLogger(SnapSearchAction.class);
    static DecimalFormat dblf = new DecimalFormat("0.00");
    //
    List<Snap> snaps = null;
    SnapList snapList = null;
    String snapsTitle = "Snap Purchases ";
    double snapTotal= 0, dblTotal = 0, ebtTotal=0;
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
	    snapList.setNoLimit();
	    back = snapList.find();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		snaps = snapList.getSnaps();
		if(snaps == null || snaps.size() == 0){
		    snapsTitle = "No match found ";
		    addActionMessage("No match found");
		}
		else{
		    addActionMessage("Found "+snaps.size()+" records" );		    
		    snapsTitle = "Found "+snaps.size()+" records";
		}
	    }
	}		
	return ret;
    }

    public SnapList getSnapList(){ 
	if(snapList == null){
	    snapList = new SnapList(debug);
	}		
	return snapList;
    }
    public List<Snap> getSnaps(){
	return snaps;
    }

    public boolean hasSnaps(){
				
	return snaps != null && snaps.size() > 0;

    }

    public String getSnapsTitle(){
	return snapsTitle;
    }
    public String getSnapTotal(){
	if(hasSnaps()){
	    if(snapTotal == 0){
		for(Snap one:snaps){
		    if(!one.isCancelled()){
			snapTotal += one.getSnapAmountDbl();
			dblTotal += one.getDblAmountDbl();
			ebtTotal += one.getEbtAmountDbl();
		    }
		}
	    }
	}
	return dblf.format(snapTotal);
    }
    public String getDblTotal(){
	if(snapTotal == 0)
	    getSnapTotal();
	return dblf.format(dblTotal);
    }
    public String getEbtTotal(){
	if(snapTotal == 0)
	    getSnapTotal();
	return dblf.format(ebtTotal);
    }	    

    public String populate(){
	String ret = SUCCESS;
	snapList = new SnapList(debug);
	return ret;
    }

}





































