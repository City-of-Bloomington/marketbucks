<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="rxAdd" method="post">    
  <h4>Issue MarketRx Bucks</h4>
  <s:hidden name="rx.id" value="%{rx.id}" />
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
  <p>* Indicate a required field </p>
  <table border="0" width="90%">
      <caption>Transaction ID:<s:property value="%{rx.id}" /></caption>
      <tr>
	  <td align="right"><b>Amount:</b></td>
	  <td align="right">$<s:property value="%{rx.amount}" />.00</td>
      </tr>
      <tr>
	  <td align="right"><b>Date & Time:</b></td>
	  <td align="left"><s:property value="%{rx.date_time}" /></td>		  
      </tr>
      <tr>
	  <td align="right"><b>User:</b></td>
	  <td align="left"><s:property value="%{rx.user}" /></td>
      </tr>
      <tr>
	  <td align="right"><b>Total:</b></td>
	  <td align="right">$<s:property value="%{rx.total}" />.00</td>
      </tr>
      <s:if test="rx.isCancelled()">
	  <tr>
	      <td align="right"><b>Status:</b></td>
	      <td align="left" colspan="3">Cancelled</td>
	  </tr>
      </s:if>
      <s:if test="rx.isDispute_resolution()">
	  <tr>
	      <td align="right"><b>Type:</b></td>
	      <td align="left" colspan="3">Dispute resolution Rx</td>
	  </tr>
      </s:if>				
      <s:elseif test="rx.hasBalance()">
	  <tr bgcolor="red">
	      <td align="right" colspan="3"><b>Balance:</b></td>
	      <td align="right">$<s:property value="%{rx.balance}" />.00</td>
	  </tr>
      </s:elseif>
      <s:if test="!rx.isCancelled() && !rx.isDispute_resolution()">
	  <s:if test="rx.hasBalance()">
	      <tr>
		  <td align="center"><label for="bar_code_id">*Scan/Enter new Market Buck:</label>
		      <s:textfield name="rx.buck_id" value="" size="20" maxlength="20" required="true" id="bar_code_id" /></td>
	      </tr>
	      <tr>
		  <td valign="top" align="right">
		      <s:submit name="action" type="button" value="Add" />
		  </td>
	      </tr>	  
	  </s:if>
	  <s:else>
	      <tr><td align="center" colspan="2">All Market Bucks are issued for this customer</td></tr>
	  </s:else>
	  <tr>
	      <td valign="top" align="center" colspan="2">If you need to Edit/Cancel this transaction click on <a href="<s:property value='#application.url' />rxAdd.action?id=<s:property value='rx.id' />">Edit/Cancel Transaction <s:property value="id" /></a>.
	      </td>
	  </tr>		  
      </s:if>
      <s:if test="rx.hasBucks()">
	  <tr><td align="center">	  
	      <s:set var="bucks" value="rx.bucks" />
	      <s:set var="bucksTitle" value="bucksTitle" />
	      <s:set var="total" value="rx.bucksTotal" />
	      <%@  include file="bucks.jsp" %>
	  </td></tr>
      </s:if>
  </table>
</s:form>


<%@  include file="footer.jsp" %>	






































