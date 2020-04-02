/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 */
package bucks;

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


public class SnapAction extends TopAction{

    static final long serialVersionUID = 25L;	
    static Logger logger = LogManager.getLogger(SnapAction.class);
    //
    Snap snap = null;
    List<Snap> snaps = null;
    String snapsTitle = "Most Recent Requests";
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
	if(action.equals("Save")){ 
	    ret = SUCCESS;
	    snap.setUser_id(user.getId());
	    back = snap.doSave();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		action="";
		addActionMessage("Saved Successfully");
	    }
	}
	else if(action.equals("Update")){
	    ret = SUCCESS;
	    snap.setUser_id(user.getId());
	    back = snap.doUpdate();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		action="";
		addActionMessage("Updated Successfully");
	    }
	}
	else if(action.startsWith("Cancel")){
	    ret = SUCCESS;
	    back = snap.doCancel();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		snap = new Snap();
		id="";
		addActionMessage("Cancelled Successfully");
	    }
	}		
	else if(!id.equals("")){
	    ret = populate();
	}
	return ret;
    }
    public Snap getSnap(){ // starting a new snap
	if(snap == null){
	    snap = new Snap(debug);
	}		
	return snap;
    }
    public List<Snap> getSnaps(){
	if(snaps == null){
	    SnapList bl = new SnapList(debug);
	    bl.setTodayDate();
	    String back = bl.find();
	    if(back.equals("") && bl.getSnaps() != null){
		snaps = bl.getSnaps();
	    }
	}
	return snaps;
    }
    public boolean hasSnaps(){
	getSnaps();
	return snaps != null && snaps.size() > 0;
    }
    public void setSnap(Snap val){
	if(val != null)
	    snap = val;
    }
    public String getSnapsTitle(){
	return snapsTitle;
    }	
    public String populate(){
	String ret = SUCCESS;
	if(!id.equals("")){
	    snap = new Snap(debug, id);
	    String back = snap.doSelect();
	    if(!back.equals("")){
		addActionError(back);
	    }
	}
	return ret;
    }
    public double getSnapTotal(){
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
	return snapTotal;
    }
    public double getDblTotal(){
	if(snapTotal == 0)
	    getSnapTotal();
	return dblTotal;
    }
    public double getEbtTotal(){
	if(snapTotal == 0)
	    getSnapTotal();
	return ebtTotal;
    }	    

}





































