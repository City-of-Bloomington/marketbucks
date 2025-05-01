<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="seniorAdd" method="post" onsubmit="return confirmForCancel()">
  <s:if test="senior.id == ''">
      <h3>Add New FMNP SENIOR Transaction</h3>
  </s:if>
  <s:else>
      <h3>Edit FMNP SENIOR Transaction</h3>
      <s:hidden name="senior.id" value="%{senior.id}" />
      <s:hidden name="senior.senior_max_amount" value="%{senior.senior_max_amount}" />		
      <s:if test="!senior.isCancelled()">
	  <ul>
	      <li>if you want to "Cancel" this transaction, first you need to collect all the issued MB's from the customer. These MB's will be retruned to the pool. Then click on Cancel.</li>
	      <li>If you want to Cancel certain MB's only. Check the corresponding checkbox(es) and then click on "Cancel Selected MB's".</li>
	  </ul>
      </s:if>	
  </s:else>
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
  <p>Note: FMNP Senior Amount is predetermined amount, no change is needed </p>
  <hr />
  <fieldset>
      <table border="0" width="80%">
	  <s:if test="senior.id != ''">
	      <tr>
		  <td align="right">Transaction ID:</td>
		  <td align="left"> <s:property value="%{senior.id}" /></td>
	      </tr>
	  </s:if>
	  <tr>
	      <td align="right"><label>FMNP Senior Amount:</label></td>
	      <td align="left">$<s:textfield name="senior.amount" maxlength="4" size="4" value="%{senior.amount}" id="div5" readonly="true" />.00 (Must be multiple of $3)</td>
	  </tr>
	  <s:if test="senior.id == ''">
	      <tr>
		  <td align="right"><label>Ticket #:</label></td>
		  <td align="left"><s:textfield name="senior.ticketNum" maxlength="10" size="10" value="%{senior.ticketNum}" required="true" /> *</td>
	      </tr>
	  </s:if>
	  <s:else>
	      <tr>
		  <td align="right"><label>Ticket #:</label></td>
		  <td align="left"><s:property value="%{senior.ticketNum}" /></td>
	      </tr>
	      <tr>
		  <td align="right"><label>Date & Time:</label></td>
		  <td align="left"><s:property value="%{senior.date_time}" /></td>
	      </tr>
	  <tr>	      
	      <td align="right"><label>User:</label></td>
	      <td align="left"><s:property value="%{senior.user}" /></td>
	  </tr>
	  <tr>
	      <td align="right"><label>Total:</label></td>
	      <td align="left">$<s:property value="%{senior.total}" />.00</td>
	  </tr>
	  <s:if test="senior.isCancelled()">
	      <tr>
		  <td align="right"><label>Status:</label></td>
		  <td align="left">Cancelled</td>
	      </tr>
	  </s:if>
	  <s:if test="senior.isDispute_resolution()">
	      <tr>
		  <td align="right">Status:</td>
		  <td align="left">Dispute Resolution</td>
	      </tr>
	  </s:if>
      </s:else>
      <s:if test="senior.id == ''">
	  <tr>
	      <td valign="top" align="right">
		  <s:submit name="action" type="button" id="next_button" value="Next" />
	      </td>
	  </tr>
      </s:if>
      <s:elseif test="!senior.isCancelled() && !senior.isDispute_resolution()">
	  <tr>
	      <s:if test="senior.hasBalance()">
		  <td align="center">
		      <s:submit name="action" type="button" id="next_button" value="Add Bucks" />
		  </td>
	      </s:if>
	      <td>
		  <s:submit name="action" type="button" id="cancel_button" value="Cancel" />
	      </td>
	  </tr>
      </s:elseif>
      </table>
  </fieldset>
  <hr />
  <s:if test="senior.hasBucks()">
      <table border="1" width="80%">
	  <caption><s:property value="bucksTitle" /></caption>
	  <tr>
	      <td align="center"><b>**</b></td>
	      <td align="center"><b>ID</b></td>
	      <td align="center"><b>Expire Date</b></td>
	      <td align="center"><b>Voided?</b></td>	
	      <td align="center"><b>Face Value</b></td>
	  </tr>
	  <tr>
	      <td colspan="4" align="right">Total</td>
	      <td align="right">$<s:property value="senior.bucksTotal" />.00</td>
	  </tr>
	  <s:iterator var="one" value="senior.bucks">
	      <tr>
		  <td>&nbsp;
		      <s:if test="!isVoided()">
			  <input type="checkbox" name="senior.cancel_buck_id" value="<s:property value='id' />" />
		      </s:if>
		  </td>
		  <td><s:property value="id" /></td>
		  <td><s:property value="expire_date" /></td>
		  <td><s:if test="isVoided()">Voided</s:if></td>	
		  <td align="right">$<s:property value="value" />.00</td>
	      </tr>
	  </s:iterator>
	  <tr><td colspan="5">** check to cancel and void the corresponding Fmnp Senior Bucks</td></tr>
	  <tr>
	      <td colspan="5">
		  <s:submit name="action" type="button" id="cancel_button_2" value="Cancel Selected" />
	      </td>
	  </tr>	  
      </table>
  </s:if>	
</s:form>
For FMNP SENIOR/Senior search click <a href="<s:property value='#application.url'/>fmnpSearch.action"> here. </a>
<br />
<s:if test="senior.id == ''">
	<s:if test="hasFmnpSeniors()">
		<s:set var="fmnpSeniors" value="fmnpSeniors" />
		<s:set var="fmnpSeniorsTitle" value="fmnpSeniorsTitle" />
		<s:set var="showTotal" value="'false'" />
		<%@  include file="fmnpSeniors.jsp" %>	
	</s:if>
</s:if>
<%@  include file="footer.jsp" %>	






































