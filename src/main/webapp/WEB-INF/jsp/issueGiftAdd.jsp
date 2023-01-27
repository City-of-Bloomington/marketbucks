<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="issueGiftAdd" method="post">    
  <h3>Issue Gift Certificates</h3>
  <s:hidden name="gift.id" value="%{gift.id}" />
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
  <p>*indicate a required field</p>
  <table border="1" width="90%">
		<tr><td> 
			<table width="100%" border="1"><caption>GC Payment ID:<s:property value="gift.id" /></caption>
				<tr>
					<td align="right" width="25%"><label>Payment Type:</label></td>
					<td align="left" width="25%"><s:property value="gift.pay_type" /></td>
					<td align="right" width="25%"><label>Check #:</label></td>
					<td align="left"><s:property value="gift.check_no" /></td>
				</tr>
				<tr>
					<td align="right"><label>User:</label></td>
					<td align="left"><s:property value="gift.user" /></td>
					<td align="right"><label>Requested:</label></td>
					<td align="right">$<s:property value="gift.amount" />.00</td>
				</tr>
				<tr>
					<td align="right"><label>Date & Time:</label></td>
					<td align="left"><s:property value="gift.date_time" /></td>		  
					<td align="right"><label>Total:</label></td>
					<td align="right">$<s:property value="gift.bucksTotal" />.00</td>
				</tr>
				<s:if test="gift.isCancelled()">
					<tr>
						<td align="right" colspan="3"><label>Status:</label></td>
						<td align="left">Cancelled</td>
					</tr>
				</s:if>				
				<s:if test="gift.hasBalance()">
					<tr bgcolor="red">
						<td align="right" colspan="3"><label>Balance:</label></td>
						<td align="right">$<s:property value="gift.balance" />.00</td>
					</tr>
				</s:if>
			</table>
		</td></tr>
		<s:if test="!gift.isCancelled()">
			<s:if test="gift.needMoreIssue()">
				<tr>
					<td align="center"><label>Scan/Enter new gift certificate:</label>
						<s:textfield name="gift.buck_id" value="" size="20" maxlength="20" required="true" id="bar_code_id" /></td>
				</tr>
			</s:if>
			<s:else>
				<tr><td align="center">All GC are issued for this customer.</td></tr>
			</s:else>
			<s:if test="gift.needMoreIssue()">
				<tr>
					<td valign="top" align="right">
						<s:submit name="action" type="button" value="Add" />
					</td>
				</tr>
			</s:if>
			<tr>
				<td valign="top" align="center">If you need to edit this transaction click on <a href="<s:property value='#application.url' />giftAdd.action?id=<s:property value='gift.id' />">Edit Transaction <s:property value="id" /></a>.
				</td>
			</tr>		  
		</s:if>
		<s:if test="gift.bucks != null && gift.bucks.size() > 0">
			<tr><td align="center">	  
				<s:set var="bucks" value="gift.bucks" />
				<s:set var="bucksTitle" value="bucksTitle" />
				<s:set var="total" value="gift.bucksTotal" />
				<%@  include file="giftBucks.jsp" %>
			</td></tr>
		</s:if>
  </table>
</s:form>


<%@  include file="footer.jsp" %>	






































