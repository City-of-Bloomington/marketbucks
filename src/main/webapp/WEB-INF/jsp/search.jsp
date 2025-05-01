<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<h3>Search Redemptions</h3>
<s:form action="redeemSearch" method="post">
  <table border="1" width="80%">
      <tr>
	  <td>
	      <table width="100%"><caption>
		  <tr><td align="right"><label>Redemption ID:</label></td>
		      <td align="left"><s:textfield name="redeemList.id" value="%{redeemList.id}" size="8" /></td>
		  </tr>
		  <tr><td align="right"><label>MB/GC ID:</label></td>
		      <td align="left"><s:textfield name="redeemList.buck_id" value="%{redeemList.buck_id}" size="8" /></td>
		  </tr>
		  <tr>
		      <td align="right"><label>Vendor ID:</label></td>
		      <td align="left"><s:textfield name="redeemList.vendor_id" value="%{redeemList.vendor_id}" size="8" id="vendor_id" /></td>
		  </tr>  
		  <tr>
		      <td align="right"><label>Vendor Name:</label></td>
		      <td align="left"><s:textfield name="vendorName" value="" size="30" maxlength="30" id="vendorName" /> </td>
		  </tr>
		  <tr>
		      <td align="right"><label>Status:</label></td>
		      <td align="left"><s:radio name="redeemList.status" value="%{redeemList.status}" list="#{'-1':'All','Open':'Open','Completed':'Finalized'}" headerKey="-1" headerValue="All" /> </td>
		  </tr>		  
		  <tr>
		      <td align="right"><label>Payment Type:</label></td>
		      <td align="left"><s:radio name="redeemList.payType" value="%{redeemList.payType}" list="#{'-1':'All','MB:GC':'MB & GC','GC':'GC Only'}" headerKey="-1" headerValue="All" /> </td>
		  </tr>
		  <tr>
		      <td align="right"><label>Redemption Export:</label></td>
		      <td align="left"><s:radio name="redeemList.export" value="%{redeemList.export}" list="#{'-1':'All','exported':'Exported Only','notExported':'Not Exported Yet'}" headerKey="-1" headerValue="All" /> </td>
		  </tr>		 
		  <tr>
		      <td align="right"><label>Date:</label></td>
		      <td align="left"><label> From</label><s:textfield name="nlist.date_from" value="%{redeemList.date_from}" size="10" maxlength="10" cssClass="date" /><label> To </label><s:textfield name="redeemList.date_to" value="%{redeemList.date_to}" size="10" maxlength="10" cssClass="date" /></td>
		  </tr>  
		  <tr>
		      <td align="right"><label>Sort by:</label></td>
		      <td align="left">
			  <s:select name="redeemList.sortBy"
					  value="%{redeemList.sortBy}"
					  list="#{'-1':'ID','v.lname':'Vendor Name','r.date_time':'Date'}" headerKey="" headerValue="ID" /></td>
		  </tr>  
	      </table>
	  </td>
      </tr>  
      <tr>
	  <td align="right">
	      <s:submit name="action" type="button" value="Search" />
	  </td>
      </tr>
  </table>
</s:form>
<s:if test="action != ''">
  <s:set var="redeems" value="redeems" />
  <s:set var="redeemsTitle" value="redeemsTitle" />
  <%@  include file="redeems.jsp" %>	  
</s:if>
<%@  include file="footer.jsp" %>























































