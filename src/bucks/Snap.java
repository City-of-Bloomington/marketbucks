package bucks;
/**
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 */
import java.util.*;
import java.sql.*;
import java.io.*;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


public class Snap implements java.io.Serializable{

    static final long serialVersionUID = 19L;	
    boolean debug = false;
    static Logger logger = LogManager.getLogger(Snap.class);
    static SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
    final static double dbl_max_default = 18.0;
    String id="", date="", user_id="", card_number="", authorization="";
    double dbl_amount=0, ebt_amount=0, snap_amount=0, dbl_max = 18.0;
    String cancelled="";
    User user = null;
    public Snap(){
    }	
    public Snap(boolean val){
	debug = val;
    }
    public Snap(boolean val, String val2){
	debug = val;
	setId(val2);
    }
    public Snap(boolean deb,
		String val,
		String val2,
		String val3,
		String val4,
		String val5,
		String val6,
		String val7,
		String val8,
		String val9,
		String val10
		){
	setValues( val,
		   val2,
		   val3,
		   val4,
		   val5,
		   val6,
		   val7,
		   val8,
		   val9,
		   val10
		   );
	debug = deb;
		
    }
    void setValues(
		   String val,
		   String val2,
		   String val3,
		   String val4,
		   String val5,
		   String val6,
		   String val7,
		   String val8,
		   String val9,
		   String val10
		   ){
	setId(val);
	setDate(val2);
	setCardNumber(val3);
	setAuthorization(val4);
	setSnapAmount(val5);
	setEbtAmount(val6);
	setDblAmount(val7);
	setDblMax(val8);
	setUser_id(val9);
	setCancelled(val10);
    }	
    public void setId(String val){
	if(val != null)
	    id = val;
    }
    public void setDate(String val){
	if(val != null)
	    date = val;
    }
    public void setCardNumber(String val){
	if(val != null)
	    card_number = val;
    }
    public void setAuthorization(String val){
	if(val != null)
	    authorization = val;
    }
    public void setSnapAmount(String val){
	if(val != null)
	    snap_amount = getDouble(val);
    }
    public void setEbtAmount(String val){
	if(val != null)
	    ebt_amount = getDouble(val);
    }
    public void setDblAmount(String val){
	if(val != null)
	    dbl_amount = getDouble(val);
    }
    public void setDblMax(String val){
	if(val != null)
	    dbl_max = getDouble(val);
    }
    public void setUser_id(String val){
	if(val != null)
	    user_id = val;
    }    
    double getDouble(String val){
	double ret = 0;
	try{
	    ret = Double.parseDouble(val);
	}catch(Exception ex){
	    System.err.println(" invalid number "+val);
	    logger.error("invalid number "+val);
	}
	return ret;
    }
    public void setCancelled(String val){
	if(val != null && !val.isEmpty())
	    cancelled = "y";
    }
    public boolean isCancelled(){
	return !cancelled.isEmpty();
    }
    //
    public String getId(){
	return id;
    }
    public String getDate(){
	return date;
    }
    public String getCardNumber(){
		
	return card_number;
    }
    public String getAuthorization(){
	return authorization;
    }
    public String getSnapAmount(){
	return ""+snap_amount;
    }
    public double getSnapAmountDbl(){
	return snap_amount;
    }
    public String getEbtAmount(){
	return ""+ebt_amount;
    }
    public double getEbtAmountDbl(){
	return ebt_amount;
    }    
    public String getDblAmount(){
	return ""+dbl_amount;
    }
    public double getDblAmountDbl(){
	return dbl_amount;
    }    
    public String getDblMax(){
	return ""+dbl_max;
    }    
    
