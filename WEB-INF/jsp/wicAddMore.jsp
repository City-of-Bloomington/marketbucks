<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="wicAdd" method="post">    
  <h4>Issue FMNP WIC Bucks</h4>
  <s:hidden name="wic.id" value="%{wic.id}" />
	<s:hidden name="wic.ticketNum" value="%{wic.ticketNum}" />
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
					<dd>Transaction ID: <s:property value="%{wic.id}" /></dd>
					<dt><label>Amount:</label></dt>
					<dd>$<s:property value="%{wic.amount}" />.00</dd>
					
					<dt><label>Ticket #:</label></dt>
					<dd><s:property value="%{wic.ticketNum}" /></dd>		  

					<dt><label>Date & Time:</label></dt>
					<dd><s:property value="%{wic.date_time}" /></dd>		  

					<dt><label>User:</label></dt>
					<dd><s:property value="%{wic.user}" /></dd>

					<dt><label>Total:</label></dt>
					<dd>$<s:property value="%{wic.total}" />.00</dd>
					
					<s:if test="wic.isCancelled()">
						<dt><label>Status:</label></dt>
						<dd>Cancelled</dd>
					</s:if>
					<s:if test="wic.isDispute_resolution()">
						<dt><label>Status:</label></dt>
						<dd>Dispute resolution</dd>
					</s:if>				
					<s:elseif test="wic.hasBalance()">
						<dt bgcolor="red">
							<label>Balance:</label></dt>
						<dd>$ <s:property value="%{wic.balance}" />.00</dd>
					</s:elseif>
				</dl>
			</td>
		</tr>
		<s:if test="!wic.isCancelled() && !wic.isDispute_resolution()">
			<s:if test="wic.hasBalance()">
				<tr>
					<td align="center"><label>*Scan/Enter new Market Buck:</label>
						<s:textfield name="wic.buck_id" value="" size="20" maxlength="20" required="true" id="bar_code_id" /></td>
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
				<td valign="top" align="center">If you need to Edit/Cancel this transaction click on <a href="<s:property value='#application.url' />wicAdd.action?id=<s:property value='wic.id' />">Edit/Cancel Transaction <s:property value="id" /></a>.
				</td>
			</tr>		  
		</s:if>
		<s:if test="wic.hasBucks()">
			<tr><td align="center">	  
				<s:set var="bucks" value="wic.bucks" />
				<s:set var="bucksTitle" value="bucksTitle" />
				<s:set var="total" value="wic.bucksTotal" />
				<%@  include file="bucks.jsp" %>
			</td></tr>
		</s:if>
	</table>
</s:form>


<%@  include file="footer.jsp" %>	






































