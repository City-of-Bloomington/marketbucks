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

public class InventoryAction extends TopAction{

    static final long serialVersionUID = 2223L;	
    static Logger logger = LogManager.getLogger(InventoryAction.class);
    //
    // we need the latest buckConf to get the
    // buck face value and expire date for the season
    //
    private String[] userids = null;
    private List<User> users = null;
    private List<MailUser> mailUsers = null;
    private MailUserList mailUserList = null;
    boolean activeMail = false;
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
	if(action.startsWith("Add")){

	    back = doAddUsers();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		addActionMessage("Users added Successfully");	
	    }				
	}
	else if(action.startsWith("Remove")){
	    back = doDeleteUsers();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		addActionMessage("Users deleted Successfully");	
	    }				
	}
	else if(action.startsWith("Start Schedule")){
	    back = doSchedule();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		addActionMessage("Scheduled Successfully");	
	    }				
	}
	return ret;
    }

    String doSchedule(){
	String back = "";
	try{
	    //
	    // we do not need this anymore as this is run auto through
	    // servlet listener in web.xml
	    //
	    InventoryScheduler schedul = new InventoryScheduler();
	    try{
		schedul.run();
	    }catch(Exception ex){
		back += ex;
		System.err.println(ex);
	    }
	}catch(Exception ex){
	    System.out.println(ex);
	}		
	return back;
    }	
    String doAddUsers(){
	String back = "";
	if(mailUserList != null){
	    back = mailUserList.addUsers();
	}
	return back;
    }
    String doDeleteUsers(){
	String back = "";
	if(mailUserList != null){
	    back = mailUserList.deleteUsers();
	}
	return back;
    }		
    public void setMailUserList(MailUserList val){
	mailUserList = val;
    }
    public MailUserList getMailUserList(){
	if(mailUserList == null){
	    mailUserList = new MailUserList();
	}
	return mailUserList;
    }	
    public List<User> getUsers(){
	if(users == null){
	    UserList userList = new UserList();
	    String back = userList.find();
	    if(back.equals("")){
		users = userList.getUsers();
	    }
	}
	return users;
    }
    public List<MailUser> getMailUsers(){
	MailUserList mlist = new MailUserList();
	String back = mlist.find();
	if(back.equals("")){
	    mailUsers = mlist.getMailUsers();
	}
	return mailUsers;
    }
    public List<User> getNonMailUsers(){
	List<User> list = new ArrayList<User>();
	MailUserList mlist = new MailUserList();
	List<User> mUsers = null;
	String back = mlist.find();
	if(back.equals("")){
	    mUsers = mlist.getUsers();
	}
	if(users == null){
	    getUsers();
	}
	if(users != null){
	    for(User one:users){
		if(mUsers == null || !mUsers.contains(one))
		    list.add(one);
	    }
	}
	return list;
    }
    public String getNext_fire_time(){
	String ret = "";
	MailUserList mlist = new MailUserList();
	String back = mlist.findNextFireTime();
	if(back.equals("")){
	    ret = mlist.getNext_fire_time();
	}
	return ret;
    }

}





































