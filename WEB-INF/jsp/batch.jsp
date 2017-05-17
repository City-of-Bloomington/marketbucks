<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="batchEdit" method="post">    
  <s:if test="batch.id == ''">
		<h3>Generate & Print Bucks</h3>
  </s:if>
  <s:else>
		<s:hidden name="batch.id" value="%{batch.id}" />
		<s:if test="batch.id != '' && batch.status == 'Waiting'">
			<h3>Update Batch</h3>
		</s:if>
		<s:else>
			<h3>Batch Info</h3>	  
		</s:else>
  </s:else>
  <s:hidden name="batch.conf_id" value="%{batch.conf_id}" />  
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
  <p>*indicate a required field</p>
	<s:if test="batch.status == 'Waiting'">
		<s:if test="batch.id != ''">
			<p>Note: Printing Setup<br />
				When create a new batch, before you print please make sure
				the following options are checked on the Printer page after you click on 'Printable Certificates':<br />
				<ul>
					<li>Actual size</li>
					<li>Choose paper source by PDF page size</li>
					<li>Portrait</li>
					<li>any thing else should be unchecked</li>
				</ul>
				We recommend that you print the first page for test purpose, and see if
				the printing is OK before you send the whole batch to printer.
			</p>
		</s:if>
	</s:if>
	
  <table border="1" width="80%">
		<tr><td> 
			<table width="100%">
				<s:if test="batch.id != ''">
					<tr>
						<td align="right"><label>ID:</label></td>
						<td align="left"><s:property value="id" /></td>
					</tr>
				</s:if>
				<tr>
					<td align="right" width="30%"><label>*Number of pages:</label></td>
					<td align="left"><s:textfield name="batch.pages" maxlength="4" size="4" required="true" value="%{batch.pages}" cssClass="need_focus" /> (Each page has 3 MB's or GC's)</td>
				</tr>
				<tr>
					<td align="right" width="30%"><label>*Start seq:</label></td>
					<td align="left"><s:textfield name="batch.start_seq" maxlength="10" size="10" required="true" value="%{batch.start_seq}" /></td>
				</tr>
				<tr>
					<td align="right"><label>Type:</label></td>		
					<td align="left"><s:property value="%{batch.type}" /></td>
				</tr>
				<tr>
					<td align="right"><label>Face value:</label></td>		
					<td align="left">$<s:property value="%{batch.value}" />.00</td>
				</tr>		
				<tr>
					<td align="right"><label>Status:</label></td>
					<td align="left"><s:property value="%{batch.status}" /></td>
				</tr>
				<s:if test="batch.id != ''">				
					<tr>
						<td align="right"><label>Date:</label></td>
						<td align="left"><s:property value="%{batch.date}" /></td>
					</tr>
					<tr>
						<td align="right"><label>User:</label></td>
						<td align="left"><s:property value="%{batch.user}" /></td>
					</tr>		  
				</s:if>
				<s:if test="batch.id != '' && batch.status == 'Waiting'">
					<tr>
						<td colspan="2" align="left">
							Please enter the last printed buck number if different than what is showing.
						</td>
					</tr>
					<tr>
						<td align="right"><label>*Last MB/GC number:</label></td>
						<td align="left"><s:textfield name="batch.last_seq_printed" maxlength="20" size="20" required="true" value="%{batch.end_seq}" /></td>
					</tr>
				</s:if>
			</table></td>
		</tr>
		<tr>
			<td>
				<table width="100%">
					<tr>
						<s:if test="batch.status == 'Waiting'">
							<s:if test="batch.id == ''">
								<s:if test="batch.conf_id != ''">
									<td valign="top" align="right">
										<s:submit name="action" type="button" value="Next" />
									</td>
								</s:if>
							</s:if>
							<s:else>
								<td valign="top" align="center">
									<button onclick="document.location='<s:property value='#application.url' />GenerateChecks.do?id=<s:property value='batch.id' />';return false;">Printable Certificates</button>
								</td>						
								<td valign="top" align="right">Note: Do not Confirm before you print <s:submit name="action" type="button" value="Confirm" />
								</td>
							</s:else>
						</s:if>
						<s:if test="batch.conf_id != '' && batch.status == 'Printed' ">
							<td align="right">
								<button onclick="document.location='<s:property value='#application.url' />batchEdit.action?conf_id=<s:property value='batch.conf_id' />';return false;">Add New Batch</button>
							</td>		
						</s:if>
					</tr>
				</table>
			</td>
		</tr>
		<s:if test="batch.id != '' && batch.seq_list != null">
			<tr><td>
				<table width="100%">
					<caption>Certificate numbers in this batch </caption>
					<tr><td>
						<s:iterator value="batch.seq_list">
							<s:property />
						</s:iterator>
					</td></tr>
				</table>
			</td></tr>
		</s:if>	
  </table>
	
</s:form>

<s:if test="batches != null">
  <s:set var="batches" value="batches" />
  <s:set var="batchesTitle" value="batchesTitle" />  
  <%@  include file="batches.jsp" %>	
</s:if>
<%@  include file="footer.jsp" %>	






































