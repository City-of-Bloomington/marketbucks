<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="seniorAdd" method="post">    
  <h4>Issue FMNP Senior Bucks</h4>
  <s:hidden name="senior.id" value="%{senior.id}" />
	<s:hidden name="senior.ticketNum" value="%{senior.ticketNum}" />
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
  <p>*indicate a required field </p>
  <table border="1" width="90%">
		<tr>
			<td>
				<dl>
					<dd>
						<label>Transaction ID:<s:property value="%{senior.id}" /></label>
					</dd>
					<dt><label>Amount:</label></dt>
					<dd>$<s:property value="%{senior.amount}" />.00</dd>
					<dt><label>Ticket #:</label></dt>
					<dd><s:property value="%{senior.ticketNum}" /></dd>		  
					<dt><label>Date & Time:</label></dt>
					<dd><s:property value="%{senior.date_time}" /></dd>		  
					<dt><label>User:</label></dt>
					<dd><s:property value="%{senior.user}" /></dd>
					<dt><label>Total:</label></dt>
					<dd>$<s:property value="%{senior.total}" />.00</dd>
				<s:if test="senior.isCancelled()">
					<dt><label>Status:</label></dt>
					<dd align="left" colspan="3">Cancelled</dd>
				</s:if>
				<s:if test="senior.isDispute_resolution()">
						<dt><label>Status:</label></dt>
						<dd>In Dispute</dd>
				</s:if>				
				<s:elseif test="senior.hasBalance()">
						<dt><label>Balance:</label></dt>
						<dd>$<s:property value="%{senior.balance}" />.00</dd>
				</s:elseif>
				</dl>
		</td></tr>
		<s:if test="!senior.isCancelled() && !senior.isDispute_resolution()">
			<s:if test="senior.hasBalance()">
				<tr>
					<td align="center"><label>*Scan/Enter new Market Buck:</label>
						<s:textfield name="senior.buck_id" value="" size="20" maxlength="20" required="true" id="bar_code_id" /></td>
				</tr>
				<tr>
					<td valign="top" align="right">
						<s:submit name="action" type="button" value="Add" />
					</td>
				</tr>	  
			</s:if>
			<s:else>
				<tr><td align="center">All Market Bucks are issued for this customer</td></tr>
			</s:else>
			<tr>
				<td valign="top" align="center">If you need to Edit/Cancel this transaction click on <a href="<s:property value='#application.url' />seniorAdd.action?id=<s:property value='senior.id' />">Edit/Cancel Transaction <s:property value="id" /></a>.
				</td>
			</tr>		  
		</s:if>
		<s:if test="senior.hasBucks()">
			<tr><td align="center">	  
				<s:set var="bucks" value="senior.bucks" />
				<s:set var="bucksTitle" value="bucksTitle" />
				<s:set var="total" value="senior.bucksTotal" />
				<%@  include file="bucks.jsp" %>
			</td></tr>
		</s:if>
	</table>
</s:form>


<%@  include file="footer.jsp" %>	






































