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

public class ExportList implements java.io.Serializable{

		static final long serialVersionUID = 34L;	
   
    boolean debug = false;
		static Logger logger = Logger.getLogger(ExportList.class);
		static SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");	
		String id="", which_date="x.date_time";

		String date_from="", date_to="", sortBy="x.id DESC ";
		List<Export> exports = null;
	
		public ExportList(){
		}	
		public ExportList(boolean val){
				debug = val;
		}
		public void setId(String val){
				if(val != null)
						id = val;
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
				if(val != null)
						sortBy = val;
		}
	
		//
		public String getId(){
				return id;
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
				return sortBy ;
		}	
		public List<Export> getExports(){
				return exports;
		}
		//
		String find(){

				String qq = "select x.id, date_format(x.date_time,'%m/%d/%Y %H:%i'),x.user_id,x.nw_batch_name ";		
				String qf = " from exports x ";
				String qw = "";
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String msg = "";
				if(!id.equals("")){
						if(!qw.equals("")) qw += " and ";
						qw += " x.id = ? ";
				}
				else {
						if(!which_date.equals("")){
								if(!date_from.equals("")){
										qw += which_date+" >= ? ";					
								}
								if(!date_to.equals("")){
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
				qq += " limit 10 ";		
				logger.debug(qq);
				// System.err.println(qq);
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
								if(!which_date.equals("")){
										if(!date_from.equals("")){
												pstmt.setDate(jj++, new java.sql.Date(dateFormat.parse(date_from).getTime()));
										}
										if(!date_to.equals("")){
												pstmt.setDate(jj++, new java.sql.Date(dateFormat.parse(date_to).getTime()));
										}
								}
						}
						exports = new ArrayList<Export>();			
						rs = pstmt.executeQuery();
						while(rs.next()){
								Export one = new Export(debug,
																				rs.getString(1),
																				rs.getString(2),
																				rs.getString(3),
																				rs.getString(4)
																				);
								exports.add(one);
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





































