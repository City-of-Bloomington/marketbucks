<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="rxView" method="post" id="form_id" >
  <s:hidden name="rx.id" value="%{rx.id}" />
  <h3>View MarketRx </h3>
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
  <table border="0" width="90%"><caption>MB Rx</caption>
      <tr>
	  <td align="right" width="30%"><b>Voucher #:</b></td>
	  <td align="left"><s:property value="rx.voucherNum" /></td>
      </tr>
      <tr>
	  <td align="right" width="30%"><b>Amount:</b></td>
	  <td align="left">$<s:property value="rx.amount" /></td>
      </tr>
      <tr>
	  <td align="right" width="30%"><b>Issued Amount:</b></td>
	  <td align="left">$<s:property value="rx.bucksTotal" /></td>
      </tr>				
      <tr>
	  <td align="right"><b>Date & Time:</b></td>
	  <td align="left">$<s:property value="rx.date_time" /></td>
      </tr>								
      <tr>
	  <td align="right"><b>Issued by:</b></td>
	  <td align="left">$<s:property value="rx.user" /></td>
      </tr>
      
      <s:if test="rx.isCancelled()">
	  <tr><td align="right">Status:</td><td align="left">Cancelled</td></tr>
      </s:if>
      <s:if test="rx.isDispute_resolution()">
	  <tr><td align="right">Type:</td><td align="left">Dispute Resolution</td></tr>
      </s:if>				
  </table>
</s:form>
<s:if test="rx.hasBucks()">
  <s:set var="bucks" value="rx.bucks" />
  <%@  include file="bucks.jsp" %>	
</s:if>
<%@  include file="footer.jsp" %>	






































