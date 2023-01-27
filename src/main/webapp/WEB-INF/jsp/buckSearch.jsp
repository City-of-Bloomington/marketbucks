<%@  include file="header.jsp" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<h3>Search Market Bucks or GC</h3>
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
<s:form action="buckSearch" method="post">
  <table border="1" width="80%">
		<tr>
			<td>
				<table width="100%">
					<tr><td align="right"><label>MB or GC ID:</label></td>
						<td align="left"><s:textfield name="buckList.id" value="%{buckList.id}" size="8" /></td>
					</tr>
					<tr><td align="right"><label>Status:</label></td>
						<td align="left"><s:radio name="buckList.type" value="%{buckList.type}" list="#{'-1':'All','issued':'Issued','unissued':'Unissued'}" /></td>
					</tr>					
					<tr><td align="right"><label>Batch ID:</label></td>
						<td align="left"><s:textfield name="buckList.batch_id" value="%{buckList.batch_id}" size="8" /></td>
					</tr>
					<tr>
						<td align="right"><label>Printed Batch Date:</label></td>
						<td align="left"><label> From</label><s:textfield name="buckList.date_from" value="%{buckList.date_from}" size="10" maxlength="10" cssClass="date" /><label> To </label><s:textfield name="buckList.date_to" value="%{buckList.date_to}" size="10" maxlength="10" cssClass="date" /></td>
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
<s:if test="action != '' && bucks != null">
  <s:set var="bucks" value="bucks" />
  <s:set var="bucksTitle" value="bucksTitle" />
  <%@  include file="bucksView.jsp" %>	  
</s:if>
<s:else>
	<b>Other search options </b>
	<ul>
		<li><a href="<s:property value='#application.url'/>snapSearch.action"> Online Purchase Search </a></li>
		<li><a href="<s:property value='#application.url'/>ebtSearch.action"> Ebt Search </a></li>
		<li><a href="<s:property value='#application.url'/>fmnpSearch.action"> FMNP WIC/Senior Search </a></li>		
		<li><a href="<s:property value='#application.url'/>giftSearch.action">Gift certificate search. </a></li>
		<li><a href="<s:property value='#application.url'/>rxSearch.action">Market Rx search. </a></li>		
		<li><a href="<s:property value='#application.url'/>redeemSearch.action"> Redemption Search </a></li>
		<li><a href="<s:property value='#application.url'/>batchSearch.action"> MB batch search </a> </li>
	</ul>
</s:else>
<%@  include file="footer.jsp" %>























































