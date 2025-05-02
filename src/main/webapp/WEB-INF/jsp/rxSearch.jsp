<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<h3>Search MarketRx Bucks</h3>
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
<s:form action="rxSearch" method="post">
  <table border="0" width="90%">
      <tr><td align="right"><label for="rx_id">MarketRx ID:</label></td>
	  <td align="left"><s:textfield name="rxList.id" value="%{rxList.id}" size="8" id="rx_id" /></td>
      </tr>
      <tr><td align="right"><label for="mb_id">MB ID:</label></td>
	  <td align="left"><s:textfield name="rxList.buck_id" value="%{rxList.buck_id}" size="8" id="mb_id" /></td>
      </tr>
      <tr>
	  <td align="right"><label for="vouch">Voucher #:</label></td>
	  <td align="left"><s:textfield name="rxList.voucherNum" value="%{rxList.voucherNum}" size="10" maxlength="10" id="vouch" /> </td>
      </tr>		  
      <tr>
	  <td align="right"><label for="amount">Rx Amount ($):</label></td>
	  <td align="left"><s:textfield name="rxList.amount" value="%{rxList.amount}" size="4" maxlength="4" id="amount" /> </td>
      </tr>
      <tr>
	  <td align="right"><label for="status">Status:</label></td>
	  <td align="left"><s:radio name="rxList.cancelled" value="%{rxList.cancelled}" list="#{'-1':'All','n':'Active','y':'Cancelled'}" id="status" /> </td>
      </tr>
      <tr>
	  <td align="right"><label for="disp">Dispute Resolution?</label></td>
	  <td align="left"><s:radio name="rxList.dispute_resolution" value="%{rxList.dispute_resolution}" list="#{'-1':'All','n':'No','y':'Yes'}" id="disp" /> </td>
      </tr>					
      <tr>
	  <td align="right"><b>Date:</b></td>
	  <td align="left"><label for="from"> From</label><s:textfield name="rxList.date_from" value="%{rxList.date_from}" size="10" maxlength="10" cssClass="date" id="from" /><label for="to"> To </label><s:textfield name="rxList.date_to" value="%{rxList.date_to}" size="10" maxlength="10" cssClass="date" id="to" /></td>
      </tr>  
      <tr>
	  <td align="right"><label for="sortby">Sort by:</label></td>
	  <td align="left">
	      <s:select name="rxList.sortBy" id="sortby"
			value="%{rxList.sortBy}"
			      list="#{'-1':'ID','r.date_time':'Date & Time','r.voucher_num':'Voucher Number'}" headerKey="-1" headerValue="ID" /></td>
      </tr>  
      <tr>
	  <td align="center" colspan="2">
	      <s:submit name="action" type="button" value="Search" />
	  </td>
      </tr>
  </table>
</s:form>
<s:if test="action != ''">
    <s:if test="hasRxes()">
	<s:set var="rxes" value="rxes" />
	<s:set var="rxesTitle" value="rxesTitle" />
	<s:set var="rxTotal" value="rxTotal" />
	<s:set var="showTotal" value="'true'" />
	<%@  include file="rxes.jsp" %>	  
    </s:if>
</s:if>	
<%@  include file="footer.jsp" %>























































