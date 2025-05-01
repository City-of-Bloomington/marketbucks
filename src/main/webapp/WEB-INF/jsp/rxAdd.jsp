<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="rxAdd" method="post" onsubmit="return confirmForCancel()">
  <s:if test="rx.id == ''">
      <h3>Add New Rx Transaction</h3>
  </s:if>
  <s:else>
      <h3>Edit Rx Transaction</h3>
      <s:hidden name="rx.id" value="%{rx.id}" />
      <s:hidden name="rx.rx_max_amount" value="%{rx.rx_max_amount}" />		
      <s:if test="!rx.isCancelled()">
	  <ul>
	      <li>If the amount is changed, this may cause the removal of all of the bucks that have been added to this transaction.</li>
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
  <table border="1" width="90%">
      <tr><td> 
	  <table width="100%">
	      <tr><td colspan="2">Note: Rx Amount is predetermined amount, no change is needed </td></tr>
	      <tr>
		  <td align="right" width="35%"><label>Rx Amount:</label></td>
		  <td align="left">$<s:textfield name="rx.amount" maxlength="4" size="4" required="true" value="%{rx.amount}" id="div5" cssClass="need_focus" />.00 (Must be multiple of $3)</td>
	      </tr>
	      <tr>
		  <td align="right"><label>Voucher #:</label></td>
		  <td align="left"><s:textfield name="rx.voucherNum" maxlength="10" size="10" value="%{rx.voucherNum}" required="true" /> *</td>
	      </tr>
	      <s:if test="rx.isCancelled()">
		  <tr>
		      <td align="right"><label>Status:</label></td>
		      <td align="left">Cancelled</td>
		  </tr>
	      </s:if>
	      <s:if test="rx.isDispute_resolution()">
		  <tr>
		      <td align="right">Type:</td><
		      <td align="left">Dispute Resolution</td>
		  </tr>
	      </s:if>						
	  </table></td>
      </tr>
      <tr>
	  <s:if test="rx.id == ''">
	      <td valign="top" align="right">
		  <s:submit name="action" type="button" id="next_button" value="Next" />
	      </td>
	  </s:if>
	  <s:elseif test="!rx.isCancelled() && !rx.isDispute_resolution()">
	      <td>		
		  <table width="100%">
		      <tr>
			  <td align="center">
			      <s:submit name="action" type="button" id="update_button" value="Update" />
			  </td>
			  <s:if test="rx.hasBalance()">
			      <td align="center">
				  <s:submit name="action" type="button" id="next_button" value="Add Bucks" />
			      </td>
			  </s:if>
			  <td align="right">
			      <s:submit name="action" type="button" id="cancel_button" value="Cancel" />
			  </td>
		      </tr>
		  </table>
				</td>		  
	  </s:elseif>
      </tr>
      <s:if test="rx.hasBucks()">
	  <tr><td align="center">	  
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
		      <td align="right">$<s:property value="rx.bucksTotal" />.00</td>
		  </tr>
		  <s:iterator var="one" value="rx.bucks">
		      <tr>
			  <td>&nbsp;
			      <s:if test="!isVoided()">
				  <input type="checkbox" name="rx.cancel_buck_id" value="<s:property value='id' />" />
			      </s:if>
			  </td>
			  <td><s:property value="id" /></td>
			  <td><s:property value="expire_date" /></td>
			  <td><s:if test="isVoided()">Voided</s:if></td>	
			  <td align="right">$<s:property value="value" />.00</td>
		      </tr>
		  </s:iterator>
		  <tr><td colspan="5">** check to cancel and void the corresponding Rx Buck</td></tr>
	      </table>
	      
	  </td></tr>
	  <tr>
	      <td align="right">
		  <s:submit name="action" type="button" id="cancel_button_2" value="Cancel Selected" />
	      </td>
	  </tr>
      </s:if>	
  </table>
</s:form>
For Rx advance search click<a href="<s:property value='#application.url'/>rxSearch.action"> here. </a>
<br />
<br />
<s:if test="rx.id == ''">
    <s:if test="hasMarketRxes()">
	<s:set var="rxes" value="marketRxes" />
	<s:set var="rxesTitle" value="marketRxesTitle" />
	<s:set var="showTotal" value="'false'" />
	<%@  include file="rxes.jsp" %>	
    </s:if>
</s:if>
<%@  include file="footer.jsp" %>	






































