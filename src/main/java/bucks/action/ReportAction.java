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
import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.struts2.ServletActionContext;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import bucks.model.*;
import bucks.list.*;
import bucks.utils.*;


public class ReportAction extends TopAction{

    static final long serialVersionUID = 80L;	
   
    static Logger logger = LogManager.getLogger(ReportAction.class);
    Report report = null;
    String format = "";
    List<String> years = null;
    List<Vendor> vendors = null;
    public String execute(){
	String ret = INPUT;            // default
	if(action.equals("Submit")){
	    ret = SUCCESS;
	    String back = report.find();
	    if(!back.equals("")){
		addActionError(back);
		ret = INPUT;
	    }
	    else{
		if(!format.equals("")){
		    ret = "csv";
		}
	    }
	}
	return ret;
    }			 
    public Report getReport(){
	if(report == null){
	    report = new Report(debug);
	}
	return report;
    }
    public void setReport(Report val){
	if(val != null)
	    report = val;
    }
    public void setFormat(boolean val){
	if(val)
	    format = "csv";
    }
    public boolean getFormat(){
	return !format.equals("");
    }
    public List<String> getYears(){
	if(years == null){
	    int start_year = 2014;
	    int yy = Helper.getCurrentYear();
	    years = new ArrayList<String>(yy-start_year+1);
	    years.add("");
	    for(int i=yy;i >= start_year;i--){
		years.add(""+i);
	    }
	}
	return years;
    }
    public List<Vendor> getVendors(){
	VendorList vl = new VendorList(debug);
	String back = vl.find();
	if(back.equals("")){
	    vendors = vl.getVendors();
	}
	return vendors;
    }
}





































