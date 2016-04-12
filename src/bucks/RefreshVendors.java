/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 */
package bucks;
import java.sql.*;
import java.util.List;
import javax.naming.*;
import javax.naming.directory.*;
import org.apache.log4j.Logger;

public class RefreshVendors implements java.io.Serializable{

    String lname="", fname="", id="", fullName="", active="y";
    boolean debug = false;
		static final long serialVersionUID = 134L;		
		static Logger logger = Logger.getLogger(RefreshVendors.class);
		static String vendorsCheckUrl=null,
				vendorsDatabase=null,
				vendorsUser=null,
				vendorsPassword=null;
		List<Vendor> oldVendors = null;
		List<Vendor> newVendors = null;
    String errors = "";
    public RefreshVendors(){
    }		
    public RefreshVendors(boolean deb,
													String val,
													String val2,
													String val3,
													String val4
													){
				debug = deb;
				if(val != null){
						vendorsCheckUrl = val;
				}
				if(val2 != null){
						vendorsDatabase = val2;
				}
				if(val3 != null){
						vendorsUser = val3;
				}
				if(val4 != null){
						vendorsPassword = val4;
				}				
    }
    //
		public void setDebug(){
				debug = true;
		}
		public String consolidate(){
				String msg = findVendors();
				if(msg.equals("")){
						if(newVendors != null && newVendors.size() > 0){
								if(oldVendors == null || oldVendors.size() == 0){
										// we all new vendors, so we do insert
										for(Vendor one:newVendors){
												msg += one.doSave();
										}
								}
								else{
										for(Vendor one:newVendors){
												if(!oldVendors.contains(one)){
														msg += one.doSave(); // we found a new one
												}
										}
										// now we try to update the old ones to see if they
										// are still active
										for(Vendor one:oldVendors){
												if(!newVendors.contains(one)){
														msg += one.setAsInactive();
												}
										}
								}
						}			
				}
				return msg;
		}
		private String findVendors(){
				String msg = "";
				VendorList vl = new VendorList(debug);
				String back = vl.find();
				if(back.equals("")){
						oldVendors = vl.getVendors();
				}
				else{
						msg += back;
				}
				vl = new VendorList(debug,
														vendorsCheckUrl,
														vendorsDatabase,
														vendorsUser,
														vendorsPassword);
				back = vl.findNewVendors();
				if(back.equals("")){
						newVendors = vl.getVendors();
				}
				else{
						msg += back;
				}
				return msg;
		}
		/**
		 * check the last update to vendor list, we check this once a day
		 */
		boolean isCurrent(){
				String msg="";
				PreparedStatement pstmt = null;
				Connection con = null;
				ResultSet rs = null;
				String qq = " select datediff(date, now()) from vendor_updates order by date DESC limit 1 ";
				// System.err.println(qq);
				int cnt = 1;
				logger.debug(qq);
				try{
						con = Helper.getConnection();
						if(con != null){
								pstmt = con.prepareStatement(qq);		
								rs = pstmt.executeQuery();
								if(rs.next()){
										cnt = rs.getInt(1);
								}
						}
				}
				catch(Exception ex){
						msg += " "+ex;
						logger.error(ex+":"+qq);
				}
				finally{
						Helper.databaseDisconnect(con, pstmt, rs);
				}			
				return cnt == 0;
		}
		String addUpdate(){
				String msg="";
				PreparedStatement pstmt = null;
				Connection con = null;
				ResultSet rs = null;
				String qq = " insert into vendor_updates values(0,now()) ";
				// System.err.println(qq);
				logger.debug(qq);
				try{
						con = Helper.getConnection();
						if(con != null){
								pstmt = con.prepareStatement(qq);		
								pstmt.executeUpdate();
						}
				}
				catch(Exception ex){
						msg += " "+ex;
						logger.error(ex+":"+qq);
				}
				finally{
						Helper.databaseDisconnect(con, pstmt, rs);
				}
				return msg;
		}	

	
}
