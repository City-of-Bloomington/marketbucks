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
    <s:actionerror/>
</s:if>
<s:elseif test="hasActionMessages()">
    <s:actionmessage/>
</s:elseif>
<s:form action="batchSearch" method="post">
    <table width="90%" border="0"><caption>Batch Search</caption>
	<tr><td align="right"><label for="batch_id">Batch ID:</label></td>
	    <td align="left"><s:textfield name="batchList.id" value="%{batchList.id}" size="8" id="batch_id" /></td>
		  </tr>
		  <tr><td align="right"><label for="mb_id">MB/GC ID:</label></td>
		      <td align="left"><s:textfield name="batchList.seq_id" value="%{batchList.seq_id}" size="8" id="mb_id" /></td>
		  </tr>
		  <tr>
		      <td align="right"><label for="status">Status:</label></td>
		      <td align="left"><s:radio name="batchList.status" value="%{batchList.status}" list="#{'-1':'All','Printed':'Printed','Waiting':'Waiting'}" headerKey="-1" headerValue="All" id="status" /> </td>
		  </tr>		  
		  <tr>
		      <td align="right"><label for="type">Type:</label></td>
		      <td align="left"><s:radio name="batchList.type_id" value="%{batchList.type_id}" list="buck_types" listKey="id" listValue="name" headerKey="-1" headerValue="All" id="type" /> </td>
		  </tr>
		  <tr>
		      <td align="right"><b>Date:</b></td>
		      <td align="left"><label for="date_from"> From</label><s:textfield name="batchList.date_from" value="%{batchList.date_from}" size="10" maxlength="10" cssClass="date" id="date_from" /><label for="date_to"> To </label><s:textfield name="batchList.date_to" value="%{batchList.date_to}" size="10" maxlength="10" cssClass="date" id="date_to" /></td>
		  </tr>  
		  <tr>
		      <td align="right"><label for="sort_by">Sort by:</label></td>
		      <td align="left">
			  <s:select name="batchList.sortBy" id="sort_by"
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























































