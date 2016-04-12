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

public class GiftList implements java.io.Serializable{

		static final long serialVersionUID = 35L;	
   
    boolean debug = false;
		static Logger logger = Logger.getLogger(GiftList.class);
		static SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");	
		String id="", which_date="g.date_time", limit= " limit 30 ";

		String date_from="", date_to="", sortBy="g.id DESC ";
		String buck_id="", pay_type="", amount="", check_no="", cancelled="";
		List<Gift> gifts = null;
	
		public GiftList(){
		}	
		public GiftList(boolean val){
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
		public void setCheck_no(String val){
				if(val != null)
						check_no = val;
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
				if(val != null)
						date_to = val;
		}
		public void setCancelled(String val){
				if(val != null && !val.equals("-1"))
						cancelled = val;
		}		
		public void setPay_type(String val){
				if(val != null && !val.equals("All"))
						pay_type = val;
		}	
		public void setNoLimit(){
				limit = "";
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
		public String getCheck_no(){
				return check_no;
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
		public String getPay_type(){
				if(pay_type.equals("")){
						return "All";
				}
				return pay_type ;
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
		public List<Gift> getGifts(){
				return gifts;
		}
		//
		String find(){

				String qq = "select g.id, g.amount,g.pay_type,g.check_no,g.user_id,date_format(g.date_time,'%m/%d/%Y %H:%i'),g.cancelled ";		
				String qf = " from gifts g ";
				String qw = "";
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String msg = "";
				if(!id.equals("")){
						if(!qw.equals("")) qw += " and ";
						qw += " g.id = ? ";
				}
				else {
						if(!buck_id.equals("")){
								qf += " left join gift_bucks gb on gb.gift_id=g.id ";
								if(!qw.equals("")) qw += " and ";				
								qw += " gb.buck_id = ? ";				
						}
						if(cancelled.equals("y")){
								if(!qw.equals("")) qw += " and ";					
								qw += " g.cancelled = 'y' ";
						}
						else if(cancelled.equals("n")){
								if(!qw.equals("")) qw += " and ";					
								qw += " g.cancelled is null ";
						}			
						if(!check_no.equals("")){
								if(!qw.equals("")) qw += " and ";
								qw += " g.check_no = ? ";
						}
						if(!amount.equals("")){
								if(!qw.equals("")) qw += " and ";
								qw += " g.amount = ? ";
						}
						if(!pay_type.equals("")){
								if(!qw.equals("")) qw += " and ";
								qw += " g.pay_type = ? ";
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
				qq += limit;		
				logger.debug(qq);
				try{
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
						int jj=1;

						if(!id.equals("")){
								pstmt.setString(jj++,id);
						}
						else{
								if(!buck_id.equals("")){
										pstmt.setString(jj++,buck_id);
								}				
								if(!check_no.equals("")){
										pstmt.setString(jj++,check_no);					
								}
								if(!amount.equals("")){
										pstmt.setString(jj++,amount);
								}
								if(!pay_type.equals("")){
										pstmt.setString(jj++,pay_type);
								}				
								if(!which_date.equals("")){
										if(!date_from.equals("")){
												pstmt.setDate(jj++, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										}
										if(!date_to.equals("")){
												pstmt.setDate(jj++, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										}
								}
						}
						gifts = new ArrayList<Gift>();			
						rs = pstmt.executeQuery();
						while(rs.next()){
								Gift one = new Gift(debug,
																		rs.getString(1),
																		rs.getString(2),
																		rs.getString(3),
																		rs.getString(4),
																		rs.getString(5),
																		rs.getString(6),
																		rs.getString(7)
																		);
								gifts.add(one);
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





































