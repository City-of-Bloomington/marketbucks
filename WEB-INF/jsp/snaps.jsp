<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<table border="1"><caption><s:property value="#snapsTitle" /></caption>
	<tr>
		<td align="center"><b>ID</b></td>
		<td align="center"><b>Purchase Snap Amount</b></td>
		<td align="center"><b>Ebt Amount</b></td>
		<td align="center"><b>DMB Amount</b></td>
		<td align="center"><b>Donor Max</b></td>		
		<td align="center"><b>Authorization #</b></td>
		<td align="center"><b>Card #</b></td>  
		<td align="center"><b>User</b></td>
		<td align="center"><b>Date & Time</b></td>
		<td align="center"><b>Cancelled?</b></td>
	</tr>
	<s:iterator var="one" value="#snaps">
		<tr>
			<td><a href="<s:property value='#application.url' />snap.action?id=<s:property value='id' />">View <s:property value="id" /></a></td>
			<td align="right">$<s:property value="snapAmount" /></td>
			<td align="right">$<s:property value="ebtAmount" /></td>			
			<td align="right">$<s:property value="dblAmount" /></td>
			<td><s:property value="dblMax" /></td>			
			<td><s:property value="authorization" /></td>
			<td><s:property value="cardNumber" /></td>
			<td><s:property value="user" /></td>
			<td><s:property value="date" /></td>

			<td>&nbsp;<s:if test="isCancelled()">Cancelled</s:if></td>
		</tr>
	</s:iterator>
	<tr>
		<td>Total</td>
		<td align="right">$<s:property value="snapTotal" /></td>
		<td align="right">$<s:property value="ebtTotal" /></td>
		<td align="right">$<s:property value="dblTotal" /></td>
		<td colspan="5">&nbsp;</td>
	</tr>
</table>






































