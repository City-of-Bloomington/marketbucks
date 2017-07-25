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
import org.apache.log4j.Logger;


public class EbtAction extends TopAction{

		static final long serialVersionUID = 25L;	
		static Logger logger = Logger.getLogger(EbtAction.class);
		//
		Ebt ebt = null;
		List<Ebt> ebts = null;
		String bucksTitle = "Bucks in this Request";
		String ebtsTitle = "Most Recent Requests";
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
				if(action.equals("Next")){ // Save
						ret = SUCCESS;
						ebt.setUser_id(user.getId());
						back = ebt.doSave();
						if(!back.equals("")){
								addActionError(back);
						}
						else{
								action="";
								ret ="issue"; // add bucks
								addActionMessage("Saved Successfully");
						}
				}
				else if(action.equals("Update")){
						ret = SUCCESS;
						ebt.setUser_id(user.getId());
						back = ebt.doUpdate();
						if(!back.equals("")){
								addActionError(back);
						}
						else{
								action="";
								ret ="issue"; // add bucks				
								addActionMessage("Updated Successfully");
						}
				}
				else if(action.startsWith("Cancel")){
						ret = SUCCESS;
						back = ebt.doCancel();
						if(!back.equals("")){
								addActionError(back);
						}
						else{
								List<Buck> bucks = ebt.getBucks();
								if(bucks != null && bucks.size() > 0){
										for(Buck one:bucks){
												if(one.isVoided()){
														CancelledBuck two = new CancelledBuck(debug, one.getId(),user.getId());
														back += two.doSave();
												}
										}
								}
								if(!back.equals("")){
										addActionError(back);
								}
								else{
										ebt = new Ebt();
										id="";
										addActionMessage("Cancelled Successfully");
								}
						}
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
		public List<Ebt> getEbts(){
				EbtList bl = new EbtList(debug);
				String back = bl.find();
				if(back.equals("") && bl.getEbts() != null){
						ebts = bl.getEbts();
				}
				return ebts;
		}
		public boolean hasEbts(){
				getEbts();
				return ebts != null && ebts.size() > 0;
		}
		public void setEbt(Ebt val){
				if(val != null)
						ebt = val;
		}
		public String getBucksTitle(){
				return bucksTitle;
		}
		public String getEbtsTitle(){
				return ebtsTitle;
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





































