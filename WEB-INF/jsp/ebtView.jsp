<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="ebtView" method="post" id="form_id" >
  <s:hidden name="ebt.id" value="%{ebt.id}" />
  <h3>View Ebt Bucks</h3>
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
  <table border="1" width="80%">
		<tr><td> 
			<table width="100%">
				<tr>
					<td align="right" width="30%"><label>Amount:</label></td>
					<td align="left"><s:property value="ebt.amount" /></td>
				</tr>
				<tr>
					<td align="right" width="30%"><label>DMB Amount:</label></td>
					<td align="left"><s:property value="ebt.dmb_amount" /></td>
				</tr>		
				<tr>
					<td align="right"><label>Approve Text:</label></td>
					<td align="left"><s:property value="ebt.approve" /></td>
				</tr>	  
				<tr>
					<td align="right"><label>Last 4 Digits Card #:</label></td>
					<td align="left"><s:property value="ebt.card_last_4" /></td>
				</tr>
				<tr>
					<td align="right"><label>Ebt Donor Max:</label></td>
					<td align="left">$<s:property value="ebt.ebt_donor_max" /></td>
				</tr>
				<tr>
					<td align="right"><label>Buck Value:</label></td>
					<td align="left">$<s:property value="ebt.ebt_buck_value" /></td>
				</tr>
				
			</table></td>
		</tr>
  </table>
</s:form>

<s:if test="ebt.hasBucks()">
  <s:set var="bucks" value="ebt.bucks" />
  <%@  include file="bucks.jsp" %>	
</s:if>
<%@  include file="footer.jsp" %>	






































