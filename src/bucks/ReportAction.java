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
		public List<String> getYears(){
				if(years == null){
						int yy = Helper.getCurrentYear();
						years = new ArrayList<String>(11);
						years.add("");
						for(int i=0;i<3;i++){
								int y2 = yy - i;
								years.add(""+y2);
						}
				}
				return years;
		}

}





































