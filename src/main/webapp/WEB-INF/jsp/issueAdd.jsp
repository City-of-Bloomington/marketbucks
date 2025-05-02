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
    <table border="0" width="90%">
	<tr>
	    <td align="right"><b>Transaction ID: </b></td>
	    <td align="left"><s:property value="ebt.id" /></td>
	</tr>
	<tr>
	    <td align="right"><b>Authorization #: </b></td>
	    <td align="left"><s:property value="ebt.approve" /></td>
	</tr>
	<tr>		    
	    <td align="right"><b>Card #: </b></td>
	    <td align="left"><s:property value="ebt.card_last_4" /></td>		    </tr>
	<tr>				
	    <td align="right"><b>Request Amount: </b></td>
	    <td align="left">$<s:property value="ebt.amount" />.00</td>
	</tr>
	<tr>		    
	    <td align="right"><b>DMB Amount: </b></td>
	    <td align="left">$<s:property value="ebt.dmb_amount" />.00</td>
	</tr>
	<tr>
	    <td align="right"><b>Issued EBT: </b></td>
	    <td align="left">$<s:property value="ebt.paid_amount" />.00</td>
	</tr>
	<tr>
	    <td align="right"><b>Date & Time: </b></td>
	    <td align="left"><s:property value="ebt.date_time" /></td>
	</tr>
	<tr>			
	    <td align="right"><b>Issued DMB: </b></td>
	    <td align="left">$<s:property value="ebt.donated_amount" />.00</td>
	</tr>
	<tr>
	    <td align="right"><b>User:</b></td>
	    <td align="left"><s:property value="ebt.user" /></td>
	</tr>
	<tr>
	    <td align="right"><b>Total: </b></td>
	    <td align="left">$<s:property value="ebt.total" />.00</td>
	</tr>
	<s:if test="ebt.isCancelled()">
	    <tr>
		<td align="right"><b>Status: </b></td>
		<td align="left">Cancelled</td>
	    </tr>
	</s:if>
	<s:if test="ebt.isDispute_resolution()">
	    <tr>
		<td align="right"><b>Notes: </b></td>
		<td align="left"><s:property value="ebt.notes" /></td>
	    </tr>
	</s:if>				
	<s:elseif test="ebt.hasBalance()">
	    <tr>
		<td align="right" bgcolor="red">
		    <b>Balance: </b></td>
		<td align="left" $<s:property value="ebt.balance" />.00</td>
	    </tr>
	</s:elseif>
	<s:if test="!ebt.isCancelled() && !ebt.isDispute_resolution()">
	    <s:if test="ebt.needMoreIssue()">
		<tr>
		    <td align="right"><label for="bar_code_id">* Scan/Enter new Market Buck:</label></td>
		    <td align="left"><s:textfield name="ebt.buck_id" value="" size="20" maxlength="20" required="true" id="bar_code_id" /></td>
		</tr>
		<tr>
		    <td valign="top" align="center" colspan="2">
			<s:submit name="action" type="button" value="Add" />
		    </td>
		</tr>	  
	    </s:if>
	    <s:else>
		<tr><td align="center" colspan="2">All Market Bucks are issued for this customer</td></tr>
	    </s:else>
	    <tr>
		<td valign="top" align="center" colspan="2">If you need to Edit/Cancel this transaction click on <a href="<s:property value='#application.url' />ebtAdd.action?id=<s:property value='ebt.id' />">Edit/Cancel Transaction <s:property value="id" /></a>.
		</td>
	    </tr>		  
	</s:if>
    </table>	
    <s:if test="ebt.bucks != null && ebt.bucks.size() > 0">
	<s:set var="bucks" value="ebt.bucks" />
	<s:set var="bucksTitle" value="bucksTitle" />
	<s:set var="total" value="ebt.bucksTotal" />
	<%@  include file="bucks.jsp" %>
    </s:if>

</s:form>


<%@  include file="footer.jsp" %>	






































