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
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;  
import org.apache.log4j.Logger;

public class EbtSearchAction extends TopAction{

		static final long serialVersionUID = 237L;	
		static Logger logger = Logger.getLogger(EbtSearchAction.class);
		//
		List<Ebt> ebts = null;
		EbtList ebtList = null;
		String bucksTitle = "Bucks";
		String ebtsTitle = "Issued MB's";
		int ebtTotal= 0, dmbTotal = 0;
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
						ebtList.setNoLimit();
						back = ebtList.find();
						if(!back.equals("")){
								addActionError(back);
						}
						else{
								ebts = ebtList.getEbts();
								if(ebts == null || ebts.size() == 0){
										ebtsTitle = "No match found ";
								}
								else{
										ebtsTitle = "Found "+ebts.size()+" records";
								}
						}
				}		
				return ret;
		}

		public EbtList getEbtList(){ 
				if(ebtList == null){
						ebtList = new EbtList(debug);
				}		
				return ebtList;
		}
		public List<Ebt> getEbts(){
				return ebts;
		}
		public int getEbtTotal(){
				if(hasEbts()){
						if(ebtTotal == 0){
								for(Ebt one:ebts){
										if(!one.isCancelled()){
												ebtTotal += one.getAmountInt();
												dmbTotal += one.getDmb_amountInt();
										}
								}
						}
				}
				return ebtTotal;
		}
		public int getDmbTotal(){
				if(ebtTotal == 0)
						getEbtTotal();
				return dmbTotal;
		}
		public boolean hasEbts(){
				
				return ebts != null && ebts.size() > 0;

		}
		public String getBucksTitle(){
				return bucksTitle;
		}
		public String getEbtsTitle(){
				return ebtsTitle;
		}

		// we need this for auto_complete
		public void setVendorName(String val){
				// just ignore 
		}	
		public String populate(){
				String ret = SUCCESS;
				ebtList = new EbtList(debug);
				return ret;
		}

}





































