<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="issueAdd" method="post">    
	<h4>Issue Market Bucks</h4>
	<s:hidden name="ebt.id" value="%{ebt.id}" />
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
					<dt><label>Transaction ID: </label></dt>
					<dd><s:property value="ebt.id" /></dd>
					<dt><label>Authorization #: </label></dt>
					<dd><s:property value="ebt.approve" /></dd>
					<dt><label>Card #: </label></dt>
					<dd><s:property value="ebt.card_last_4" /></dd>				
					<dt><label>Request Amount: </label></dt>
					<dd>$<s:property value="ebt.amount" />.00</dd>
					<dt><label>DMB Amount: </label></dt>
					<dd>$<s:property value="ebt.dmb_amount" />.00</dd>
					<dt><label>Issued EBT: </label></dt>
					<dd>$<s:property value="ebt.paid_amount" />.00</dd>
					<dt><label>Date & Time: </label></dt>
					<dd><s:property value="ebt.date_time" /></dd>		  
					<dt><label>Issued DMB: </label></dt>
					<dd>$<s:property value="ebt.donated_amount" />.00</dd>
					<dt><label>User:</label></dt>
					<dd><s:property value="ebt.user" /></dd>		  
					<dt><label>Total: </label></dt>
					<dd>$<s:property value="ebt.total" />.00</dd>
					<s:if test="ebt.isCancelled()">
						<dt><label>Status: </label></dt>
						<dd>Cancelled</dd>
					</s:if>
					<s:if test="ebt.isDispute_resolution()">
						<dt><label>Notes: </label></dt>
						<dd><s:property value="ebt.notes" /></dd>
					</s:if>				
					<s:elseif test="ebt.hasBalance()">
						<dd bgcolor="red">
							<label>Balance: </label>
							$<s:property value="ebt.balance" />.00</dd>
					</s:elseif>
				</dl>
			</td>
		</tr>
		<s:if test="!ebt.isCancelled() && !ebt.isDispute_resolution()">
			<s:if test="ebt.needMoreIssue()">
				<tr>
					<td align="center"><label>*Scan/Enter new Market Buck:</label>
						<s:textfield name="ebt.buck_id" value="" size="20" maxlength="20" required="true" id="bar_code_id" /></td>
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
				<td valign="top" align="center">If you need to Edit/Cancel this transaction click on <a href="<s:property value='#application.url' />ebtAdd.action?id=<s:property value='ebt.id' />">Edit/Cancel Transaction <s:property value="id" /></a>.
				</td>
			</tr>		  
		</s:if>
		<s:if test="ebt.bucks != null && ebt.bucks.size() > 0">
			<tr><td align="center">	  
				<s:set var="bucks" value="ebt.bucks" />
				<s:set var="bucksTitle" value="bucksTitle" />
				<s:set var="total" value="ebt.bucksTotal" />
				<%@  include file="bucks.jsp" %>
			</td></tr>
		</s:if>
	</table>
</s:form>


<%@  include file="footer.jsp" %>	






































