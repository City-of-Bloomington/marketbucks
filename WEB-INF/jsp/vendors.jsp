<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<table border="1"><caption><s:property value="#vendorsTitle" /></caption>
	<tr>
		<td align="center"><b>ID</b></td>
		<td align="center"><b>Last Name/Business</b></td>
		<td align="center"><b>First Name</b></td>
		<td align="center"><b>Active? </b></td>
		<td align="center"><b>Pay Type</b></td>
	</tr>
	<s:iterator var="one" value="#vendors">
		<tr>
			<td>
				<s:if test="#canEdit != null && #canEdit == 'true'">
					<a href="<s:property value='#application.url' />vendor.action?id=<s:property value='id' />"> <s:property value="id" /></a>
				</s:if>
				<s:else>
					<s:property value="id" />
			</s:else>
			</td>
			<td><s:property value="lname" /></td>
			<td><s:property value="fname" /></td>
			<td><s:property value="activeStr" /></td>
			<td><s:property value="payTypeStr" /></td>
		</tr>
	</s:iterator>
</table>






































