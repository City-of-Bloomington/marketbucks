<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<h3>Search Issued Gift Certificates</h3>
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
<s:form action="giftSearch" method="post">
  <table border="0" width="90%">
      <tr><td align="right"><label for="trans_id">Transaction ID:</label></td>
	  <td align="left"><s:textfield name="giftList.id" value="%{giftList.id}" size="8" id="trans_id" /></td>
      </tr>
      <tr><td align="right"><label for="gc_id">GC ID:</label></td>
	  <td align="left"><s:textfield name="giftList.buck_id" value="%{giftList.buck_id}" size="8" id="gc_id" /></td>
      </tr>
      <tr>
	  <td align="right"><label for="type">Payment Type:</label></td>
	  <td align="left"><s:radio name="giftList.pay_type" value="%{giftList.pay_type}" list="{'All','Cash','Check','Money Order','Credit Card','Honorary'}" id="type" /></td>
      </tr>	  		  
      <tr>
	  <td align="right"><label for="check_no">Check #/RecTrac #:</label></td>
	  <td align="left"><s:textfield name="giftList.check_no" value="%{giftList.check_no}" size="10" id="check_no" /> </td>
      </tr>
      <tr>
	  <td align="right"><label for="amount">Amount ($):</label></td>
	  <td align="left"><s:textfield name="giftList.amount" value="%{giftList.amount}" size="4" maxlength="4" id="amount" /> </td>
      </tr>
      <tr>
	  <td align="right"><label for="status">Status:</label></td>
	  <td align="left"><s:radio name="giftList.cancelled" value="%{giftList.cancelled}" list="#{'-1':'All','n':'Active','y':'Cancelled'}" id="status" /> </td>
      </tr>
      <tr>
	  <td align="right"><label for="dispute">Dispute Resolution?</label></td>
	  <td align="left"><s:radio name="giftList.dispute_resolution" value="%{giftList.dispute_resolution}" list="#{'-1':'All','y':'Yes','n':'No'}" id="dispute" /> </td>
      </tr>							
      <tr>
	  <td align="right"><b>Date:</b></td>
	  <td align="left"><label for="from"> From</label><s:textfield name="giftList.date_from" value="%{giftList.date_from}" size="10" maxlength="10" cssClass="date" id="from" /><label for="to"> To </label><s:textfield name="giftList.date_to" value="%{giftList.date_to}" size="10" maxlength="10" cssClass="date" id="to" /></td>
      </tr>  
      <tr>
	  <td align="right"><label for="sortby">Sort by:</label></td>
	  <td align="left">
	      <s:select name="giftList.sortBy" id="sortby"
			value="%{giftList.sortBy}"
			      list="#{'-1':'ID','g.date_time':'Date & Time'}" headerKey="-1" headerValue="ID" /></td>
      </tr>  
      <tr>
	  <td align="center" colspan="2">
	      <s:submit name="action" type="button" value="Search" />
	  </td>
      </tr>
  </table>
</s:form>
<s:if test="action != ''">
  <s:set var="gifts" value="gifts" />
  <s:set var="giftsTitle" value="giftsTitle" />
  <%@  include file="gifts.jsp" %>	  
</s:if>
<%@  include file="footer.jsp" %>























































