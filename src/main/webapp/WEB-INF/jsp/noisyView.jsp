<%@  include file="header.jsp" %>
<s:url id="noisyEdit" action="edit" var="noisyUrl">
	<s:param name="id"><s:property value="noisy.id" /></s:param>
</s:url>
<h3>Ordinance Violations</h3>
<table border="1">
	<tr><td> 
		<table>
			<tr>
				<td align="right"><b>ID:</b></td>
				<td align="left"><s:property value="noisy.id" /></td>
			</tr>
			<tr>
				<td align="right"><b>Occupant Full Name:</b></td>
				<td align="left"><s:property value="noisy.fullName" /></td>
			</tr>
			<tr>
				<td align="right"><b>Address: </b></td>
				<td align="left"><s:property value="noisy.addressStr" /></td>
			</tr>
			<tr>
				<td align="right"><b>City, State Zip:</b></td>
				<td align="left"><s:property value="noisy.cityStateZip" /></td>
			</tr>
			<tr>
				<td align="right"><b>Violation Date Time:</b></td>
				<td align="left"><s:property value="noisy.dateTime" /></td>
			</tr>
			<tr>
				<td align="right"><b>Court: Date </b></td>
				<td align="left"><s:property value="noisy.courtDateTime" /></td>
			</tr>
			<tr>
				<td align="right"><b>Violation Fine $</b></td>
				<td align="left"><s:property value="noisy.fine" /></td>
			</tr>
			<tr>
				<td align="right"><b>Status </b></td>
				<td align="left"><s:property value="noisy.status" /></td>
			</tr>
		</table>
	</td></tr>
	<s:if test="noisy.hasOwners()">
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
	<s:if test="user.canEdit()">
	<tr>
		<td><a href='<s:property value="#noisyUrl"/>'>Edit</a></td>
	</tr>
	</s:if>
</table>
<%@  include file="footer.jsp" %>
	





