    public String getUser_id(){
	return user_id;
    }
    public String getCancelled(){
	return cancelled;
    }    
    public User getUser(){
	if(!user_id.equals("") && user == null){
	    User one = new User(debug, null, user_id);
	    String back = one.doSelect();
	    if(back.equals("")){
		user = one;
	    }
	}
	return user;

    }
    public String toString(){
	return id+" "+card_number+" "+authorization;
    }
    void doSplitSnapAmount(){
	if(dbl_max <= 0){
	    dbl_max = dbl_max_default;
	}
	if(snap_amount > 0){
	    if(snap_amount > 2 * dbl_max){ 
		dbl_amount = dbl_max;
	    }
	    else{
		dbl_amount = snap_amount / 2;
	    }
	    ebt_amount = snap_amount - dbl_amount;	    
	}
    }
    private String checkEntries(){
	String msg = "";
	if(card_number.isEmpty()){
	    msg = " card number is required ";
	}
	if(authorization.isEmpty()){
	    if(!msg.isEmpty()) msg += ", ";
	    msg += " authorization is required ";
	}
	if(snap_amount <= 0){
	    if(!msg.isEmpty()) msg += ", ";
	    msg += " snap amount value not valid ";
	}
	if(user_id.isEmpty()){
	    if(!msg.isEmpty()) msg += ", ";	    
	    msg += " user not set ";
	}
	return msg;
    }
    public String doSave(){

	Connection con = null;
	PreparedStatement pstmt = null, pstmt2=null;
	ResultSet rs = null;
	String msg = "";
	msg = checkEntries();
	if(!msg.isEmpty()){
	    return msg;
	}
	doSplitSnapAmount();
	date = Helper.getToday();
	String qq = "insert into snap_purchases values(0,now(),?,?,?, ?,?,?,?,null)";
	String qq2 = "select LAST_INSERT_ID() ";
	//
	logger.debug(qq);
	try{
	    con = Helper.getConnection();
	    if(con == null){
		msg = "Could not connect ";
		return msg;
	    }
	    pstmt = con.prepareStatement(qq);
	    pstmt.setString(1, card_number);
	    pstmt.setString(2, authorization);	    
	    pstmt.setDouble(3, snap_amount);
	    pstmt.setDouble(4, ebt_amount);
	    pstmt.setDouble(5, dbl_amount);
	    pstmt.setDouble(6, dbl_max);
	    pstmt.setString(7, user_id);
	    pstmt.executeUpdate();
	    qq = qq2;
	    if(debug){
		logger.debug(qq);
	    }
	    pstmt2 = con.prepareStatement(qq);
	    rs = pstmt2.executeQuery();
	    if(rs.next()){
		id  = rs.getString(1);
	    }
	}
	catch(Exception ex){
	    msg += ex+" : "+qq;
	    logger.error(msg);
	}
	finally{
	    Helper.databaseDisconnect(con, rs, pstmt, pstmt2);
	}
	return msg;
    }
    public String doUpdate(){

	Connection con = null;
	PreparedStatement pstmt = null, pstmt2=null;
	ResultSet rs = null;
	String msg = "";
	if(!msg.isEmpty()){
	    return msg;
	}
	doSplitSnapAmount();
	date = Helper.getToday();
	String qq = "update snap_purchases set card_number=?,authorization=?,snap_amount=?,ebt_amount=?,dbl_amount=?,dbl_max=?,user_id=?,cancelled=? where id=?";
	logger.debug(qq);
	try{
	    con = Helper.getConnection();
	    if(con == null){
		msg = "Could not connect ";
		return msg;
	    }
	    pstmt = con.prepareStatement(qq);
	    pstmt.setString(1, card_number);
	    pstmt.setString(2, authorization);	    
	    pstmt.setDouble(3, snap_amount);
	    pstmt.setDouble(4, ebt_amount);
	    pstmt.setDouble(5, dbl_amount);
	    pstmt.setDouble(6, dbl_max);
	    pstmt.setString(7, user_id);
	    if(isCancelled()){
		pstmt.setString(8, "y");
	    }
	    else{
		pstmt.setNull(8, Types.CHAR);
	    }
	    pstmt.setString(9,id);
	    pstmt.executeUpdate();
	}
	catch(Exception ex){
	    msg += ex+" : "+qq;
	    logger.error(msg);
	}
	finally{
	    Helper.databaseDisconnect(con, rs, pstmt);
	}
	return msg;
    }
    public String doCancel(){

	Connection con = null;
	PreparedStatement pstmt = null, pstmt2=null;
	ResultSet rs = null;
	String msg = "";
	date = Helper.getToday();
	String qq = "update snap_purchases set cancelled=? where id=? ";
	logger.debug(qq);
	try{
	    con = Helper.getConnection();
	    if(con == null){
		msg = "Could not connect ";
		return msg;
	    }
	    pstmt = con.prepareStatement(qq);
	    pstmt.setString(1, "y");
	    pstmt.setString(2, id);
	    pstmt.executeUpdate();
	}
	catch(Exception ex){
	    msg += ex+" : "+qq;
	    logger.error(msg);
	}
	finally{
	    Helper.databaseDisconnect(con, rs, pstmt);
	}
	return msg;
    }        
    String doSelect(){
		
	String qq = "select b.id, date_format(b.date,'%m/%d/%Y %H:%i'),b.card_number,b.authorization,b.snap_amount,b.ebt_amount,b.dbl_amount,b.dbl_max,b.user_id,b.cancelled from snap_purchases b where b.id=? ";
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String msg = "";
	// if(debug)
	logger.debug(qq);
	try{
	    con = Helper.getConnection();
	    if(con == null){
		msg = "Could not connect ";
		return msg;
	    }
	    pstmt = con.prepareStatement(qq);
	    pstmt.setString(1, id);
	    rs = pstmt.executeQuery();	
	    if(rs.next()){
		setValues(rs.getString(1),
			  rs.getString(2),
			  rs.getString(3),
			  rs.getString(4),
			  rs.getString(5),
			  rs.getString(6),
			  rs.getString(7),
			  rs.getString(8),
			  rs.getString(9),
			  rs.getString(10)
			  );
	    }
	}catch(Exception e){
	    msg += e+":"+qq;
	    logger.error(msg);
	}
	finally{
	    Helper.databaseDisconnect(con, pstmt, rs);
	}
	return msg;			
    }	

}





































