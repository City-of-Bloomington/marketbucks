<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<h3>Search FMNP transactions</h3>
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
<s:form action="fmnpSearch" method="post">
    <hr />
    <fieldset>
	<table width="90%" border="0">
	    <tr>
		<td align="right"><label>Transaction ID:</label></td>
		<td align="left"><s:textfield name="fmnp.id" value="%{fmnp.id}" size="8" /></td>
	    </tr>
	    <tr>
 		<td align="right"><label>Ticket #:</label></td>
		<td align="left"><s:textfield name="fmnp.ticketNum" value="%{fmnp.ticketNum}" size="10" maxlength="10" /> </td>
	    </tr>
	    <tr>
		<td align="right"><label>Amount ($):</label></td>
		<td align="left"><s:textfield name="fmnp.amount" value="%{fmnp.amount}" size="4" maxlength="4" /> </td>
	    </tr>
	    <tr>
		<td align="right"><label>FMNP Type:</label></td>
		<td align="left"><s:radio name="fmnp.type" value="%{fmnp.type}" list="#{'-1':'All','wic':'WIC','senior':'Senior'}" /> </td>
	    </tr>
	    <tr>
		<td align="right"><label>Status:</label></td>
		<td align="left"><s:radio name="fmnp.status" value="%{fmnp.status}" list="#{'-1':'All','Active':'Active','Cancelled':'Cancelled'}" /> </td>
	    </tr>
	    <tr>
		<td align="right"><label>Date:</label></td>
		<td align="left"><label> From</label><s:textfield name="fmnp.date_from" value="%{fmnp.date_from}" size="10" maxlength="10" cssClass="date" /><label> To </label><s:textfield name="fmnp.date_to" value="%{fmnp.date_to}" size="10" maxlength="10" cssClass="date" /></td>
	    </tr>
	    <tr>
		<td align="right"><label>Sort by:</label></td> 
		<td align="left">
		    <s:select name="fmnp.sortBy"
			      value="%{fmnp.sortBy}"
			      list="#{'-1':'ID','date':'Date & Time'}" headerKey="-1" headerValue="ID" /></td>
	    </tr>
	    <tr>
		<td colspan="2">
		    <s:submit name="action" type="button" value="Search" />
		</td>
	    </tr>
	</table>
    </fieldset>
    <hr />
</s:form>
<s:if test="action != '' && hasWics()">
    <s:set var="fmnpWics" value="wics" />
    <s:set var="fmnpWicsTitle" value="wicsTitle" />
    <s:set var="fmnpWicsTotal" value="wicsTotal" />
    <%@  include file="fmnpWics.jsp" %>	  
</s:if>
<s:if test="action != '' && hasSeniors()">
    <s:set var="fmnpSeniors" value="seniors" />
    <s:set var="fmnpSeniorsTitle" value="seniorsTitle" />
    <s:set var="fmnpSeniorsTotal" value="seniorsTotal" />
    <%@  include file="fmnpSeniors.jsp" %>	  
</s:if>
<%@  include file="footer.jsp" %>























































