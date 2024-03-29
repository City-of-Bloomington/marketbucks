/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 */
package bucks.list;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import bucks.model.*;
import bucks.utils.*;

public class FmnpWicList implements java.io.Serializable{

    static final long serialVersionUID = 35L;	
   
    boolean debug = false;
    static Logger logger = LogManager.getLogger(FmnpWicList.class);
    static SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
    static SimpleDateFormat dfTime = new SimpleDateFormat("MM/dd/yyyy HH:mm");
    String id="", which_date="r.date_time", limit= " 30 ";

    String date_from="", date_to="", date_to_2="", sortBy="r.id DESC ";
    String buck_id="",ticket_num="", cancelled="",
	dispute_resolution="", amount="";
    List<FmnpWic> fmnpWics = null;
	
    public FmnpWicList(){
    }	
    public FmnpWicList(boolean val){
	debug = val;
    }
    public void setId(String val){
	if(val != null)
	    id = val;
    }
    public void setAmount(String val){
	if(val != null)
	    amount = val;
    }
    public void setBuck_id(String val){
	if(val != null)
	    buck_id = val;
    }
    public void setWhich_date(String val){
	if(val != null)
	    which_date = val;
    }
    public void setDate_from(String val){
	if(val != null)
	    date_from = val;
    }
    public void setDate_to(String val){
	if(val != null){
	    date_to = val;
	    date_to_2 = val+" 23:59";
	}
    }
    public void setCancelled(String val){
	if(val != null && !val.equals("-1"))
	    cancelled = val;
    }
    public void setDispute_resolution(String val){
	if(val != null && !val.equals("-1"))
	    dispute_resolution = val;
    }		
    public void setTicketNum(String val){
	if(val != null)
	    ticket_num = val;
    }	
    public void setNoLimit(){
	limit = "";
    }
    public void setLimit(String val){
	if(val != null)
	    limit = val;
    }
    public void setSortBy(String val){
	if(val != null && !val.equals("-1"))
	    sortBy = val;
    }
    //
    public String getId(){
	return id;
    }
    public String getBuck_id(){
	return buck_id;
    }
    public String getAmount(){
	return amount;
    }
    public String getWhich_date(){
	return which_date;
    }
    public String getDate_from(){
	return date_from ;
    }
    public String getDate_to(){
	return date_to ;
    }

    public String getSortBy(){
	if(sortBy.equals("")){
	    return "-1";
	}
	return sortBy ;
    }
    public String getCancelled(){
	if(cancelled.equals("")){
	    return "-1";
	}
	return cancelled ;
    }
    public String getDispute_resolution(){
	if(dispute_resolution.equals("")){
	    return "-1";
	}
	return dispute_resolution ;
    }		
    public List<FmnpWic> getFmnpWics(){
	return fmnpWics;
    }
    //
    public String find(){
	String qq = "select r.id, r.ticket_num, r.amount,r.wic_max_amount,r.user_id,date_format(r.date_time,'%m/%d/%Y %H:%i'),r.cancelled,r.dispute_resolution ";		
	String qf = " from fmnp_wics r ";
	String qw = "";
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String msg = "";
	if(!id.equals("")){
	    if(!qw.equals("")) qw += " and ";
	    qw += " r.id = ? ";
	}
	else {
	    if(!buck_id.equals("")){
		qf += " left join wic_bucks gb on gb.wic_id=r.id ";
		if(!qw.equals("")) qw += " and ";				
		qw += " gb.buck_id = ? ";				
	    }
	    if(cancelled.equals("y")){
		if(!qw.equals("")) qw += " and ";					
		qw += " r.cancelled is not null ";
	    }
	    else if(cancelled.equals("n")){
		if(!qw.equals("")) qw += " and ";					
		qw += " r.cancelled is null ";
	    }
	    if(dispute_resolution.equals("y")){
		if(!qw.equals("")) qw += " and ";					
		qw += " r.dispute_resolution is not null ";
	    }
	    else if(dispute_resolution.equals("n")){
		if(!qw.equals("")) qw += " and ";					
		qw += " r.dispute_resolution is null ";
	    }						
	    if(!amount.equals("")){
		if(!qw.equals("")) qw += " and ";
		qw += " r.amount = ? ";
	    }
	    if(!ticket_num.equals("")){
		if(!qw.equals("")) qw += " and ";
		qw += " r.ticket_num = ? ";
	    }			
	    if(!which_date.equals("")){
		if(!date_from.equals("")){
		    if(!qw.equals("")) qw += " and ";
		    qw += which_date+" >= ? ";					
		}
		if(!date_to.equals("")){
		    if(!qw.equals("")) qw += " and ";
		    qw += which_date+" <= ? ";					
		}
	    }
	}
	qq += qf;
	if(!qw.equals(""))
	    qq += " where "+qw;
	if(!sortBy.equals("")){
	    qq += " order by "+sortBy;
	}
	if(!limit.equals("")){
	    qq += " limit "+limit;
	}
	logger.debug(qq);
	con = Helper.getConnection();
	if(con == null){
	    msg = "Could not connect ";
	    return msg;
	}
	try{
	    pstmt = con.prepareStatement(qq);
	    int jj=1;

	    if(!id.equals("")){
		pstmt.setString(jj++,id);
	    }
	    else{
		if(!buck_id.equals("")){
		    pstmt.setString(jj++,buck_id);
		}				
		if(!amount.equals("")){
		    pstmt.setString(jj++,amount);
		}
		if(!ticket_num.equals("")){
		    pstmt.setString(jj++,ticket_num);
		}				
		if(!which_date.equals("")){
		    if(!date_from.equals("")){
			pstmt.setDate(jj++, new java.sql.Date(dateFormat.parse(date_from).getTime()));
		    }
		    if(!date_to.equals("")){
			pstmt.setTimestamp(jj++, new java.sql.Timestamp(dfTime.parse(date_to_2).getTime()));
		    }
		}
	    }
	    fmnpWics = new ArrayList<FmnpWic>();			
	    rs = pstmt.executeQuery();
	    while(rs.next()){
		FmnpWic one = new FmnpWic(debug,
					  rs.getString(1),
					  rs.getString(2),
					  rs.getString(3),
					  rs.getString(4),
					  rs.getString(5),
					  rs.getString(6),
					  rs.getString(7),
					  rs.getString(8)
					  );
		fmnpWics.add(one);
	    }
	}catch(Exception e){
	    msg += e+": "+qq;
	    logger.error(msg);
	}
	finally{
	    Helper.databaseDisconnect(con, pstmt, rs);
	}
	return msg;			
    }
}





































