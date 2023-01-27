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

public class BuckAction extends TopAction{

    static final long serialVersionUID = 22L;	
    static Logger logger = LogManager.getLogger(BuckAction.class);
    //
    Buck buck = null;
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
	if(!id.equals("")){
	    getBuck();
	    buck.setId(id);
	    back = buck.doSelect();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		/**
		   back = buck.findOtherBuckInfo();
		   if(!back.equals("")){
		   addActionError(back);
		   }
		*/
	    }
	}
	return ret;
    }
    public Buck getBuck(){ 
	if(buck == null){
	    buck = new Buck(debug);
	}		
	return buck;
    }
    public void setBuck(Buck val){
	if(val != null)
	    buck = val;
    }
    @Override
    public String getId(){
	if(id.equals("") && buck != null){
	    id = buck.getId();
	}
	return id;
    }
}






































