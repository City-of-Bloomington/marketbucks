<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<h3>Search Batches</h3>
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
<s:form action="batchSearch" method="post">
  <table border="1" width="80%">
		<tr>
			<td>
				<table width="100%"><caption>
					<tr><td align="right"><label>Batch ID:</label></td>
						<td align="left"><s:textfield name="batchList.id" value="%{batchList.id}" size="8" /></td>
					</tr>
					<tr><td align="right"><label>MB/GC ID:</label></td>
						<td align="left"><s:textfield name="batchList.seq_id" value="%{batchList.seq_id}" size="8" /></td>
					</tr>
					<tr>
						<td align="right"><label>Status:</label></td>
						<td align="left"><s:radio name="batchList.status" value="%{batchList.status}" list="#{'-1':'All','Printed':'Printed','Waiting':'Waiting'}" headerKey="-1" headerValue="All" /> </td>
					</tr>		  
					<tr>
						<td align="right"><label>Type:</label></td>
						<td align="left"><s:radio name="batchList.type_id" value="%{batchList.type_id}" list="buck_types" listKey="id" listValue="name" headerKey="-1" headerValue="All" /> </td>
					</tr>
					<tr>
						<td align="right"><label>Date:</label></td>
						<td align="left"><label> From</label><s:textfield name="batchList.date_from" value="%{batchList.date_from}" size="10" maxlength="10" cssClass="date" /><label> To </label><s:textfield name="batchList.date_to" value="%{batchList.date_to}" size="10" maxlength="10" cssClass="date" /></td>
					</tr>  
					<tr>
						<td align="right"><label>Sort by:</label></td>
						<td align="left">
							<s:select name="batchList.sortBy"
												value="%{batchList.sortBy}"
												list="#{'-1':'ID','b.date':'Date','b.start_seq':'Start Seq'}" headerKey="-1" headerValue="ID" /></td>
					</tr>  
				</table>
			</td>
		</tr>  
		<tr>
			<td>
				<table width="100%">
					<tr>
						<td align="center">
							<s:submit name="action" type="button" value="Printable Audit Sheet" />
						</td>			
						<td align="right">
							<s:submit name="action" type="button" value="Search" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
  </table>
</s:form>
<s:if test="action != ''">
  <s:set var="batches" value="batches" />
  <s:set var="batchesTitle" value="batchesTitle" />
  <%@  include file="batches.jsp" %>	  
</s:if>
<%@  include file="footer.jsp" %>























































