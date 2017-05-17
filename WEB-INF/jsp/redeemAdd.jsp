<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="redeemAdd" id="form_1" method="post">    
  <h3>Redeem MB & GC</h3>
  <s:hidden name="redeem.id" value="%{redeem.id}" />
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
  <p>*indicates a required field</p>
  <table border="1" width="100%">
	<tr><td> 
	  <table width="100%" border="1"><caption>Redemption ID:<s:property value="redeem.id" /></caption>
			<tr>
				<td align="right"><label>Vendor:</label></td>
				<td align="left"><s:property value="redeem.vendor" /></td>
				<td align="right"><label>User:</label></td>
				<td align="left"><s:property value="redeem.user" /></td>		  
			</tr>
			<tr>
				<td align="right"><label>Date & time:</label></td>
				<td align="left"><s:property value="redeem.date_time" /></td>		  
				<td align="right"><label>Total:</label></td>
				<td align="right">$<s:property value="redeem.total" />.00</td>
			</tr>
			<tr>
				<td align="right" valign="top"><label>Invoice notes:</label></td>
				<td align="left"><s:property value="redeem.notes" /></td>			  
				<td align="right"><label>Count:</label></td>
				<td align="right"><s:property value="redeem.count" /></td>
			</tr>		
	  </table>
	</td></tr>
	<s:if test="redeem.status == 'Open'">
		<tr>
			<td align="center"><label>*Scan/Enter new MB/GC:</label>
				<s:textfield name="redeem.buck_id" value="" size="20" maxlength="20" required="true" id="bar_code_id" /></td>
		</tr>
		<tr>
			<td valign="top" align="right">
				<s:submit name="action" type="button" value="Add" />
			</td>
		</tr>
		<tr>
			<td align="left">To cancel this transaction click on
				<a href="<s:property value='#application.url' />redeemEdit.action?id=<s:property value='%{redeem.id}' />">Edit</a>
			</td>
		</tr>
	</s:if>
	<s:else>
		<tr>
			<td align="right">
				<button onclick="document.location='<s:property value='#application.url' />RedeemInvoice.do?id=<s:property value='redeem.id' />';return false;">Generate Invoice</button>		
			</td>
		</tr>
	</s:else>
  </table>
</s:form>
<s:if test="redeem.canFinalize()">
  <s:form action="redeemAdd" id="form_2" method="post">
		<s:hidden name="redeem.id" value="%{redeem.id}" />
		<table border="1" width="90%">
			<tr>
				<td>If you are done, click on 'Finalize' to complete this transaction and produce the 'Invoice':
					<s:submit name="action" type="button" value="Finalize" />		
				</td>
			</tr>
		</table>
  </s:form>
</s:if>
<s:if test="redeem.bucks != null && redeem.bucks.size() > 0">
  <table border="1" width="90%">
		<tr><td align="center">
			<s:set var="bucks" value="redeem.bucks" />
			<s:set var="bucksTitle" value="bucksTitle" />
			<s:set var="total" value="redeem.total" />
			<%@  include file="bucks.jsp" %>
		</td></tr>
  </table>
</s:if>
<s:if test="redeem.disputes != null && redeem.disputes.size() > 0">
  <s:set var="disputes" value="redeem.disputes" />
  <s:set var="disputesTitle" value="disputesTitle" />
  <%@  include file="disputes.jsp" %>
</s:if>
<%@  include file="footer.jsp" %>	






































