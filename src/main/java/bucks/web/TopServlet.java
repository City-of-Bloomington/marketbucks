package bucks.web;
/**
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE
 *
 */
import java.net.URI;
import javax.servlet.ServletContext;
import javax.servlet.ServletConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import bucks.utils.*;

public class TopServlet extends HttpServlet {
    static String url = "";
    static String cookieName="", cookieValue="";
    static String server_path="";
    static boolean debug = false, production=false;
    static Configuration config = null;
    static Logger logger = LogManager.getLogger(TopServlet.class);
    static ServletContext context = null;
    static String endpoint_logout_uri = "";
    static String vendorsCheckUrl=null,
	vendorsDatabase=null,
	vendorsUser=null,
	vendorsPassword=null;
    public void init(ServletConfig conf) {
        try {
            context = conf.getServletContext();
            url     = context.getInitParameter("url");

            String str = context.getInitParameter("debug");
            if (str != null && str.equals("true")) { debug = true; }

            str = context.getInitParameter("server_path");
            if (str != null)  { server_path = str; }

            str = context.getInitParameter("cookieName");
            if (str != null) { cookieName = str; }

            str = context.getInitParameter("cookieValue");
            if (str != null) { cookieValue = str; }

            str = context.getInitParameter("endpoint_logout_uri");
            if (str != null) { endpoint_logout_uri = str; }
	    str = context.getInitParameter("vendorsCheckUrl");
            if (str != null) { vendorsCheckUrl = str; }
	    str = context.getInitParameter("vendorsDatabase");
            if (str != null) { vendorsDatabase = str; }	    
	    str = context.getInitParameter("vendorsUser");
            if (str != null) { vendorsUser = str; }
	    str = context.getInitParameter("vendorsPassword");
            if (str != null) { vendorsPassword = str; }	    
            String username        = context.getInitParameter("adfs_username");
            String auth_end_point  = context.getInitParameter("auth_end_point");
            String token_end_point = context.getInitParameter("token_end_point");
            String callback_uri    = context.getInitParameter("callback_uri");
            String client_id       = context.getInitParameter("client_id");
            String client_secret   = context.getInitParameter("client_secret");
            String scope           = context.getInitParameter("scope");
            String discovery_uri   = context.getInitParameter("discovery_uri");

            config = new Configuration(auth_end_point,
                                       token_end_point,
                                       callback_uri,
                                       client_id,
                                       client_secret,
                                       scope,
                                       discovery_uri,
                                       username);
        }
        catch (Exception ex) {
            System.err.println(" top init "+ex);
            logger.error(" "+ex);
        }
    }
}
