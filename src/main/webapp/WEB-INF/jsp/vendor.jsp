<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:if test="canEdit()">
	<s:form action="vendor" method="post" id="form_id">
		<s:if test="vendor.id == ''">
			<h4>New Vendor</h4>
		</s:if>
		<s:else>
			<h3>Edit Vendor</h3>
			<s:hidden name="vendor.id" value="%{vendor.id}" />
		</s:else>
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
		<p>
			* The Vendor number is the same ID number on the vendor issued card. <br />
			This is needed when scaning vendor card to redeem MB or GC.<br />
			** indicates a required field <br />
		</p>
		<table border="1" width="100%">
			<tr><td> 
				<dl>
					<s:if test="vendor.id != ''">
						<dt><label>MB Vendor ID #:</label></dt>
						<dd><s:property value="%{vendor.id}" /></dd>
					</s:if>
					<dt><label>*Vendor Number:</label></dt>
					<dd>
						<s:textfield name="vendor.vendorNum" maxlength="10" size="10" value="%{vendor.vendorNum}" required="true" />
					</dd>
					<dt><label>*Last Name:</label></dt>
					<dd><s:textfield name="vendor.lname" maxlength="50" size="40" required="true" value="%{vendor.lname}" /> </dd>
					<dt><label>First Name:</label></dt>
					<dd><s:textfield name="vendor.fname" maxlength="30" size="30" value="%{vendor.fname}" /></dd>
					<dt><label>Related Business:</label></dt>
					<dd><s:textfield name="vendor.businessName" maxlength="50" size="30" value="%{vendor.businessName}" />(business name if different from Last Name)</dd>
					<dt><label>Active? </label></dt>
					<dd><s:checkbox name="vendor.active" value="%{vendor.active}"/>Yes (uncheck to inactivate)
					</dd>
					<dt><label>Allowed Pay Type:</label></dt>
					<dd align="left"><s:radio name="vendor.payType" value="%{vendor.payType}" list="#{'-1':'None','GC':'GC only','MB:GC':'MB and GC'}" /></dd>
					<s:if test="vendor.id == ''">
						<dd>
						<s:submit name="action" type="button" value="Save" id="save_button" />
					</dd>
					</s:if>
					<s:else>
						<dd>
							<s:submit name="action" type="button" id="update_button" value="Update" /> &nbsp;&nbsp;

						</dd>
					</s:else>
				</dl>
			</td>
			</tr>
		</table>
	</s:form>		
	<ul>
		<li> <a href="<s:property value='#application.url' />vendor.action"> New Vendor</a></li>
		<li>	For vendors Search click <a href="<s:property value='#application.url' />vendorSearch.action"> here </a></li>
	</ul>
</s:if>
<br />
<s:if test="hasVendors()">
  <s:set var="vendors" value="vendors" />
  <s:set var="vendorsTitle" value="vendorsTitle" />
  <%@  include file="vendors.jsp" %>	
</s:if>

<%@  include file="footer.jsp" %>	






































