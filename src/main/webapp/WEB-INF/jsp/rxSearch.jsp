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
  <table border="1" width="80%">
      <tr>
	  <td>
	      <table width="100%"><caption>
		  <tr><td align="right"><label>MarketRx ID:</label></td>
		      <td align="left"><s:textfield name="rxList.id" value="%{rxList.id}" size="8" /></td>
		  </tr>
		  <tr><td align="right"><label>MB ID:</label></td>
		      <td align="left"><s:textfield name="rxList.buck_id" value="%{rxList.buck_id}" size="8" /></td>
		  </tr>
		  <tr>
		      <td align="right"><label>Voucher #:</label></td>
		      <td align="left"><s:textfield name="rxList.voucherNum" value="%{rxList.voucherNum}" size="10" maxlength="10" /> </td>
		  </tr>		  
		  <tr>
		      <td align="right"><label>Rx Amount ($):</label></td>
		      <td align="left"><s:textfield name="rxList.amount" value="%{rxList.amount}" size="4" maxlength="4" /> </td>
		  </tr>
		  <tr>
		      <td align="right"><label>Status:</label></td>
		      <td align="left"><s:radio name="rxList.cancelled" value="%{rxList.cancelled}" list="#{'-1':'All','n':'Active','y':'Cancelled'}" /> </td>
		  </tr>
		  <tr>
		      <td align="right"><label>Dispute Resolution?</label></td>
		      <td align="left"><s:radio name="rxList.dispute_resolution" value="%{rxList.dispute_resolution}" list="#{'-1':'All','n':'No','y':'Yes'}" /> </td>
		  </tr>					
		  <tr>
		      <td align="right"><label>Date:</label></td>
		      <td align="left"><label> From</label><s:textfield name="rxList.date_from" value="%{rxList.date_from}" size="10" maxlength="10" cssClass="date" /><label> To </label><s:textfield name="rxList.date_to" value="%{rxList.date_to}" size="10" maxlength="10" cssClass="date" /></td>
		  </tr>  
		  <tr>
		      <td align="right"><label>Sort by:</label></td>
		      <td align="left">
			  <s:select name="rxList.sortBy"
					  value="%{rxList.sortBy}"
				    list="#{'-1':'ID','r.date_time':'Date & Time','r.voucher_num':'Voucher Number'}" headerKey="-1" headerValue="ID" /></td>
		  </tr>  
	      </table>
	  </td>
      </tr>  
      <tr>
	  <td align="right">
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























































