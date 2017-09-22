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

public class EbtList implements java.io.Serializable{

		static final long serialVersionUID = 33L;	
   
    boolean debug = false;
		static Logger logger = Logger.getLogger(EbtList.class);
		static SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");	
		String id="", which_date="e.date_time", limit=" limit 30" ;
		String card_last_4="", approve="", amount="", buck_id="";
		String date_from="", date_to="", sortBy="e.id DESC ";
		String cancelled = ""; // for all
		List<Ebt> ebts = null;
	
		public EbtList(){
		}	
		public EbtList(boolean val){
				debug = val;
		}
		public void setId(String val){
				if(val != null)
						id = val;
		}
		public void setBuck_id(String val){
				if(val != null)
						buck_id = val;
		}	
		public void setCard_last_4(String val){
				if(val != null)
						card_last_4 = val;
		}
		public void setApprove(String val){
				if(val != null)
						approve = val;
		}	
		public void setAmount(String val){
				if(val != null)
						amount = val;
		}
		public void setCancelled(String val){
				if(val != null && !val.equals("-1"))
						cancelled = val;
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
		public void setSortBy(String val){
				if(val != null &&  !val.equals("-1"))
						sortBy = val;
		}
		public void setNoLimit(){
				limit = "";
		}
		//
		public String getId(){
				return id;
		}
		public String getBuck_id(){
				return buck_id;
		}	
		public String getCard_last_4(){
				return card_last_4;
		}
		public String getApprove(){
				return approve;
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
				return cancelled;
		}	
		public List<Ebt> getEbts(){
				return ebts;
		}
		//
		String find(){

				String qq = "select e.id, e.amount,e.approve,e.card_last_4,e.user_id,date_format(e.date_time,'%m/%d/%Y %H:%i'),e.dmb_amount,e.cancelled,e.ebt_donor_max,e.ebt_buck_value ";		
				String qf = " from ebts e ";
				String qw = "";
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String msg = "";
				if(!id.equals("")){
						if(!qw.equals("")) qw += " and ";
						qw += " e.id = ? ";
				}
				else {
						if(!buck_id.equals("")){
								qf += " left join ebt_bucks eb on eb.ebt_id=e.id ";
								if(!qw.equals("")) qw += " and ";				
								qw += " eb.buck_id = ? ";				
						}
						if(cancelled.equals("y")){
								if(!qw.equals("")) qw += " and ";					
								qw += " e.cancelled = 'y' ";
						}
						else if(cancelled.equals("n")){
								if(!qw.equals("")) qw += " and ";					
								qw += " e.cancelled is null ";
						}
						if(!card_last_4.equals("")){
								if(!qw.equals("")) qw += " and ";				
								qw += " e.card_last_4 = ? ";
						}
						if(!approve.equals("")){
								if(!qw.equals("")) qw += " and ";
								qw += " e.approve = ? ";
						}
						if(!amount.equals("")){
								if(!qw.equals("")) qw += " and ";
								qw += " e.amount = ? ";
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
				//
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
								if(!card_last_4.equals("")){
										pstmt.setString(jj++,card_last_4);				
								}
								if(!approve.equals("")){
										pstmt.setString(jj++,approve);					
								}
								if(!amount.equals("")){
										pstmt.setString(jj++,amount);
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
						ebts = new ArrayList<Ebt>();			
						rs = pstmt.executeQuery();
						while(rs.next()){
								Ebt one = new Ebt(debug,
																	rs.getString(1),
																	rs.getInt(2),
																	rs.getString(3),
																	rs.getString(4),
																	rs.getString(5),
																	rs.getString(6),
																	rs.getInt(7),
																	rs.getString(8),
																	rs.getInt(9),
																	rs.getInt(10)
																	);
								ebts.add(one);
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





































