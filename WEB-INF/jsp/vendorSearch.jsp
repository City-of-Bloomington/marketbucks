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
	<table border="1" width="100%">
		<tr>
			<td> 
				<dl>
					<dt><label>MB Vendor ID #:</label></dt>
					<dd>
						<s:textfield name="vendLst.id" maxlength="10" size="10" value="%{vendLst.id}" />
					</dd>
					<dt><label>Vendor Number:</label></dt>
					<dd>
						<s:textfield name="vendLst.vendorNum" maxlength="10" size="10" value="%{vendLst.vendorNum}" />
					</dd>
						<dt><label>Name:</label></dt>
						<dd><s:textfield name="vendLst.name" maxlength="50" size="40" value="%{vendLst.name}" /> </dd>
						<dt><label>Active Status:</label></dt>
						<dd align="left"><s:radio name="vendLst.activeStatus" value="%{vendLst.activeStatus}" list="#{'-1':'All','y':'Active','n':'Inactive'}" /></dd>
						<dd>
							<s:submit name="action" type="button" value="Submint" id="save_button" />
						</dd>
				</dl>
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






































