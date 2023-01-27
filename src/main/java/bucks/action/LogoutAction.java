/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 */
package bucks.action;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;  
import org.apache.struts2.ServletActionContext;  
import javax.servlet.http.HttpServletResponse;
import bucks.model.*;
import bucks.list.*;
import bucks.utils.*;

public class LogoutAction extends TopAction{

    private static boolean debug = false;
    private static final long serialVersionUID = 60L;
    @Override
    public String execute(){
	try{
	    String cas_url = ctx.getInitParameter("cas_url");
	    HttpServletRequest request = ServletActionContext.getRequest();  
	    HttpSession session=request.getSession();
	    if(session != null)
		session.invalidate();
	    HttpServletResponse res = ServletActionContext.getResponse();
	    res.sendRedirect(cas_url);
	    return super.execute();				
	}catch(Exception ex){
	    System.out.println(ex);
	}
	return SUCCESS;
    }     

}



