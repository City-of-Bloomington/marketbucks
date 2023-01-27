<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<h3>Search Online Purchases (SNAP)</h3>
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
<s:form action="snapSearch" method="post">
	<fieldset> 	
		<dl>
			<dt><label>Purchase ID:</label></dt>
			<dd><s:textfield name="snapList.id" value="%{snapList.id}" size="8" /></dd>
		</dl>
		<dl>
 			<dt><label>Card #:</label></dt>
			<dd><s:textfield name="snapList.cardNumber" value="%{snapList.cardNumber}" size="4" maxlength="4" /> </dd>
		</dl>		  
		<dl>
			<dt><label>Authorization #:</label></dt>
			<dd><s:textfield name="snapList.authorization" value="%{snapList.authorization}" size="10" /> </dd>
		</dl>
		<dl>
			<dt><label>Purchase Amount ($):</label></dt>
			<dd><s:textfield name="snapList.amount" value="%{snapList.amount}" size="4" maxlength="4" /> </dd>
		</dl>
		<dl>
			<dt><label>Double Request:</label></dt>
			<dd><s:radio name="snapList.doubleRequest" value="%{snapList.doubleRequest}" list="#{'-1':'All','Included':'Included','Not Included':'Not Included'}" /> </dd>
		</dl>
		<dl>
			<dt><label>Status:</label></dt>
			<dd><s:radio name="snapList.status" value="%{snapList.status}" list="#{'-1':'All','Active':'Active','Cancelled':'Cancelled'}" /> </dd>
		</dl>		
		<dl>
			<dt><label>Date:</label></dt>
			<dd><label> From</label><s:textfield name="snapList.date_from" value="%{snapList.date_from}" size="10" maxlength="10" cssClass="date" /><label> To </label><s:textfield name="snapList.date_to" value="%{snapList.date_to}" size="10" maxlength="10" cssClass="date" /></dd>
		</dl>  
		<dl>
			<dt><label>Sort by:</label></dt> 
			<dd>
				<s:select name="snapList.sortBy"
					  value="%{snapList.sortBy}"
					  list="#{'-1':'ID','b.date':'Date & Time'}" headerKey="-1" headerValue="ID" /></dd>
		</dl>
		<dl>
			<dd>
				<s:submit name="action" type="button" value="Search" />
			</d>
		</dl>
	</fieldset>
</s:form>
<s:if test="action != '' && hasSnaps()">
	<s:set var="snaps" value="snaps" />
	<s:set var="snapsTitle" value="snapsTitle" />
	<s:set var="snapTotal" value="snapTotal" />
	<s:set var="ebtTotal" value="ebtTotal" />
	<s:set var="dblTotal" value="dblTotal" />	
	<%@  include file="snaps.jsp" %>	  
</s:if>
<%@  include file="footer.jsp" %>























































