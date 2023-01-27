<?xml version="1.0" encoding="UTF-8" ?>
<%@  include file="header.jsp" %>
<s:form action="save" method="post">    
<s:if test="noisy.id == ''">
	<h3>New Ordinance Violation</h3>
</s:if>
<s:else>
	<s:hidden name="noisy.id" value="%{noisy.id}" />
	<h3>Edit Ordinance Violation</h3>
</s:else>
<s:if test="hasActionErrors()">
   <div class="errors">
      <s:actionerror/>
   </div>
</s:if>
<s:if test="hasActionMessages()">
   <div class="welcome">
      <s:actionmessage/>
   </div>
</s:if>
	<table border="1">
	   <tr><td> 
		   	<table>
				<s:if test="noisy.id != ''">
				<tr>
					<td align="right"><b>ID:</b></td>
					<td align="left"><s:property value="id" /></td>
				</tr>
				</s:if>
				<tr>
					<td align="right"><b>Occupant Name: Last</b></td>
					<td align="left"><s:textfield name="noisy.lname" maxlength="30" size="20" required="true" value="%{noisy.lname}" ></s:textfield><b> First:</b><s:textfield name="noisy.fname" maxlength="30" size="20" required="true" value="%{noisy.fname}" ></s:textfield> <b> MI:</b><s:textfield name="noisy.mi" maxlength="2" size="2" value="%{noisy.mi}"></s:textfield> </td>
				</tr>
				<tr>
					<td align="right"><b>Address: Street Num</b></td>
					<td align="left"><s:textfield name="noisy.street_num" maxlength="10" size="10" value="%{noisy.street_num}"/><b> Dir </b><s:select name="noisy.street_dir" list="{'','E','W','N','S'}" value="%{noisy.street_dir}" /><b>Name</b><s:textfield name="noisy.street_name" maxlength="20" size="20" value="%{noisy.street_name}" /><b>Type</b><s:select name="noisy.street_type" value="noisy.street_type}" list="#application.streetTypes" listKey="id" listValue="name" /></td>
				</tr>
				<tr>
					<td align="right"><b>Address: Post Dir</b></td>
					<td align="left"><s:select name="noisy.post_dir" list="{'','E','W','N','S'}" /><b> Sud type</b><s:select name="noisy.sud_type" list="#application.sudTypes" listKey="id" listValue="name" /><b>Subunit No. </b><s:textfield name="noisy.sud_num" maxlength="4" size="4" value="%{noisy.sud_num}" /></td>
				</tr>
				<tr>
					<td align="right"><b>City</b></td>
					<td align="left"><s:textfield name="noisy.city" maxlength="20" size="20" value="%{noisy.city}" /><b> State </b><s:textfield name="noisy.state" maxlength="2" size="2" value="%{noisy.state}" /><b> Zip Code</b><s:textfield name="noisy.zip" maxlength="5" size="5" value="%{noisy.zip}" /></td>
				</tr>
				<tr>
					<td align="right"><b>Violation Date </b></td>
					<td align="left"><s:textfield name="noisy.date" size="10" required="true" value="%{noisy.date}" cssClass="date" /><b> Time</b><s:textfield name="noisy.time" maxlength="5" size="5" required="true" value="%{noisy.time}" /><s:radio name="noisy.timeType" list="{'AM','PM'}" /></td>
				</tr>
				<tr>
					<td align="right"><b>Court: Date </b></td>
					<td align="left"><s:textfield name="noisy.courtDate" maxlength="10" size="10" value="%{noisy.courtDate}" cssClass="date" /><b> Time </b><s:textfield name="noisy.courtTime" maxlength="5" size="5" value="%{noisy.courtTime}" /><s:radio name="noisy.courtTimeType" list="{'AM','PM'}" /></td>
				</tr>
				<tr>
					<td align="right"><b>Violation Fine $</b></td>
					<td align="left"><s:textfield name="noisy.fine" maxlength="6" size="6" value="%{noisy.fine}" /></td>
				</tr>
				<tr>
					<td align="right"><b>Status </b></td>
					<td align="left"><s:select name="noisy.status" list="{'Issued','Sent'}" value="%{noisy.status}" /></td>
				</tr>
			</table></td>
		</tr>
		<tr>
		<s:if test="noisy.id == ''">
		<td valign="top" align="right">
			<s:submit name="action" type="button" value="Save" /> </td>
		</s:if>
		<s:else>
		<td valign="top" align="right">
			<s:submit name="action" type="button" value="Update" /> </td>
		</s:else>
		</tr>
		<s:if test="noisy.id != '' && noisy.hasOwners()">
		  <tr><td align="center">
			<table border="1"><caption>Owner(s)</caption>
			<tr><th>Name</th><th>Address</th><th>City State Zip</th><th>Phones</th></tr>
			<s:iterator value="noisy.owners">
			  <tr>
				<td><s:property value="name" /></td>
				<td><s:property value="address" /></td>
				<td><s:property value="cityStateZip" /></td>
				<td><s:property value="phones" /></td>
			  </tr>
			</s:iterator>
			</table>
		  </td></tr>
		</s:if>
		<s:if test="noisy.hasAgent()">
		  <tr><td align="center">
			<table border="1"><caption>Agent</caption>
			<tr><th>Name</th><th>Address</th><th>Zip</th><th>Phones</th></tr>
			<tr>
			  <td><s:property value="noisy.agent.name" /></td>
			  <td><s:property value="noisy.agent.address" /></td>
			  <td><s:property value="noisy.agent.zip" /></td>
			  <td><s:property value="noisy.agent.phones" /></td>
			</tr>
			</table>
		  </td></tr>
		</s:if>			
	  </table>
	</s:form>
<%@  include file="footer.jsp" %>	






































