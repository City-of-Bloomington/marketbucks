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
import javax.sql.*;
import org.apache.log4j.Logger;


public class Report{
	
		static Logger logger = Logger.getLogger(Report.class);
		static final long serialVersionUID = 70L;
		static SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		NumberFormat currencyFormatter = 
        NumberFormat.getCurrencyInstance();	
		String year = "",date_from="",date_to="", type="issueMB";
		String title = "", which_date="",by="", day="", prev_year="", next_year="";
		boolean debug = false;
		boolean
				distributeMB=true,
				distributeGC=false,
				issued = false,
				unissued = false,
				redeem = false,
				participate=false,
				inventory=false,
				redeemOld=false;
		List<List<ReportRow>> all = new ArrayList<List<ReportRow>>();
		Hashtable<String, ReportRow> all2 = new Hashtable<String, ReportRow>(4);
		DecimalFormat decFormat = new DecimalFormat("###,###.##");
		List<ReportRow> rows = null; 
		ReportRow columnTitle = null;
		//
		int totalIndex = 2; // DB index for row with 2 items
		public Report(){

		}
		public Report(boolean deb){
				debug = deb;
		}
		public void setYear(String val){
				if(val != null && !val.equals("-1"))
						year = val;
		}
		public void setPrev_year(String val){
				if(val != null && !val.equals("-1"))
						prev_year = val;
		}
		public void setNext_year(String val){
				if(val != null && !val.equals("-1"))
						next_year = val;
		}	
		public void setDay(String val){
				if(val != null && !val.equals(""))
						day = val;
		}	
		public void setDate_from(String val){
				if(val != null)
						date_from = val;
		}	
		public void setDate_to(String val){
				if(val != null)
						date_to = val;
		}
		public void setBy(String val){
				if(val != null)
						by = val;
		}
		public void setDistributeMB(Boolean val){
				distributeMB = val;
		}
		public void setDistributeGC(Boolean val){
				distributeGC = val;
		}	
		public void setIssued(Boolean val){
				issued = val;
		}
		public void setUnissued(Boolean val){
				unissued = val;
		}
		public void setRedeem(Boolean val){
				redeem = val;
		}
		public void setParticipate(Boolean val){
				participate = val;
		}
		public void setInventory(Boolean val){
				inventory = val;
		}
		public void setRedeemOld(Boolean val){
				redeemOld = val;
		}	
		//
		// getters
		//
		public String getYear(){
				return year;
		}
		public String getPrev_year(){
				return prev_year;
		}
		public String getNext_year(){
				return next_year;
		}	
		public String getDay(){
				return day;
		}	
		public String getDate_from(){
				return date_from ;
		}	
		public String getDate_to(){
				return date_to ;
		}
		public String getBy(){
				return by ;
		}
		public String getType(){
				return type;
		}
		public boolean getDistributeMB(){
				return distributeMB;
		}
		public boolean getDistributeGC(){
				return distributeGC;
		}	
		public boolean getIssued(){
				return issued;
		}
		public boolean getUnissued(){
				return unissued;
		}
		public boolean getRedeem(){
				return redeem;
		}
		public boolean getParticipate(){
				return participate;
		}
		public boolean getInventory(){
				return inventory;
		}
		public boolean getRedeemOld(){
				return redeemOld;
		}	
		public String getTitle(){
				return title;
		}	
		public List<ReportRow> getRows(){
				return rows;
		}
		public List<List<ReportRow>> getAll(){
				return all;
		}
		public List<ReportRow> getInventoryList(){
				List<ReportRow> list = new ArrayList<ReportRow>();
				if(all2 != null){
						for(String key:all2.keySet()){
								ReportRow one = all2.get(key);
								list.add(one);
						}
				}
				return list;
		}
		public ReportRow getColumnTitle(){
				return columnTitle;
		}
		/**
	   // here are what we need to do
	   //
	   MB EBT amount distributed on Saturday and Tuesday separately and combined weekly, monthly, annually.

	   MB Double amount distributed on Saturday and Tuesday separately and combined weekly, monthly, annually.
	   
	   MB amount redeemed.

	   GC amount distributed and amount redeemed.

	   Number of different households that participated in MB annually.

	   Average number of times a household participated MB annually.

	   Total number of transactions per month and per year.

	   Average amount of MB transaction annually.

	   Ideally it would be great to be able to put this information from previous years into this application so the report can track the change over time.


		*/
		public String find(){
				String msg = "";
				if(!day.equals("")){
						date_from = day;
						date_to = Helper.getNextDay(day);
				}
				if(distributeMB){
						msg += distributeMB();
				}
				if(distributeGC){
						msg +=  distributeGC();
				}
				if(redeem){
						msg +=  redeems();
				}
				if(redeemOld){
						msg +=  redeemOld();
				}		
				if(participate){
						msg += participateData();
				}
				if(inventory){
						msg += inventoryStats();
				}
				if(issued){
						msg +=  issued();
				}
				if(unissued){
						msg +=  unissued();
				}
				return msg;
		}
		void setTitle(){
				if(!day.equals("")){
						title +=" "+day;
				}
				else if(!year.equals("")){
						title +=" "+year;
				}
				else {
						if(!date_from.equals("")){
								title += " "+date_from;
						}
						if(!date_to.equals("")){
								if(!date_from.equals(date_to)){
										title += " - "+date_to;
								}
						}
				}
		}
		public String distributeMB(){
		
				Connection con = null;
				PreparedStatement pstmt = null;
				PreparedStatement pstmt2 = null;
				PreparedStatement pstmt3 = null;
				PreparedStatement pstmt4 = null;		
				ResultSet rs = null;

				String msg = "";
				String which_date = "";
				String qq = "", qq2="", qq3="", qq4="", qw="", qg="";
				which_date="e.date_time ";
				title = "MB Distribution ";
				setTitle();
				rows = new ArrayList<ReportRow>();		
				ReportRow one = new ReportRow(debug, 2);
				one.setRow("Title", title);
				rows.add(one);
				one = new ReportRow(debug, 2);
				one.setRow("Fund Type","Amount");
				rows.add(one);
				//
				// MB
				//
				qq = " select b.fund_type type, sum(b.value) amount from bucks b left join ebt_bucks eb on b.id=eb.buck_id left join ebts e on e.id=eb.ebt_id where b.voided is null ";
		
				qg = " group by type having amount > 0 ";
				qq2 = " select count(*) from ebts e where e.cancelled is null ";
		
				if(!year.equals("")){
						qw += " and ";
						qw += " year("+which_date+") = ? ";
				}
				else {
						if(!date_from.equals("")){
								qw += " and ";
								qw += which_date+" >= ? ";
						}
						if(!date_to.equals("")){
								qw += " and ";
								qw += which_date+" <= ? ";
						}
				}
				if(!qw.equals("")){
						qq += qw;
						qq2 += qw;
				}
				qq3 = qq;
				qq4 = qq2;
				qq3 += " and ";
				qq4 += " and ";
				qq3 += " dayofweek("+which_date+") = 7 "; //(sunday=1) saturday=7
				qq4 += " dayofweek("+which_date+") = 7 "; 
				qq += qg;
				qq3 += qg;
				logger.debug(qq);
				logger.debug(qq2);
				logger.debug(qq3);
				logger.debug(qq4);		
				try{
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
						pstmt2 = con.prepareStatement(qq2);
						pstmt3 = con.prepareStatement(qq3);
						pstmt4 = con.prepareStatement(qq4);			
						int jj=1;
						if(!year.equals("")){
								pstmt.setString(jj, year);
								pstmt2.setString(jj, year);
								pstmt3.setString(jj, year);
								pstmt4.setString(jj, year);				
								jj++;
						}
						else {
								if(!date_from.equals("")){
										pstmt.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										pstmt2.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										pstmt3.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										pstmt4.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));					
										jj++;
								}
								if(!date_to.equals("")){
										pstmt.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										pstmt2.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										pstmt3.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										pstmt4.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										jj++;
								}
						}
						rs = pstmt.executeQuery();
						int total = 0, count=0;
						while(rs.next()){
								String str = rs.getString(1);
								if(str == null) str = "Unknown";
								one = new ReportRow(debug, 2);
								one.setRow(str.toUpperCase(),
													 "$"+rs.getString(2)+".00"
													 );
								total += rs.getInt(2);
								rows.add(one);
						}
						one = new ReportRow(debug, 2);			
						one.setRow("Total","$"+total+".00");
						rows.add(one);
						if(total > 0){
								count = total/3;
								one = new ReportRow(debug, 2);			
								one.setRow("Count",""+count);
								rows.add(one);				
						}
						rs = pstmt2.executeQuery();
						if(rs.next()){
								count = rs.getInt(1);
						}
						one = new ReportRow(debug, 2);			
						one.setRow("Transactions",""+count);
						rows.add(one);
						if(total > 0 && count > 0){
								double average = (total +0.0)/count;
								one = new ReportRow(debug, 2);
								one.setRow("Transaction Average",				
													 currencyFormatter.format(average));
								rows.add(one);					
						}
						all.add(rows);
						title = "Saturdays MB Distribution ";
						setTitle();
						rows = new ArrayList<ReportRow>();		
						one = new ReportRow(debug, 2);
						one.setRow("Title", title);
						rows.add(one);
						one = new ReportRow(debug, 2);
						one.setRow("Fund Type","Amount");
						rows.add(one);
						total = 0; count=0;
						rs = pstmt3.executeQuery();
						while(rs.next()){
								String str = rs.getString(1);
								one = new ReportRow(debug, 2);
								one.setRow(str.toUpperCase(),
													 "$"+rs.getString(2)+".00"
													 );
								total += rs.getInt(2);
								rows.add(one);
						}
						one = new ReportRow(debug, 2);			
						one.setRow("Total","$"+total+".00");
						rows.add(one);
						if(total > 0){
								count = total/3;
								one = new ReportRow(debug, 2);			
								one.setRow("Count",""+count);
								rows.add(one);				
						}
						rs = pstmt4.executeQuery();
						if(rs.next()){
								count = rs.getInt(1);
						}
						one = new ReportRow(debug, 2);			
						one.setRow("Transactions",""+count);
						rows.add(one);
						if(total > 0 && count > 0){
								double average = (total +0.0)/count;
								one = new ReportRow(debug, 2);
								one.setRow("Transaction Average",				
													 currencyFormatter.format(average));
								rows.add(one);					
						}			
						all.add(rows);
			
				}catch(Exception e){
						msg += e+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, rs, pstmt, pstmt2, pstmt3, pstmt4);
				}		
				return msg;
		}
	
		public String distributeGC(){
		
				Connection con = null;
				PreparedStatement pstmt = null;
				PreparedStatement pstmt2 = null;
				PreparedStatement pstmt3 = null;		
				ResultSet rs = null;

				String msg = "";
				String qq = "", qw="", qw3="", qg="", qq2="", qq3="";
				String which_date = "g.date_time ";			  
				title = "GC Distribution ";
				setTitle();
				rows = new ArrayList<ReportRow>();
				ReportRow one = new ReportRow(debug, 2);
				one.setRow("Title", title);
				rows.add(one);
				one = new ReportRow(debug, 2);
				one.setRow("Payment Type","Amount");
				rows.add(one);

				qq = " select g.pay_type type,sum(g.amount) amount from gifts g ";
				qg = " group by type having amount > 0 ";
				qw = " where g.cancelled is null ";
				qq2 = " select count(*) from gifts g ";
				qq3 = " select count(*) from gifts g, gift_bucks gb ";
				qw3 = " where g.id=gb.gift_id and g.cancelled is null ";
				//
				if(!year.equals("")){
						qw += " and ";
						qw3 += " and ";
						qw += " year("+which_date+") = ? ";
						qw3 += " year("+which_date+") = ? ";			
				}
				else {
						if(!date_from.equals("")){
								qw += " and ";
								qw3 += " and ";					
								qw += which_date+" >= ? ";
								qw3 += which_date+" >= ? ";				
						}
						if(!date_to.equals("")){
								qw += " and ";
								qw3 += " and ";
								qw += which_date+" <= ? ";
								qw3 += which_date+" <= ? ";				
						}
				}
				if(!qw.equals("")){
						qq += qw;
						qq2 += qw;
						qq3 += qw3;
				}
				qq += qg;
				logger.debug(qq);
				logger.debug(qq2);		
				try{
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
						qq = qq2;
						pstmt2 = con.prepareStatement(qq2);
						qq = qq3;
						pstmt3 = con.prepareStatement(qq3);
						int jj=1;
						if(!year.equals("")){
								pstmt.setString(jj, year);
								pstmt2.setString(jj, year);
								pstmt3.setString(jj, year);				
								jj++;
						}
						else {
								if(!date_from.equals("")){
										pstmt.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										pstmt2.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										pstmt3.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));					
										jj++;
								}
								if(!date_to.equals("")){
										pstmt.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										pstmt2.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										pstmt3.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));					
										jj++;
								}
						}
						int total = 0, count = 0;
						rs = pstmt.executeQuery();
						while(rs.next()){
								String str = rs.getString(1);
								if(str == null) str = "Unknown";
								one = new ReportRow(debug, 2);
								one.setRow(str,
													 "$"+rs.getString(2)+".00"
													 );
								total += rs.getInt(2);
								rows.add(one);
						}
						one = new ReportRow(debug, 2);
						one.setRow("Total","$"+total+".00");
						rows.add(one);			
						rs = pstmt3.executeQuery();
						if(rs.next()){
								count = rs.getInt(1);
								if(count > 0){
										one = new ReportRow(debug, 2);
										one.setRow("Count",""+count);
										rows.add(one);			
								}
						}			
						rs = pstmt2.executeQuery();
						if(rs.next()){
								count = rs.getInt(1);
						}
						one = new ReportRow(debug, 2);
						one.setRow("Transactions",""+count);
						rows.add(one);
						if(total > 0 && count > 0){
								double average = (total +0.0)/count;
								one = new ReportRow(debug, 2);
								one.setRow("Transaction Average",				
													 currencyFormatter.format(average));
								rows.add(one);					
						}			
						all.add(rows);
				}catch(Exception e){
						msg += e+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, rs, pstmt, pstmt2, pstmt3);
				}		
				return msg;
		}
		public String redeems(){
		
				Connection con = null;
				PreparedStatement pstmt = null;
				PreparedStatement pstmt2 = null;
				PreparedStatement pstmt3 = null;		
				ResultSet rs = null;

				String msg = "";
				String which_date = "";
				String qq = "", qw="", qg="", qq2="", qq3="";
				which_date="r.date_time ";
				//
				qq = " select concat_ws(' ',v.lname,v.fname) name, sum(b.value) amount from bucks b left join redeem_bucks rb on b.id=rb.buck_id left join redeems r on r.id=rb.redeem_id left join vendors v on v.id=r.vendor_id ";
				qg = " group by name having amount > 0 ";
				qq2 = " select count(*) from redeems r ";

				qq3 = " select b.value name, count(*) amount from bucks b left join redeem_bucks rb on b.id=rb.buck_id left join redeems r on r.id=rb.redeem_id ";
		
				if(!year.equals("")){
						if(!qw.equals("")){
								qw += " and ";
						}
						else{
								qw  = " where ";
						}
						qw += " year("+which_date+") = ? ";
				}
				else {
						if(!date_from.equals("")){
								if(!qw.equals("")){
										qw += " and ";
								}
								else{
										qw = " where ";
								}
								qw += which_date+" >= ? ";
						}
						if(!date_to.equals("")){
								if(!qw.equals("")){
										qw += " and ";
								}
								else{
										qw = " where ";
								}
								qw += which_date+" <= ? ";
						}
				}
				if(!qw.equals("")){
						qq += qw;
						qq2 += qw;
						qq3 += qw;
				}
				qq += qg;
				qq3 += qg;
				logger.debug(qq);
				logger.debug(qq2);
				logger.debug(qq3);		
				try{
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
						qq = qq2;
						pstmt2 = con.prepareStatement(qq2);
						qq = qq3;
						pstmt3 = con.prepareStatement(qq3);			
						int jj=1;
						if(!year.equals("")){
								pstmt.setString(jj, year);
								pstmt2.setString(jj, year);
								pstmt3.setString(jj, year);				
								jj++;
						}
						else {
								if(!date_from.equals("")){
										pstmt.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										pstmt2.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										pstmt3.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));					
										jj++;
								}
								if(!date_to.equals("")){
										pstmt.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										pstmt2.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										pstmt3.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));					
										jj++;
								}
						}

						title = "Redemptions classified by type ";
						setTitle();
						rows = new ArrayList<ReportRow>();
						ReportRow one = new ReportRow(debug, 2);
						one.setRow("Title", title);
						rows.add(one);			
						one = new ReportRow(debug, 3);
						one.setRow("Certificate Type","Count","Amount");
						rows.add(one);
						int total = 0, count = 0;
						rs = pstmt3.executeQuery();
						while(rs.next()){
								String str = "";
								one = new ReportRow(debug, 3);
								int val = rs.getInt(1);
								int cnt = rs.getInt(2);
								count += cnt;
								if(val == 3){
										str = "MB $3";
								}
								else if(val == 5){
										str = "GC $5";
								}
								else{
										str = "GC $20";
								}
								val = cnt*val;				
								one.setRow(str,
													 ""+cnt,
													 "$"+val+".00"
													 );
								total += val;
								rows.add(one);
						}
						one = new ReportRow(debug, 3);			
						one.setRow("Total",""+count, "$"+total+".00");
						rows.add(one);
						all.add(rows);
						//
						title = "Redemptions ";
						setTitle();
						rows = new ArrayList<ReportRow>();
						one = new ReportRow(debug, 2);
						one.setRow("Title", title);
						rows.add(one);
						one = new ReportRow(debug, 2);
						one.setRow("Vendor","Amount");
						rows.add(one);		

						total = 0; count = 0;						
						rs = pstmt.executeQuery();
						while(rs.next()){
								String str = rs.getString(1);
								if(str == null) str = "Unknown";
								one = new ReportRow(debug, 2);
								one.setRow(str,
													 "$"+rs.getString(2)+".00"
													 );
								total += rs.getInt(2);
								rows.add(one);
						}
						one = new ReportRow(debug, 2);
						one.setRow("Total","$"+total+".00");
						rows.add(one);
						rs = pstmt2.executeQuery();
						if(rs.next()){
								count = rs.getInt(1);
						}
						one = new ReportRow(debug, 2);
						one.setRow("Redemptions Count",""+count);
						rows.add(one);
						if(total > 0 && count > 0){
								double average = (total +0.0)/count;
								one = new ReportRow(debug, 2);
								one.setRow("Redemption Average",				
													 currencyFormatter.format(average));
								rows.add(one);					
						}
						all.add(rows);
				}catch(Exception e){
						msg += e+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, rs, pstmt, pstmt2, pstmt3);
				}		
				return msg;
		}
		public String redeemOld(){
		
				Connection con = null;
				PreparedStatement pstmt = null;
				PreparedStatement pstmt2 = null;
				ResultSet rs = null;

				String msg = "";
				String which_date = "", which_date2="";
				String qq = "", qw="", qg="", qq2="";
				which_date="e.date_time ";
				which_date2= "r.date_time ";
				if(prev_year.equals("") || next_year.equals("")){
						return "Need to set the issue year and redeem year";
				}
				//
				qq = " select b.value name, count(*) amount from bucks b join redeem_bucks rb on b.id=rb.buck_id join redeems r on r.id=rb.redeem_id "+
						" join ebt_bucks eb on eb.buck_id=b.id "+
						" join ebts e on e.id = eb.ebt_id ";
				qq2 = " select b.value name, count(*) amount from bucks b join redeem_bucks rb on b.id=rb.buck_id join redeems r on r.id=rb.redeem_id "+
						" join gift_bucks gb on gb.buck_id=b.id "+
						" join gifts e on e.id=gb.gift_id ";
				qg = " group by name having amount > 0 ";
				qw += " where year("+which_date+") = ? and year("+which_date2+") = ? ";
				qq += qw;
				qq2 += qw;
				qq += qg;
				qq2 += qg;
				logger.debug(qq);
				logger.debug(qq2);		
				try{
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
						qq = qq2;
						pstmt2 = con.prepareStatement(qq2);
						int jj=1;
						pstmt.setString(jj, prev_year);
						pstmt2.setString(jj, prev_year);
						jj++;
						pstmt.setString(jj, next_year);
						pstmt2.setString(jj, next_year);				

						title = "MB/GC Issued "+prev_year+" redeemed "+next_year;
						rows = new ArrayList<ReportRow>();
						ReportRow one = new ReportRow(debug, 2);
						one.setRow("Title", title);
						rows.add(one);			
						one = new ReportRow(debug, 3);
						one.setRow("Certificate Type","Count","Amount");
						rows.add(one);
						int total = 0, count = 0;
						rs = pstmt.executeQuery();
						while(rs.next()){
								String str = "";
								one = new ReportRow(debug, 3);
								int val = rs.getInt(1);
								int cnt = rs.getInt(2);
								count += cnt;
								if(val == 3){
										str = "MB $3";
								}
								else if(val == 5){
										str = "GC $5";
								}
								else{
										str = "GC $20";
								}
								val = cnt*val;				
								one.setRow(str,
													 ""+cnt,
													 "$"+val+".00"
													 );
								total += val;
								rows.add(one);
						}
						//
						rs = pstmt2.executeQuery();
						while(rs.next()){
								String str = "";
								one = new ReportRow(debug, 3);
								int val = rs.getInt(1);
								int cnt = rs.getInt(2);
								count += cnt;
								if(val == 3){
										str = "MB $3";
								}
								else if(val == 5){
										str = "GC $5";
								}
								else{
										str = "GC $20";
								}
								val = cnt*val;				
								one.setRow(str,
													 ""+cnt,
													 "$"+val+".00"
													 );
								total += val;
								rows.add(one);
						}
						one = new ReportRow(debug, 3);			
						one.setRow("Total",""+count, "$"+total+".00");
						rows.add(one);
						all.add(rows);
				}catch(Exception e){
						msg += e+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, rs, pstmt, pstmt2);
				}		
				return msg;
		}	
		//
		public String participateData(){
		
				Connection con = null;
				PreparedStatement pstmt = null;
				PreparedStatement pstmt2 = null;		
				ResultSet rs = null;
				String msg = "";
				String which_date = "";
				String qq = "", qw="", qg="", qq2="";
				which_date="e.date_time ";
				title = "Households Participated in MB ";
				setTitle();
				rows = new ArrayList<ReportRow>();
				ReportRow one = new ReportRow(debug, 3);
				one.setRow("Title", title);
				rows.add(one);
				one = new ReportRow(debug, 3);
				one.setRow("Household card #","Fund Type","Amount");
				rows.add(one);
				//
				// MB
				//
				qq = " select e.card_last_4 card, b.fund_type type, sum(b.value) amount from bucks b left join ebt_bucks eb on b.id=eb.buck_id left join ebts e on e.id=eb.ebt_id ";
				qg = " group by card, type having amount > 0 ";
				qq2 = " select count(*) from ebts e ";
				if(!year.equals("")){
						if(!qw.equals("")){
								qw += " and ";
						}
						else{
								qw  = " where ";
						}
						qw += " year("+which_date+") = ? ";
				}
				else {
						if(!date_from.equals("")){
								if(!qw.equals("")){
										qw += " and ";
								}
								else{
										qw = " where ";
								}
								qw += which_date+" >= ? ";
						}
						if(!date_to.equals("")){
								if(!qw.equals("")){
										qw += " and ";
								}
								else{
										qw = " where ";
								}
								qw += which_date+" <= ? ";
						}
				}
				if(!qw.equals("")){
						qq += qw;
						qq2 += qw;
				}
				qq += qg;
				// System.err.println(qq);
				logger.debug(qq);
				logger.debug(qq2);
				try{
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
						qq = qq2;
						pstmt2 = con.prepareStatement(qq2);
						int jj=1;
						if(!year.equals("")){
								pstmt.setString(jj, year);
								pstmt2.setString(jj, year);				
						}
						else {
								if(!date_from.equals("")){
										pstmt.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										pstmt2.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										jj++;
								}
								if(!date_to.equals("")){
										pstmt.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										pstmt2.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										jj++;
								}
						}
						rs = pstmt.executeQuery();
						int total = 0 , count = 0, ebt_total=0; // families count
						int dmb_total = 0;
						String prev = "";
						jj=1;
						while(rs.next()){
								String str = rs.getString(1);
								if(str == null) str = "Unknown";
								if(!str.equals(prev)){
										count++;
										prev = str;
								}
								String str2 = rs.getString(2);
								if(str2 == null) str2 = "Unknown";
								else str2 = str2.toUpperCase();
								one = new ReportRow(debug, 3);
								one.setRow(str,
													 str2,
													 "$"+rs.getString(3)+".00"
													 );
								if(str2.equals("EBT")){
										ebt_total += rs.getInt(3);
								}
								else{
										dmb_total += rs.getInt(3);
								}
								rows.add(one);
						}
						title = "Households Participated Stats ";
						setTitle();
						List<ReportRow> rows2 = new ArrayList<ReportRow>();
						one = new ReportRow(debug, 2);
						one.setRow("Title", title);
						rows2.add(one);
						one = new ReportRow(debug, 2);
						one.setRow("Item", "Value");
						rows2.add(one);			
						total = ebt_total+dmb_total;
						one = new ReportRow(debug, 2);			
						one.setRow("EBT Total","$"+ebt_total+".00");
						rows2.add(one);
						one = new ReportRow(debug, 2);			
						one.setRow("DMB Total","$"+dmb_total+".00");
						rows2.add(one);
						one = new ReportRow(debug, 2);			
						one.setRow("Total","$"+total+".00");
						rows2.add(one);			
						one = new ReportRow(debug, 2);						
						one.setRow("Household count",""+count);			
						rows2.add(one);
						rs = pstmt2.executeQuery();
						int count2 = 0; // trans count
						if(rs.next()){
								count2 = rs.getInt(1);
						}
						one = new ReportRow(debug, 2);						
						one.setRow("Transaction count",""+count2);
						rows2.add(one);			
						if(total > 0 && count2 > 0){
								double average = (total+0.0)/count2;
								one = new ReportRow(debug, 2);
								one.setRow("Average Participation",				
													 currencyFormatter.format(average));
								rows2.add(one);				
						}
						if(count > 0 && count2 > 0){
								double average = (count2+0.0)/count;
								one = new ReportRow(debug, 2);
								one.setRow("Average particiaptions number per household",
													 decFormat.format(average));
								rows2.add(one);				
						}
						all.add(rows2);
						all.add(rows);
				}catch(Exception e){
						msg += e+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, pstmt, pstmt2, rs);
				}		
				return msg;
		}
		public String inventoryStats(){
		
				Connection con = null;
				PreparedStatement pstmt  = null;
				PreparedStatement pstmt2 = null;
				PreparedStatement pstmt3 = null;		
				ResultSet rs = null;
				Hashtable<String, Integer> table = new Hashtable<String, Integer>(3);
				all2.put("GC 20",new ReportRow(debug, 4));
				all2.put("GC 5",new ReportRow(debug, 4));
				all2.put("MB 3",new ReportRow(debug, 4));
				all2.put("Total",new ReportRow(debug, 4));
				String msg = "";
				String which_date = "";
				String qq = "", qw="", qg="", qq2="", qw2="", qq3="", qw3="";
				which_date="b.date ";
				String which_date2 = "e.date_time ";
				title = "MB & GC Inventory Stats ";
				setTitle();
				rows = new ArrayList<ReportRow>();		
				ReportRow one = new ReportRow(debug, 3);
				one.setRow("Title", title);
				rows.add(one);
				one = new ReportRow(debug, 2);
				one.setRow("Certificate Type","Printed Amount");
				rows.add(one);		
				qq = " select t.name type,count(*) amount from buck_seq s, batches b, buck_confs c,buck_types t ";
				qw = " where b.id=s.batch_id and b.conf_id=c.id and c.type_id=t.id and b.status='Printed' ";		
				qq2 = " select t.name type,count(*) amount from gift_bucks eb, buck_seq s, batches b, buck_confs c,buck_types t,gifts e ";
				qw2 = " where eb.buck_id=s.id and b.id=s.batch_id and b.conf_id=c.id and c.type_id=t.id and b.status='Printed' and e.id=eb.gift_id ";		
				qq3 = " select t.name type,count(*) amount from ebt_bucks eb, buck_seq s, batches b, buck_confs c,buck_types t,ebts e ";
				qw3 = " where eb.buck_id=s.id and b.id=s.batch_id and b.conf_id=c.id and c.type_id=t.id and b.status='Printed' and e.id = eb.ebt_id ";
		
				qg = " group by type having amount > 0 order by type ";
				//		
				// issuing of the printed MB GC of the printed in 2015
				// we ignore all that was issued before
				//
				year = "2015-01-01"; 
				if(!qw.equals("")){
						qw += " and ";
						qw2 += " and ";
						qw3 += " and ";				
				}
				// qw
				qw += which_date+" > '"+ year+"'";		
				qw2 += which_date+" > '"+ year+"'";
				qw3 += which_date+" > '"+ year+"'";			
				if(!qw.equals("")){
						qq += qw;
						qq2 += qw2;
						qq3 += qw3;			
				}
		
				qq += qg;
				qq2 += qg;
				qq3 += qg;		

				logger.debug(qq);
				logger.debug(qq2);
				logger.debug(qq3);			

				try{
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
						pstmt2 = con.prepareStatement(qq2);
						pstmt3 = con.prepareStatement(qq3);
						
						int jj=1;
						rs = pstmt.executeQuery();
						int total = 0, val=0, old_val=0;
						while(rs.next()){
								String str = rs.getString(1);
								val = rs.getInt(2);
								total += val;
								table.put(str, new Integer(val));
								ReportRow old = all2.get(str);
								if(old != null){
										old.setRow(0, str); // type
										old.setRow(1, ""+val);
										all2.put(str, old);
								}
								str = "Printed "+str;
								one = new ReportRow(debug, 2);
								one.setRow(str,
													 ""+val
													 );
								rows.add(one);
						}
						one = new ReportRow(debug, 2);			
						one.setRow("Printed Total",""+total);
						ReportRow old2 = all2.get("Total");
						if(old2 != null){
								old2.setRow(0, "Total"); // type
								old2.setRow(1, ""+total);
								all2.put("Total", old2);
						}			
						rows.add(one);
						rs = pstmt2.executeQuery();
						total = 0;
						while(rs.next()){
								String str = rs.getString(1);
								val = rs.getInt(2);
								total += val;
								if(table.containsKey(str)){
										old_val = table.get(str).intValue();
										old_val = old_val - val;
										table.put(str, new Integer(old_val));
								}
								ReportRow old = all2.get(str);
								if(old != null){
										old.setRow(2, ""+val);
										all2.put(str, old);
								}				
								str = "Issued "+str;
								one = new ReportRow(debug, 2);
								one.setRow(str,
													 ""+val
													 );
								rows.add(one);
						}
						//
						rs = pstmt3.executeQuery();
						while(rs.next()){
								String str = rs.getString(1);
								val = rs.getInt(2);
								total += val;
								if(table.containsKey(str)){
										old_val = table.get(str).intValue();
										old_val = old_val - val;
										table.put(str, new Integer(old_val));
								}
								ReportRow old = all2.get(str);
								if(old != null){
										old.setRow(2, ""+val);
										all2.put(str, old);
								}								
								str = "Issued "+str;
								one = new ReportRow(debug, 2);
								one.setRow(str,
													 ""+val
													 );
								rows.add(one);
						}
						one = new ReportRow(debug, 2);			
						one.setRow("Issued Total",""+total);
						rows.add(one);
						old2 = all2.get("Total");
						if(old2 != null){
								old2.setRow(2, ""+total);
								all2.put("Total", old2);
						}									
						//
						// current inventory
						//
						total = 0;
						List<String> list = new ArrayList<String>(table.keySet());
						Collections.sort(list);
						for(String key:list){
								one =  new ReportRow(debug, 2);
								val = table.get(key).intValue();
								total += val;
								one.setRow("Inventory "+key, ""+val);
								rows.add(one);
								ReportRow old = all2.get(key);
								if(old != null){
										old.setRow(3, ""+val);
										all2.put(key, old);
								}					
						}
						if(total > 0){
								one =  new ReportRow(debug, 2);
								one.setRow("Inventory Total", ""+total);
								rows.add(one);
								old2 = all2.get("Total");
								if(old2 != null){
										old2.setRow(3, ""+total);
										all2.put("Total", old2);
								}					
						}
						else{
								old2 = all2.get("Total");
								if(old2 != null){
										old2.setRow(3, ""+total);
										all2.put("Total", old2);
								}			
						}
						// all.add(rows);
			
				}catch(Exception e){
						msg += e+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, rs, pstmt, pstmt2, pstmt3);
				}		
				return msg;
		}
		public String issued(){
		
				Connection con = null;
				PreparedStatement pstmt = null;
				PreparedStatement pstmt2 = null;		
				ResultSet rs = null;

				String msg = "";
				String which_date = "";
				String qq = "", qw="", qg="", qq2="";
				which_date="e.date_time ";
				title = "Issued MB's ";
				setTitle();
				rows = new ArrayList<ReportRow>();		
				ReportRow one = new ReportRow(debug, 2);
				one.setRow("Title", title);
				rows.add(one);
				one = new ReportRow(debug, 2);
				one.setRow("MB Number","Value");
				rows.add(one);
				//
				// MB
				//
				qq = " select b.id,b.value from bucks b left join ebt_bucks eb on b.id=eb.buck_id left join ebts e on e.id=eb.ebt_id ";

				//
				// GC
				//
				qq2 = " select b.id,b.value from bucks b left join gift_bucks eb on b.id=eb.buck_id left join gifts e on e.id=eb.gift_id ";
				qw = " where b.voided is null ";
				if(!year.equals("")){
						qw += " and ";
						qw += " year("+which_date+") = ? ";
				}
				else {
						if(!date_from.equals("")){
								qw += " and ";
								qw += which_date+" >= ? ";
						}
						if(!date_to.equals("")){
								qw += " and ";
								qw += which_date+" <= ? ";
						}
				}
				if(!qw.equals("")){
						qq += qw;
						qq2 += qw;
				}
				qq += qg;
				logger.debug(qq);
				logger.debug(qq2);
				try{
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
						qq = qq2;
						pstmt2 = con.prepareStatement(qq2);
						int jj=1;
						if(!year.equals("")){
								pstmt.setString(jj, year);
								pstmt2.setString(jj, year);
								jj++;
						}
						else {
								if(!date_from.equals("")){
										pstmt.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										pstmt2.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										jj++;
								}
								if(!date_to.equals("")){
										pstmt.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										pstmt2.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										jj++;
								}
						}
						rs = pstmt.executeQuery();
						int total = 0, count=0;
						while(rs.next()){
								String str = rs.getString(1);
								one = new ReportRow(debug, 2);
								one.setRow(str,
													 rs.getString(2)
													 );
								total += rs.getInt(2);
								rows.add(one);
								count++;
						}
						one = new ReportRow(debug, 2);
						one.setRow("Count",""+count);
						rows.add(one);
						one = new ReportRow(debug, 2);
						one.setRow("Total","$"+total+".00");
						rows.add(one);
						all.add(rows);
						//
						title = "Issued GC's ";
						setTitle();			
						rows = new ArrayList<ReportRow>();		
						one = new ReportRow(debug, 2);
						one.setRow("Title", title);
						rows.add(one);
						one = new ReportRow(debug, 2);
						one.setRow("GC Number","Value");
						rows.add(one);
						rs = pstmt2.executeQuery();
						total = 0;count=0;
						while(rs.next()){
								String str = rs.getString(1);
								one = new ReportRow(debug, 2);
								one.setRow(str,
													 rs.getString(2)
													 );
								total += rs.getInt(2);
								rows.add(one);
								count++;
						}
						one = new ReportRow(debug, 2);
						one.setRow("Count",""+count);
						rows.add(one);			
						one = new ReportRow(debug, 2);
						one.setRow("Total","$"+total+".00");
						rows.add(one);
						all.add(rows);

				}catch(Exception e){
						msg += e+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, rs, pstmt, pstmt2);
				}		
				return msg;
		}
		public String unissued(){
		
				Connection con = null;
				PreparedStatement pstmt = null;
				PreparedStatement pstmt2 = null;		
				ResultSet rs = null;
				//
				String msg = "";
				String which_date = "";
				String qq = "", qw="", qg="", qq2="";
				which_date="bs.date ";
				title = "Unissued MB's ";
				setTitle();
				rows = new ArrayList<ReportRow>();		
				ReportRow one = new ReportRow(debug, 2);
				one.setRow("Title", title);
				rows.add(one);
				one = new ReportRow(debug, 2);
				one.setRow("MB Number","Value");
				rows.add(one);
				//
				// MB
				//
				qq = " select b.id,b.value from bucks b join buck_seq s on s.id=b.id join batches bs on bs.id=s.batch_id where b.voided is null and b.value = 3 and b.id not in  (select e.buck_id from ebt_bucks e) ";
				//
				// GC
				//
				qq2 = " select b.id,b.value from bucks b join buck_seq s on s.id=b.id join batches bs on bs.id=s.batch_id where b.voided is null and b.value > 3 and b.id not in(select g.buck_id from gift_bucks g)";
				if(!year.equals("")){
						qw += " and year("+which_date+") = ? ";
				}
				else {
						if(!date_from.equals("")){
								qw += "and "+which_date+" >= ? ";
						}
						if(!date_to.equals("")){
								qw += "and "+which_date+" <= ? ";
						}
				}
				if(!qw.equals("")){
						qq += qw;
						qq2 += qw;
				}			
				logger.debug(qq);
				logger.debug(qq2);
				try{
						con = Helper.getConnection();
			
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
						qq = qq2;
						pstmt2 = con.prepareStatement(qq2);
						int jj=1;
						if(!year.equals("")){
								pstmt.setString(jj, year);
								pstmt2.setString(jj, year);
								jj++;
						}
						else {
								if(!date_from.equals("")){
										pstmt.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										pstmt2.setDate(jj, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										jj++;
								}
								if(!date_to.equals("")){
										pstmt.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										pstmt2.setDate(jj, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										jj++;
								}
						}

						rs = pstmt.executeQuery();
						int total = 0, count=0;
						while(rs.next()){
								String str = rs.getString(1);
								one = new ReportRow(debug, 2);
								one.setRow(str,
													 rs.getString(2)
													 );
								total += rs.getInt(2);
								rows.add(one);
								count++;
						}
						one = new ReportRow(debug, 2);
						one.setRow("Count",""+count);
						rows.add(one);
						one = new ReportRow(debug, 2);
						one.setRow("Total","$"+total+".00");
						rows.add(one);
						all.add(rows);
						//
						title = "Unissued GC's ";
						setTitle();			
						rows = new ArrayList<ReportRow>();		
						one = new ReportRow(debug, 2);
						one.setRow("Title", title);
						rows.add(one);
						one = new ReportRow(debug, 2);
						one.setRow("GC Number","Value");
						rows.add(one);
						rs = pstmt2.executeQuery();
						total = 0;count=0;
						while(rs.next()){
								String str = rs.getString(1);
								one = new ReportRow(debug, 2);
								one.setRow(str,
													 rs.getString(2)
													 );
								total += rs.getInt(2);
								rows.add(one);
								count++;
						}
						one = new ReportRow(debug, 2);
						one.setRow("Count",""+count);
						rows.add(one);			
						one = new ReportRow(debug, 2);
						one.setRow("Total","$"+total+".00");
						rows.add(one);
						all.add(rows);

				}catch(Exception e){
						msg += e+":"+qq;
						logger.error(msg);
				}
				finally{
						Helper.databaseDisconnect(con, rs, pstmt, pstmt2);
				}		
				return msg;
		}	
}






















































