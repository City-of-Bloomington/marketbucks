<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="user" method="post" id="form_id">
	<s:if test="person.id == ''">
		<h4>New User</h4>
	</s:if>
	<s:else>
		<h3>Edit User</h3>
		<s:hidden name="person.id" value="%{person.id}" />
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
	<table border="1" width="90%">
		<tr><td> 
			<table width="100%">
				<s:if test="person.id != ''">
					<tr>							
						<td align="right"><label>User ID:</label></td>
						<td align="left">
							<s:property value="%{person.id}" />
						</td>
					</tr>							 
				</s:if>
				<tr>
					<td align="right" width="25%"><label>Username:</label></td>
					<td align="left">
						<s:textfield name="person.username" maxlength="30" size="30" value="%{person.username}" required="true" /> * (for login)
					</td>
				</tr>
				<tr>
					<td align="right"><label>Full Name:</label></td>
					<td align="left"><s:textfield name="person.fullName" maxlength="30" size="50" required="true" value="%{person.fullName}" /> ** </td>
				</tr>
				<tr>
					<td align="right"><label>Role:</label></td>
					<td align="left"><s:radio name="person.role" value="%{person.role}" list="#{'-1':'View only','Edit':'Edit Only','Edit:Delete':'Edit and Delete','Admin:Edit:Delete':'All (admin)'}" /></td>
				</tr>
				<tr>
					<td align="right"><label>Inactive:</label></td>
					<td align="left"><s:checkbox name="person.inactive" value="%{person.inactive}"/> Yes (check this to inactivate)				
					</td>
				</tr>	  
			</table></td>
		</tr>
		<s:if test="person.id == ''">
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
<br />
<s:if test="hasUsers()">
  <s:set var="users" value="users" />
  <s:set var="usersTitle" value="'Current Users'" />
  <%@  include file="users.jsp" %>	
</s:if>

<%@  include file="footer.jsp" %>	






































