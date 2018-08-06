/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 */
package bucks;
import java.sql.*;
import javax.naming.*;
import javax.naming.directory.*;
import org.apache.log4j.Logger;

public class Vendor implements java.io.Serializable{

    String lname="", fname="", id="", fullName="", active="y",
				payType="MB:GC";//MB:GC, GC // Farmer Market:MB, GC, A Fair of Arts: GC
    boolean debug = false;
		static final long serialVersionUID = 132L;		
		static Logger logger = Logger.getLogger(Vendor.class);
    String errors = "";
    public Vendor(){
    }		
    public Vendor(boolean deb){
				debug = deb;
    }
    public Vendor(boolean deb, String val){
				debug = deb;
				setId(val);
    }
    public Vendor(boolean deb, String val, String val2, String val3, String val4){
				debug = deb;
				setId(val);
				setLname(val2);
				setFname(val3);
				setPayType(val4);
    }	
    public Vendor(boolean deb, String val, String val2, String val3, String val4, String val5){
				debug = deb;
				setId(val);
				setLname(val2);
				setFname(val3);
				setActive(val4);
				setPayType(val5);
		
    }

    //
		public void setDebug(){
				debug = true;
		}
    //
    // getters
    //
    public String getId(){
				return id;
    }	
    public String getLname(){
				return lname;
    }
    public String getFname(){
				return fname;
    }
    public String getPayType(){
				if(payType.equals("")){
						return "-1";
				}
				return payType;
    }
		public String getPayTypeStr(){
				String ret = "";
				if(payType.indexOf("MB") > -1){
						ret = "Market Bucks";
				}
				if(payType.indexOf("GC") > -1){
						if(!ret.equals("")) ret += ", ";
						ret += "Gift Certificates";
				}				
				return ret;
		}
    public String getFullName(){
				if(fullName.equals("")){
						fullName = lname;
						if(!fname.equals("")){
								fullName += ", ";
								fullName += fname;
						}
				}
				return fullName;
    }
		public String getCleanName(){
				String str = getFullName();
				if(str.length() > 20){
						str = str.substring(0,20);
				}
				str = str.replace(",","");
				str = str.replace("(","");
				str = str.replace(")","");		
				str = str.replace("'","_");
				str = str.replace(" ","_");		
				return str;
		}
		/*
			// causes conflict with getActive()
		public boolean isActive(){
				return !active.equals("");
		}
		*/
		public boolean isInActive(){
				return active.equals("");
		}		
		public String getActive(){
				if(active.equals("")){
						return "-1";
				}
				return active;
		}
		public String getActiveStr(){
				if(active.equals("")){
						return "No";
				}
				return "Yes";
		}
		
    //
    // setters
    //
    public void setId(String val){
				if(val != null)
						id = val;
    }	
    public void setLname (String val){
				if(val != null)
						lname = val;
    }
    public void setFname (String val){
				if(val != null)
						fname = val;
    }
    public void setPayType (String val){
				if(val != null && !val.equals("-1")){
						payType = val;
				}
				if(val == null || val.equals("-1")){
						payType = "";
				}
    }	
    public void setActive (String val){
				if(val == null || val.equals("-1"))
						active = "";
				else
						active = "y";
    }
    public void setInActive (boolean val){
				if(val)
						active = "";
    }			
    public void setInActive (){
				active = "";
    }	
	
    public String toString(){
				return getFullName();
    }
		@Override
		public int hashCode() {
				int hash = 3, id_int = 0;
				if(!id.equals("")){
						try{
								id_int = Integer.parseInt(id);
						}catch(Exception ex){}
				}
				hash = 53 * hash + id_int;
				return hash;
		}
		@Override
		public boolean equals(Object obj) {
				if (obj == null) {
						return false;
				}
				if (getClass() != obj.getClass()) {
						return false;
				}
				final Vendor other = (Vendor) obj;
				return this.id.equals(other.id);
		}
		/**
		 * check if this vendor is allowed to receive BK or GC
		 */
		boolean canReceive(String val){ // MB, GC
				// System.err.println(payType+" "+val);
				return payType.indexOf(val) > -1;
		}
	
		public String doSelect(){
				String msg="";
				PreparedStatement pstmt = null;
				Connection con = null;
				ResultSet rs = null;		
				String qq = "select id,lname,fname,active,payType from vendors where id = ?";
				logger.debug(qq);
				con = Helper.getConnection();
				if(con == null){
						msg += " could not connect to database";
						System.err.println(msg);
						return msg;
				}		
				try{
						pstmt = con.prepareStatement(qq);
						pstmt.setString(1, id);				
						rs = pstmt.executeQuery();
						if(rs.next()){
								setLname(rs.getString(2));
								setFname(rs.getString(3));
								setActive(rs.getString(4));
								setPayType(rs.getString(5)); // till we receive the update
						}
						else{
								msg = "Not found";
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
		String doSave(){
				String msg="";
				PreparedStatement pstmt = null;
				Connection con = null;
				ResultSet rs = null;		
				String qq = "insert into vendors values(?,?,?,?,?)";
				logger.debug(qq);
				con = Helper.getConnection();
				if(con == null){
						msg += " could not connect to database";
						System.err.println(msg);
						return msg;
				}		
				try{
						pstmt = con.prepareStatement(qq);
						pstmt.setString(1, id);
						pstmt.setString(2, lname);
						if(!fname.equals("")){
								pstmt.setString(3, fname);
						}
						else
								pstmt.setNull(3, Types.VARCHAR);
						pstmt.setString(4, "y");
						pstmt.setString(5, payType);
						pstmt.executeUpdate();
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
		String doUpdate(){
				String msg="";
				PreparedStatement pstmt = null;
				Connection con = null;
				ResultSet rs = null;		
				String qq = "update vendors set lname=?,fname=?,active=?,payType=? where id=?";
				logger.debug(qq);
				con = Helper.getConnection();
				if(con == null){
						msg += " could not connect to database";
						System.err.println(msg);
						return msg;
				}		
				try{
						pstmt = con.prepareStatement(qq);
						pstmt.setString(1, lname);
						if(!fname.equals("")){
								pstmt.setString(2, fname);
						}
						else
								pstmt.setNull(2, Types.VARCHAR);
						if(!active.equals(""))
								pstmt.setString(3, "y");
						else
								pstmt.setNull(3, Types.CHAR);
						if(payType.equals(""))
								pstmt.setNull(4, Types.VARCHAR);
						else
								pstmt.setString(4, payType);
						pstmt.setString(5, id);
						
						pstmt.executeUpdate();
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
		String setAsInactive(){
		
				String msg="";
				PreparedStatement pstmt = null;
				Connection con = null;
				ResultSet rs = null;		
				String qq = "update vendors set active = null where id=?";

				logger.debug(qq);
				con = Helper.getConnection();
				if(con == null){
						msg += " could not connect to database";
						System.err.println(msg);
						return msg;
				}		
				try{
						pstmt = con.prepareStatement(qq);
						pstmt.setString(1, id);
						pstmt.executeUpdate();
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
