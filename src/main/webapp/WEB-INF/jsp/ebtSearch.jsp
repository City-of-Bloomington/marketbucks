<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<h3>Search Ebt Transactions</h3>
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
<s:form action="ebtSearch" method="post">
  <table border="1" width="80%">
	  <tr>
		  <td>
			  <table width="100%"><caption>
				  <tr><td align="right"><label>Ebt ID:</label></td>
					  <td align="left"><s:textfield name="ebtList.id" value="%{ebtList.id}" size="8" /></td>
				  </tr>
				  <tr><td align="right"><label>MB ID:</label></td>
					  <td align="left"><s:textfield name="ebtList.buck_id" value="%{ebtList.buck_id}" size="8" /></td>
				  </tr>
				  <tr>
					  <td align="right"><label>Card #:</label></td>
					  <td align="left"><s:textfield name="ebtList.card_last_4" value="%{ebtList.card_last_4}" size="4" maxlength="4" /> </td>
				  </tr>		  
				  <tr>
					  <td align="right"><label>Authorization #:</label></td>
					  <td align="left"><s:textfield name="ebtList.approve" value="%{ebtList.approve}" size="10" /> </td>
				  </tr>
				  <tr>
					  <td align="right"><label>EBT Amount ($):</label></td>
					  <td align="left"><s:textfield name="ebtList.amount" value="%{ebtList.amount}" size="4" maxlength="4" /> </td>
				  </tr>
				  <tr>
					  <td align="right"><label>Status:</label></td>
					  <td align="left"><s:radio name="ebtList.cancelled" value="%{ebtList.cancelled}" list="#{'-1':'All','n':'Active','y':'Cancelled'}" /> </td>
				  </tr>
				  <tr>
					  <td align="right"><label>Dispute Resolution?</label></td>
					  <td align="left"><s:radio name="ebtList.dispute_resolution" value="%{ebtList.dispute_resolution}" list="#{'-1':'All','n':'No','y':'Yes'}" /> </td>
				  </tr>					
				  <tr>
					  <td align="right"><label>Date:</label></td>
					  <td align="left"><label> From</label><s:textfield name="ebtList.date_from" value="%{ebtList.date_from}" size="10" maxlength="10" cssClass="date" /><label> To </label><s:textfield name="ebtList.date_to" value="%{ebtList.date_to}" size="10" maxlength="10" cssClass="date" /></td>
				  </tr>  
				  <tr>
					  <td align="right"><label>Sort by:</label></td>
					  <td align="left">
						  <s:select name="ebtList.sortBy"
							    value="%{ebtList.sortBy}"
							    list="#{'-1':'ID','e.date_time':'Date & Time'}" headerKey="-1" headerValue="ID" /></td>
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
<s:if test="action != '' && hasEbts()">
  <s:set var="ebts" value="ebts" />
  <s:set var="ebtsTitle" value="ebtsTitle" />
  <%@  include file="ebts.jsp" %>	  
</s:if>
<%@  include file="footer.jsp" %>























































