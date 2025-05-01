<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="vendorSearch" method="post" id="form_id">
	<h4>Search Vendors</h4>
	<s:if test="hasActionErrors()">
		<div class="errors">
			<s:actionerror/>
			</div>
	</s:if>
	<s:elseif test="hasActionMessages()">
		<div class="welcome">
			<s:actionmessage/>
		</div>
	</s:elseif>
	<table border="1" width="90%">
	    <tr>
		<td>
		    <table border="0" width="100%">
			<tr>
			    <td align="right"><label>MB Vendor ID #:</label></td>
			    <td align="left">
				<s:textfield name="vendLst.id" maxlength="10" size="10" value="%{vendLst.id}" />
			    </td>
			</tr>
			<tr>
			    <td align="right"><label>Vendor Number:</label></td>
			    <td align="left">
			    <s:textfield name="vendLst.vendorNum" maxlength="10" size="10" value="%{vendLst.vendorNum}" />
			    </td>
			</tr>
			<tr>
			    <td align="right"><label>Name:</label></td>
			    <td align="left"><s:textfield name="vendLst.name" maxlength="50" size="40" value="%{vendLst.name}" /> </td>
			</tr>
			<tr>
			    <td align="right"><label>Active Status:</label></td> 
			    <td align="left" align="left"><s:radio name="vendLst.activeStatus" value="%{vendLst.activeStatus}" list="#{'-1':'All','y':'Active','n':'Inactive'}" /></td>
			</tr>
			<tr>
			    <td align="left">
				<s:submit name="action" type="button" value="Submint" id="save_button" />
			    </td>
			</tr>
		    </table>
		</td>
	    </tr>
	</table>
</s:form>
<br />
<s:if test="hasVendors()">
	<s:set var="vendors" value="vendors" />
	<s:set var="vendorsTitle" value="vendorsTitle" />
	<%@  include file="vendors.jsp" %>	
</s:if>

<%@  include file="footer.jsp" %>	






































