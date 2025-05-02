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
    <hr />
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
  <table border="0" width="90%">
      <caption>GC Payment ID:<s:property value="gift.id" /></caption>
      <tr>
	  <td align="right"><b>Payment Type:</b></td>
	  <td align="left"><s:property value="gift.pay_type" /></td>
      </tr>
      <tr>
	  <td align="right"><b>Check #:</b></td>
	  <td align="left"><s:property value="gift.check_no" /></td>
      </tr>
      <tr>
	  <td align="right"><b>User:</b></td>
	  <td align="left"><s:property value="gift.user" /></td>
      </tr>
      <tr>
	  <td align="right"><b>Requested:</b></td>
	  <td align="left">$<s:property value="gift.amount" />.00</td>
      </tr>
      <tr>
	  <td align="right"><b>Date & Time:</b></td>
	  <td align="left"><s:property value="gift.date_time" /></td>
      </tr>
      <tr>
	  <td align="right"><b>Total:</b></td>
	  <td align="left">$<s:property value="gift.bucksTotal" />.00</td>
      </tr>
      <s:if test="gift.isCancelled()">
	  <tr>
	      <td align="right"><b>Status:</b></td>
	      <td align="left">Cancelled</td>
	  </tr>
      </s:if>				
      <s:if test="gift.hasBalance()">
	  <tr bgcolor="red">
	      <td align="right"><b>Balance:</b></td>
	      <td align="left">$<s:property value="gift.balance" />.00</td>
	  </tr>
      </s:if>
      <s:if test="!gift.isCancelled()">
	  <s:if test="gift.needMoreIssue()">
	      <tr>
		  <td align="right"><label for="bar_code_id">* Scan/Enter new gift certificate:</label>
		  </td>
		  <td align="left">
		      <s:textfield name="gift.buck_id" value="" size="20" maxlength="20" required="true" id="bar_code_id" /></td>
	      </tr>
	  </s:if>
	  <s:else>
	      <tr>
		  <td align="center" colspan="2">All GC are issued for this customer.</td>
	      </tr>
	  </s:else>
	  <s:if test="gift.needMoreIssue()">
	      <tr>
		  <td valign="top" align="center" colspan="2">
		      <s:submit name="action" type="button" value="Add" />
		  </td>
	      </tr>
	  </s:if>
	  <tr>
	      <td valign="top" align="center" colspan="2">If you need to edit this transaction click on <a href="<s:property value='#application.url' />giftAdd.action?id=<s:property value='gift.id' />">Edit Transaction <s:property value="id" /></a>.
	      </td>
	  </tr>		  
      </s:if>
  </table>      
  <s:if test="gift.bucks != null && gift.bucks.size() > 0">
      <s:set var="bucks" value="gift.bucks" />
      <s:set var="bucksTitle" value="bucksTitle" />
      <s:set var="total" value="gift.bucksTotal" />
      <%@  include file="giftBucks.jsp" %>
  </s:if>
  
</s:form>

<%@  include file="footer.jsp" %>	






































