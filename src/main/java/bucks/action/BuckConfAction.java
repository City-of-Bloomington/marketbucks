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

public class BuckConfAction extends TopAction{

    static final long serialVersionUID = 20L;	
    static Logger logger = LogManager.getLogger(BuckConfAction.class);
    BuckConf buckConf = null;
    List<BuckConf> buckConfs = null; // most recent confs
    private List<Type> buck_types = null;
    private List<Type> gl_accounts = null;
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
	    buckConf.setUser_id(user.getId());
	    back = buckConf.doSave();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		addActionMessage("Saved Successfully");	
	    }
	}
	else if(action.equals("Update")){
	    buckConf.setUser_id(user.getId());			
	    back = buckConf.doUpdate();
	    if(!back.equals("")){
		addActionError(back);
		ret = ERROR;
	    }
	    else{
		addActionMessage("Updated Successfully");				
	    }
	}
	else if(action.equals("Refresh")){ // refresh vendor list
	    /*
	    // this part is automated on the redeem/vendor interface
	    ret = SUCCESS;
	    RefreshVendors rv = new RefreshVendors(debug,
	    vendorsCheckUrl,
	    vendorsDatabase,
	    vendorsUser,
	    vendorsPassword
	    );
	    back = rv.consolidate();
	    if(!back.equals("")){
	    addActionError(back);
	    }
	    else{
	    addActionMessage("Refreshed Successfully");
	    }
	    */
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
    public List<BuckConf> getBuckConfs(){
	if(buckConfs == null){
	    BuckConfList bcl = new BuckConfList(debug);
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
	    bcl.setSortBy("id");
	    String back = bcl.find();
	    if(back.equals("")){
		buck_types = bcl.getTypes();
	    }
	}		
	return buck_types;
    }
    public List<Type> getGl_accounts(){
	if(gl_accounts == null){
	    TypeList bcl = new TypeList(debug, "gl_accounts");
	    bcl.setSortBy("id");
	    String back = bcl.find();
	    if(back.equals("")){
		gl_accounts = bcl.getTypes();
	    }
	}		
	return gl_accounts;
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





































