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
		<table border="0" width="100%">
		    <tr>
			<td algin="right"><label>Transaction ID: </label></td>
			<td align="left"><s:property value="ebt.id" /></td>
		    </tr>
		    <tr>
			<td algin="right"><label>Authorization #: </label></td>
			<td align="left"><s:property value="ebt.approve" /></td>
		    </tr>
		    <tr>		    
			<td algin="right"><label>Card #: </label></td>
			<td align="left"><s:property value="ebt.card_last_4" /></td>		    </tr>
		    <tr>				
			<td algin="right"><label>Request Amount: </label></td>
			<td align="left">$<s:property value="ebt.amount" />.00</td>
		    </tr>
		    <tr>		    
			<td algin="right"><label>DMB Amount: </label></td>
			<td align="left">$<s:property value="ebt.dmb_amount" />.00</td>
		    </tr>
		    <tr>
			<td algin="right"><label>Issued EBT: </label></td>
			<td align="left">$<s:property value="ebt.paid_amount" />.00</td>
		    </tr>
		    <tr>
			<td algin="right"><label>Date & Time: </label></td>
			<td align="left"><s:property value="ebt.date_time" /></td>
		    </tr>
		    <tr>			
			<td algin="right"><label>Issued DMB: </label></td>
			<td align="left">$<s:property value="ebt.donated_amount" />.00</td>
		    </tr>
		    <tr>
			<td algin="right"><label>User:</label></td>
			<td align="left"><s:property value="ebt.user" /></td>
		    </tr>
		    <tr>
			<td algin="right"><label>Total: </label></td>
			<td align="left">$<s:property value="ebt.total" />.00</td>
		    </tr>
		    <s:if test="ebt.isCancelled()">
			<tr>
			    <td algin="right"><label>Status: </label></td>
			    <td align="left">Cancelled</td>
			</tr>
		    </s:if>
		    <s:if test="ebt.isDispute_resolution()">
			<tr>
			    <td algin="right"><label>Notes: </label></td>
			    <td align="left"><s:property value="ebt.notes" /></td>
			</tr>
		    </s:if>				
		    <s:elseif test="ebt.hasBalance()">
			<tr>
			    <td align="left" bgcolor="red">
				<label>Balance: </label>
				$<s:property value="ebt.balance" />.00</td>
			</tr>
		    </s:elseif>
		</table>
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






































