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
import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.struts2.ServletActionContext;
import org.apache.log4j.Logger;

public class ReportAction extends TopAction{

		static final long serialVersionUID = 80L;	
   
		static Logger logger = Logger.getLogger(ReportAction.class);
		Report report = null;
		String format = "";
		List<String> years = null;
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

}





































