/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 */
package bucks;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.*;
import javax.sql.*;
import javax.naming.directory.*;
import org.apache.log4j.Logger;

public class Ebt implements java.io.Serializable{

		static final long serialVersionUID = 11L;	
   
    boolean debug = false;
		static Logger logger = Logger.getLogger(Ebt.class);
		static SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		String amountStr="", id="", buck_type_id="", cancelled="";
		int amount = 0, dmb_amount=0, donor_max=0, paid_amount=0, 
				donated_amount=0, 
				total=0;
		int buck_value = 0; // we get from conf from first buck
		String approve ="", card_last_4="",user_id="", date_time="";
		String buck_id = ""; // adding one buck at a time
		boolean needMoreIssue = false;
		BuckConf conf = null;
		Type buck_type = null;
		List<Buck> bucks = null;
		User user = null;
		public Ebt(){
		}	
		public Ebt(boolean val){
				debug = val;
		}
		public Ebt(boolean val, String val2){
				debug = val;
				setId(val2);
		}	
		public Ebt(boolean deb,
							 String val,
							 String val2,
							 String val3,
							 String val4,
							 String val5,
							 String val6,
							 String val7,
							 String val8
							 ){
				setValues( val,
									 val2,
									 val3,
									 val4,
									 val5,
									 val6,
									 val7,
									 val8
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
									 String val8
									 ){
				setId(val);
				setAmount(val2);
				setApprove(val3);
				setCard_last_4(val4);
				setUser_id(val5);
				setDate_time(val6);
				setDmb_amount(val7);
				setCancelled(val8);
				getBucks();
				if((bucks == null || bucks.size() == 0) && amount > 0){
						needMoreIssue = true;
				}
				getBucksTotal();
		}

		public void setId(String val){
				if(val != null)
						id = val;
		}
		public void setAmount(String val){
				if(val != null && !val.equals("")){
						amountStr = val;
						try{
								amount = Integer.parseInt(val);
						}catch(Exception ex){
								System.err.println(ex);
						}
						// setDmb_amount();
				}
		}
		void setDmb_amount(){
				getLatestConf();
				if(conf != null){
						dmb_amount = conf.getDonor_max_value_int();
						if(dmb_amount > amount){
								dmb_amount = amount;
						}
				}
		}
		private void getLatestConf(){
				BuckConfList bcl = new BuckConfList(debug);
				bcl.setType_id("1"); // MB
				bcl.setExcludeOldYears();
				String back = bcl.find();
				if(back.equals("")){
						List<BuckConf> ones = bcl.getBuckConfs();
						if(ones != null && ones.size() > 0){
								conf = ones.get(0);
						}
				}
		}
		public void setDmb_amount(String val){
				if(val != null && !val.equals("")){
						try{
								dmb_amount = Integer.parseInt(val);
						}catch(Exception ex){
								System.err.println(ex);
						}
				}
		}
		public void setApprove(String val){
				if(val != null)
						approve = val;
		}	
		public void setCard_last_4(String val){
				if(val != null)
						card_last_4 = val;
		}
		public void setDate_time(String val){
				if(val != null)
						date_time = val;
		}	
		public void setUser_id(String val){
				if(val != null)
						user_id = val;
		}
		public void setBuck_id(String val){
				if(val != null){
						buck_id = val;
						setConf();
				}
		}
		public void setBuck_type_id(String val){
				if(val != null)
						buck_type_id = val;
		}
		public void setCancelled(String val){
				if(val != null)
						cancelled = val;
		}	
		//
		public String getId(){
				return id;
		}
		public String getAmount(){
				return amountStr;
		}
		public String getDmb_amount(){
				return ""+dmb_amount;
		}	
		public String getApprove(){
				return approve;
		}
		public String getCard_last_4(){
		
				return card_last_4;
		}
		public String getPaid_amount(){
				return ""+paid_amount;
		}	

		public String getDate_time(){
		
				return date_time;
		}
		public String getUser_id(){
		
				return user_id;
		}
		public String getBuck_type_id(){
		
				return buck_type_id;
		}
		public String getCancelled(){
		
				return cancelled;
		}
		public boolean isCancelled(){
				return !cancelled.equals("");
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
		public Type getBuck_type(){
				if(!buck_type_id.equals("") && buck_type == null){
						Type one = new Type(debug, buck_type_id,null, "buck_types");
						String back = one.doSelect();
						if(back.equals("")){
								buck_type = one;
						}
				}
				return buck_type;
		}	
		public String toString(){
				return "$"+amountStr+" "+approve+" "+card_last_4+" "+date_time;
		}
		public String getDonated_amount(){
				return ""+donated_amount;
		}
		public String getTotal(){
				return ""+total;
		}
		public String getBucksTotal(){
				if(total == 0){
						getBucks();
						if(bucks != null){
								for(Buck one:bucks){			
										int val = one.getValue_int();
										total += val;
										if(one.getFund_type().equals("dmb")){
												donated_amount += val;
										}
										else{
												paid_amount += val;
										}
								}
						}
				}
				return ""+total;
		}
		public String getBalance(){
				int balance = (amount+dmb_amount) - paid_amount - donated_amount;		
				return ""+balance;
		}
		public boolean hasBalance(){
				int balance = (amount+dmb_amount) - paid_amount - donated_amount;
				return balance > 0;
		}
		//	
		public boolean needMoreIssue(){
				return (amount + dmb_amount)  >  total;
		}
		//
		private void setConf(){
				setConf(buck_id);
		}
		//	
		private void setConf(String b_id){
				//
				Batch batch = null;
				BatchList bl = new BatchList(debug);
				bl.setSeq_id(b_id);
				String msg = bl.find();
				if(msg.equals("")){
						List<Batch> batches = bl.getBatches();
						if(batches != null && batches.size() > 0){
								Batch one = batches.get(0);
								if(one != null){
										batch = one;
								}
						}
				}
				if(batch != null){
						conf = batch.getConf();
						updateConf();
				}
		}
		private void updateConf(){
				if(conf != null){
						buck_value = conf.getValue_int();
						buck_type_id = conf.getType_id();
				}
		}
		public String handleAddingBuck(){
				boolean added = false;
				String msg = "";
				getBucks();
				getBucksTotal();
				if(bucks == null){
						bucks = new ArrayList<Buck>();
				}
				Buck buck = new Buck(debug, buck_id);
				msg = buck.doSelect();
				if(!msg.equals("")){
						return msg;
				}
				if(thisBuckIsInGifts()){
						msg =" This buck is already used in GC ";
						return msg;
				}

				if(!buck_type_id.equals("1")){
						msg =" GC can not be used as Market bucks ";
						return msg;
				}
				if(amount > paid_amount){
						buck.setFund_type("ebt");
						//
						// market bucks expire on the Dec 1 of the issued year
						//
						buck.setExpire_date("12/01/"+Helper.getCurrentYear());
						msg = buck.doUpdate();
						if(msg.equals("")){
								if(!bucks.contains(buck)){
										bucks.add(0, buck); // make it first
										added = true;
										msg = addNewBuckToEbt();
										if(!msg.equals("")){
												bucks.remove(0);
												msg = "Error: The buck is already in the system";
										}
										else{
												paid_amount += buck.getValue_int();
												total += buck.getValue_int();
										}
								}
								else{
										// adding the same buck to the pack
										// we do not show error
								}
						}
				}
				else if(dmb_amount > donated_amount){
						buck.setFund_type("dmb");
						buck.setExpire_date("12/01/"+Helper.getCurrentYear());
						msg = buck.doUpdate();
						if(msg.equals("")){
								if(!bucks.contains(buck)){				
										bucks.add(0, buck); // make it first
										added = true;
										msg = addNewBuckToEbt();
										if(!msg.equals("")){
												bucks.remove(0);
												msg = "Error: The buck is already in the system";
										}
										else{
												donated_amount += buck.getValue_int();
												total += buck.getValue_int();
										}
								}
								else{
										// ignore this as it is already in the pack
										// we do not show error 
								}
						}
				}
				else if(dmb_amount < donated_amount){
						msg = " Count exceeded "; // should not happen
				}
				if(!msg.equals("")){
						return msg;
				}
				//
				// find how many bucks we have so far
				//
				return msg;
		}
		/**
		 * check if this buck was used in the gift bucks list
		 */
		private boolean thisBuckIsInGifts(){
				boolean ret = false;
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String msg = "";
				String qq = " select count(*) from gift_bucks where buck_id=? ";
				//
				logger.debug(qq);
				try{
						con = Helper.getConnection();
						if(con == null){
								return ret;
						}
						pstmt = con.prepareStatement(qq);
						pstmt.setString(1, buck_id);
						rs = pstmt.executeQuery();
						if(rs.next()){
								if(rs.getInt(1) > 0) ret = true;
						}
				}
				catch(Exception ex){
						msg += ex+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, pstmt, rs);
				}
				return ret;
		
		}
		int findPaidCountSoFar(){
				int ret = 0;
				if(bucks != null){
						for(Buck one:bucks){
								if(one.getFund_type().equals("ebt")) ret++;
						}
				}
				return ret;
		}
		int findDonorCountSoFar(){
				int ret = 0;
				if(bucks != null){
						for(Buck one:bucks){
								if(one.getFund_type().equals("dmb")) ret++;
						}
				}
				return ret;
		}
		String addNewBuckToEbt(){
				String msg="";
				if(buck_id.equals("") || id.equals("")){
						msg = "No buck number or ebt id entered";
						return msg;
				}
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String qq = "insert into ebt_bucks values(?,?)";
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
						pstmt.setString(2, buck_id);
						pstmt.executeUpdate();
				}
				catch(Exception ex){
						msg += ex+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, pstmt, rs);
				}
				return msg;	
				
		}
		public List<Buck> getBucks(){
				//		
				if(!id.equals("") && bucks == null){
						BuckList bl = new BuckList(debug,id,null,null,null,null); // ebt.id
						String back = bl.find();
						if(back.equals("")){
								bucks = bl.getBucks();
								if(bucks.size() > 0){
										Buck one = bucks.get(0);
										conf = one.getConf();
										updateConf();
								}
						}
						else{
								logger.error(back);
						}
				}
				return bucks;
		}
		public void setBucks(List<Buck> vals){
				if(vals != null){
						bucks = vals;
				}
		}

		public String doSave(){

				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				setDmb_amount();		
				String msg = "";
				if(amount % 3 > 0){
						msg = "Requested amount is not divisible by 3";
						return msg;
				}
				date_time = Helper.getToday();
				String qq = "insert into ebts values(0,?,?,?,?,now(),?,null)";// cancelled = null
				logger.debug(qq);
				try{
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
						fillData(pstmt, 1);
						pstmt.executeUpdate();
						qq = "select LAST_INSERT_ID() ";
						logger.debug(qq);
						//}
						pstmt = con.prepareStatement(qq);
						rs = pstmt.executeQuery();
						if(rs.next()){
								id = rs.getString(1);
						}
						needMoreIssue = true;
				}
				catch(Exception ex){
						msg += ex+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, pstmt, rs);
				}
				return msg;
		}
		public String doUpdate(){

				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String msg = "";
				if(amount % 3 > 0){
						msg = "Requested amount is not divisible by 3";
						return msg;
				}
				setDmb_amount();				
				date_time = Helper.getToday();
				String qq = "update ebts set amount=?,approve=?,card_last_4=?,user_id=?,dmb_amount=? where id=?";
				//	if(debug)
				logger.debug(qq);
				try{
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
						fillData(pstmt, 1);
						pstmt.setString(6, id);
						pstmt.executeUpdate();
				}
				catch(Exception ex){
						msg += ex+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, pstmt, rs);
				}
				if(msg.equals("")){
						msg = checkForUpdatedAmount();
				}
				return msg;
		}

		String fillData(PreparedStatement pstmt, int c){
				String msg="";
				try{
						// all these are required
						pstmt.setString(c++, amountStr);
						if(!approve.equals(""))
								pstmt.setString(c++, approve);
						else
								pstmt.setNull(c++, Types.VARCHAR);
						if(!card_last_4.equals(""))
								pstmt.setString(c++, card_last_4);
						else
								pstmt.setNull(c++, Types.VARCHAR);
						if(!user_id.equals(""))
								pstmt.setString(c++, user_id);
						else
								pstmt.setNull(c++, Types.VARCHAR);
						pstmt.setString(c++, ""+dmb_amount);

				}
				catch(Exception ex){
						msg += ex;
						logger.error(msg);
				}
		
				return msg;					
		}
		//
		String doSelect(){

				String qq = "select e.id, e.amount ,e.approve,e.card_last_4,e.user_id,date_format(e.date_time,'%m/%d/%Y %H:%i'),e.dmb_amount,e.cancelled from ebts e where e.id=? ";
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
													rs.getString(8)
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
		/**
		 * after an update we check the total paid amount is less or greater
		 * than the requested amount
		 */
		String checkForUpdatedAmount(){
				String msg = "";		
				getBucksTotal();
				if(paid_amount <= amount){
						return msg;
				}
				// the amount is greater then
				// we need to delete the bucks from this ebt
				if(id.equals("")){
						msg = "No ebt id entered";
						return msg;
				}
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String qq = "update bucks b, ebt_bucks e set b.fund_type=null where b.id=e.buck_id and e.ebt_id=? ";
				String qq2 = "delete from ebt_bucks where ebt_id=?";
				//
				logger.debug(qq);
				try{
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
			
						pstmt.setString(1, id);
						pstmt.executeUpdate();
						qq = qq2;
						logger.debug(qq);			
						pstmt = con.prepareStatement(qq);
						pstmt.setString(1, id);
						pstmt.executeUpdate();			
				}
				catch(Exception ex){
						msg += ex+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, pstmt, rs);
				}
				return msg;				

		}
		/**
		 * if the customer changed his/her mind and wants to cancel the trans
		 */
		String doCancel(){
				String msg = "";		
				if(id.equals("")){
						msg = "Ebt id not set ";
						return msg;
				}
				if(isAnyRedeemed()){
						msg = "Some of these MB's are already redeemed and can not be voided";
						return msg;
				}
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String qq = "update bucks b, ebt_bucks e set b.voided='y' where b.id=e.buck_id and e.ebt_id=? ";
				String qq2 = "update ebts set cancelled='y' where id=?";
				//
				logger.debug(qq);

				try{
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
			
						pstmt.setString(1, id);
						pstmt.executeUpdate();
						qq = qq2;
						logger.debug(qq);			
						pstmt = con.prepareStatement(qq);
						pstmt.setString(1, id);
						pstmt.executeUpdate();

				}
				catch(Exception ex){
						msg += ex+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, pstmt, rs);
				}
				return msg;				

		}
		private boolean isAnyRedeemed(){
				boolean ret = false;
				String msg = "";
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String qq = "select count(*) from ebt_bucks e,redeem_bucks r where e.buck_id=r.buck_id and e.ebt_id=? ";
				//
				logger.debug(qq);
				try{
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								logger.error(qq);
								return ret;
						}
						pstmt = con.prepareStatement(qq);
						pstmt.setString(1, id);
						rs = pstmt.executeQuery();
						if(rs.next()){
								if(rs.getInt(1) > 0){
										ret = true;
								}
						}
				}
				catch(Exception ex){
						msg += ex+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, pstmt, rs);
				}
				return ret;
		}
}





































