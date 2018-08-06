/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 */
package bucks;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.naming.*;
import javax.naming.directory.*;
import org.apache.log4j.Logger;

public class VendorList{

    boolean debug = false;
		static final long serialVersionUID = 123L;		
		static Logger logger = Logger.getLogger(VendorList.class);
		static String vendorsCheckUrl=null,
				vendorsDatabase=null,
				vendorsUser=null,
				vendorsPassword=null;
		List<Vendor> vendors = null;
		String name = "", active="";
    public VendorList(){
    }		
    public VendorList(boolean deb){
				debug = deb;
    }
    public VendorList(boolean deb,
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
    // setters
    //
    public void setName(String val){
				if(val != null)
						name = val;
    }
    public void setActiveOnly(){
				active = "y";
    }	
		public List<Vendor> getVendors(){
				return vendors;
		}
		String find(){
				String msg = "";
				String qq = " select id,lname,fname,active,payType from vendors ";
				String qw = "";
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				if(!name.equals("")){
						qw = " lname like ? or fname like ? ";
				}
				if(!active.equals("")){
						if(!qw.equals("")) qw += " and ";
						qw += " active is not null ";
				}
				String qo = " order by lname ";
				if(!qw.equals("")){
						qq += " where "+qw;
				}
				qq += qo;
				// System.err.println(qq);

				logger.debug(qq);
				try{
						vendors = new ArrayList<Vendor>();
						con = Helper.getConnection();
						if(con == null){
								msg = "Could not connect ";
								return msg;
						}
						pstmt = con.prepareStatement(qq);
						if(!name.equals("")){
								pstmt.setString(1, "%"+name+"%");
								pstmt.setString(2, "%"+name+"%");				
						}
						rs = pstmt.executeQuery();	
						while(rs.next()){
								Vendor one = new Vendor(debug,
																				rs.getString(1),
																				rs.getString(2),
																				rs.getString(3),
																				rs.getString(4),
																				rs.getString(5));
								vendors.add(one);
						}
				}catch(Exception e){
						msg += e+":"+qq;
						logger.error(msg);
						System.err.println(msg);
				}
				finally{
						Helper.databaseDisconnect(con, pstmt, rs);
				}
				return msg;
			
		}
		/**
		 * vsVendorType 1156:approved, tbd, unapproved
		 * vsVendorCategory 1263:farmers market, ?:Affair of Arts
		 */
		public String findNewVendors(){
				String msg="";
				PreparedStatement pstmt = null;
				Connection con = null;
				ResultSet rs = null;		
				String qq = "select VendorNumber, LastName, FirstName,vsVendorCategory from dbo.Vendor V JOIN dbo.CentralName N ON V.CentralNameID = N.CentralNameID where (V.vsVendorCategory=1263 or V.vsVendorCategory=1295) and V.ActiveFlag=1 and V.vsVendorType=1156 "; // approve ones, active only
				if(vendorsCheckUrl == null ||
					 vendorsDatabase == null ||
					 vendorsUser == null){
						msg = "Could not connect to Database, url not available";
						return msg;
				}
				logger.debug(qq);
				con = Helper.getNwConnection(vendorsCheckUrl,
																		 vendorsDatabase,
																		 vendorsUser,
																		 vendorsPassword);
				if(con == null){
						msg += " could not connect to database";
						System.err.println(msg);
						return msg;
				}		
				try{
						pstmt = con.prepareStatement(qq);
						rs = pstmt.executeQuery();
						vendors = new ArrayList<Vendor>();
						while(rs.next()){
								int vtype = rs.getInt(4);
								String pay="MB:GC";
								if(vtype == 1295){
										pay = "GC";
								}
								Vendor one = new Vendor(debug, 
																				rs.getString(1),
																				rs.getString(2),
																				rs.getString(3),
																				"y",
																				pay
																				);
								vendors.add(one);
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
