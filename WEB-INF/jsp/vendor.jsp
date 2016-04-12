<%@  include file="header.jsp" %>
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
			* The ID number is the same ID number on the vendor issued card. <br />
			This is needed when scaning vendor card to redeem MB or GC.<br />
			** indicates a required field <br />
		</p>
		<table border="1" width="80%">
			<tr><td> 
				<table width="100%">
					<tr>
						<td align="right" width="35%"><label>ID #:</label></td>
						<td align="left">
							<s:if test="vendor.id == ''">
								<s:textfield name="vendor.id" maxlength="10" size="10" value="%{vendor.id}" />
							</s:if>
							<s:else>
								<s:property value="%{vendor.id}" />
							</s:else>
							* </td>
					</tr>						
					<tr>
						<td align="right" width="35%"><label>Last Name/Business:</label></td>
						<td align="left"><s:textfield name="vendor.lname" maxlength="50" size="50" required="true" value="%{vendor.lname}" /> ** </td>
					</tr>
					<tr>
						<td align="right" width="35%"><label>First Name:</label></td>
						<td align="left"><s:textfield name="vendor.fname" maxlength="30" size="30" value="%{vendor.fname}" /></td>
					</tr>				
					<tr>
						<td align="right"><label>Active:</label></td>
						<td align="left"><s:radio name="vendor.active" value="%{vendor.active}" list="#{'y':'Active','-1':'Inactive'}"/>				
						</td>
					</tr>	  
					<tr>
						<td align="right"><label>Allowed Pay Type:</label></td>
						<td align="left"><s:radio name="vendor.payType" value="%{vendor.payType}" list="#{'-1':'None','GC':'GC only','MB:GC':'MB and GC'}" /></td>
					</tr>
				</table></td>
			</tr>
			<s:if test="vendor.id == ''">
				<tr>		
					<td valign="top" align="right">
						<s:submit name="action" type="button" value="Save" id="save_button" />
					</td>
				</tr>
			</s:if>
			<s:else>
				<tr>		
					<td valign="top">	  
						<table width="100%">
							<tr>
								<td align="center">
									<s:submit name="action" type="button" id="update_button" value="Update" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</s:else>
		</table>
	</s:form>
</s:if>
<br />
<s:if test="vendors != null && vendors.size() > 0">
  <s:set var="vendors" value="vendors" />
  <s:set var="vendorsTitle" value="vendorsTitle" />
	<s:if test="canEdit()">
		<s:set var="canEdit" value="'true'" />
	</s:if>
  <%@  include file="vendors.jsp" %>	
</s:if>

<%@  include file="footer.jsp" %>	






































