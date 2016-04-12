<%@  include file="header.jsp" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<h3>Search Voided MB & GC</h3>
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
<s:form action="cancelledSearch" method="post">
  <table border="1" width="80%">
		<tr>
			<td>
				<table width="100%"><caption>
					<tr><td align="right"><label>MB/GC ID:</label></td>
						<td align="left"><s:textfield name="bucksList.id" value="%{bucksList.id}" size="8" /></td>
					</tr>
					<tr>
						<td align="right"><label>Date:</label></td>
						<td align="left"><label> From</label><s:textfield name="bucksList.date_from" value="%{bucksList.date_from}" size="10" maxlength="10" cssClass="date" /><label> To </label><s:textfield name="bucksList.date_to" value="%{bucksList.date_to}" size="10" maxlength="10" cssClass="date" /></td>
					</tr>  
					<tr>
						<td align="right"><label>Sort by:</label></td>
						<td align="left">
							<s:select name="bucksList.sortBy"
												value="%{bucksList.sortBy}"
												list="#{'-1':'ID','b.date_time':'Date & Time'}" headerKey="-1" headerValue="ID" /></td>
					</tr>  
				</table>
			</td>
		</tr>  
		<tr>
			<td align="right">
				<s:submit name="action" type="button" value="Submit" />
			</td>
		</tr>
  </table>
</s:form>
<s:if test="action != ''">
  <s:set var="bucks" value="bucks" />
  <s:set var="bucksTitle" value="bucksTitle" />
  <%@  include file="cancelledBucks.jsp" %>	  
</s:if>
<%@  include file="footer.jsp" %>























































