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
  <table border="1" width="80%">
      <tr>
	  <td>
	      <table width="100%"><caption>
		  <tr><td align="right"><label>Transaction ID:</label></td>
		      <td align="left"><s:textfield name="giftList.id" value="%{giftList.id}" size="8" /></td>
		  </tr>
		  <tr><td align="right"><label>GC ID:</label></td>
		      <td align="left"><s:textfield name="giftList.buck_id" value="%{giftList.buck_id}" size="8" /></td>
		  </tr>
		  <tr>
		      <td align="right"><label>*Payment Type:</label></td>
		      <td align="left"><s:radio name="giftList.pay_type" value="%{giftList.pay_type}" list="{'All','Cash','Check','Money Order','Credit Card','Honorary'}" /></td>
		  </tr>	  		  
		  <tr>
		      <td align="right"><label>Check #/RecTrac #:</label></td>
		      <td align="left"><s:textfield name="giftList.check_no" value="%{giftList.check_no}" size="10" /> </td>
		  </tr>
		  <tr>
		      <td align="right"><label>Amount ($):</label></td>
		      <td align="left"><s:textfield name="giftList.amount" value="%{giftList.amount}" size="4" maxlength="4" /> </td>
		  </tr>
		  <tr>
		      <td align="right"><label>Status:</label></td>
		      <td align="left"><s:radio name="giftList.cancelled" value="%{giftList.cancelled}" list="#{'-1':'All','n':'Active','y':'Cancelled'}" /> </td>
		  </tr>
		  <tr>
		      <td align="right"><label>Dispute Resolution?</label></td>
		      <td align="left"><s:radio name="giftList.dispute_resolution" value="%{giftList.dispute_resolution}" list="#{'-1':'All','y':'Yes','n':'No'}" /> </td>
		  </tr>							
		  <tr>
		      <td align="right"><label>Date:</label></td>
		      <td align="left"><label> From</label><s:textfield name="giftList.date_from" value="%{giftList.date_from}" size="10" maxlength="10" cssClass="date" /><label> To </label><s:textfield name="giftList.date_to" value="%{giftList.date_to}" size="10" maxlength="10" cssClass="date" /></td>
		  </tr>  
		  <tr>
		      <td align="right"><label>Sort by:</label></td>
		      <td align="left">
			  <s:select name="giftList.sortBy"
					  value="%{giftList.sortBy}"
				    list="#{'-1':'ID','g.date_time':'Date & Time'}" headerKey="-1" headerValue="ID" /></td>
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
  <s:set var="gifts" value="gifts" />
  <s:set var="giftsTitle" value="giftsTitle" />
  <%@  include file="gifts.jsp" %>	  
</s:if>
<%@  include file="footer.jsp" %>























































