<%@  include file="header.jsp" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="disputeEdit" method="post">
	<s:if test="dispute.canEdit()">
		<h3>Edit Dispute</h3>
	</s:if>
	<s:else>
		<h3>View Dispute</h3>
	</s:else>
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
  <s:hidden name="dispute.id" value="%{dispute.id}" />
  <s:if test="dispute.status == 'Waiting'">
		<ul>
			<li>if you think this case can not be resolved, change the status to "Rejected' and then click on 'Update'.</li>
			<li>if you think this was a mistake, click on 'Delete'</li>
			<li>Otherwise click on 'Resolution' to resolve this case.</li>
		</ul>
  </s:if>
  <table border="1" width="90%">
		<tr><td> 
			<table width="100%">
				<tr>
					<td align="right"><label>Redeem:</label></td>
					<td><a href="<s:property value='#application.url' />redeemEdit.action?id=<s:property value='dispute.redeem_id' />">View <s:property value="dispute.redeem_id" /></a></td>		  
				</tr>
				<tr>
					<td align="right"><label>Buck ID:</label></td>
					<td align="left"><s:property value="dispute.buck_id" /></td>
				</tr>
				<s:if test="dispute.canEdit()">
					<tr><td colspan="2"><label> Invoice Notes:</label> (the text entered here will show on vendor&#39;s invoice)</td></tr>
					<tr>
						<td align="right" valign="top"><label></label></td>
						<td align="left"><s:textarea name="dispute.notes" value="%{dispute.notes}" rows="5" cols="70" /></td>
					</tr>
				</s:if>
				<s:elseif test="dispute.hasNotes()">
					<tr><td colspan="2"><label> Invoice Notes: </label>(the text entered here will show on vendor&#39;s invoice)</td></tr>					
					<tr>
						<td align="right" valign="top"><label></label></td>
						<td align="left"><s:property value="%{dispute.notes}" /></td>
					</tr>
				</s:elseif>
				<tr>
					<td align="right" width="35%"><label>Status:</label></td>
					<td align="left">
						<s:if test="dispute.status == 'Resolved'">
							Resolved
						</s:if>
						<s:else>
							<s:radio name="dispute.status" value="%{dispute.status}" list="{'Waiting','Rejected'}" />
						</s:else>
					</td>
				</tr>
				<tr>
					<td align="right" valign="top"><label>Reason:</label></td>
					<td align="left"><s:property value="dispute.reason" /></td>
				</tr>
				<tr>
					<td align="right" valign="top"><label>User:</label></td>
					<td align="left"><s:property value="dispute.user" /></td>
				</tr>
				<tr>
					<td align="right" valign="top"><label>Date & Time:</label></td>
					<td align="left"><s:property value="dispute.date_time" /></td>
				</tr>		
			</table></td>
		</tr>
		<tr>
			<td>
				<table width="100%">
					<tr>
						<s:if test="dispute.status == 'Waiting'">
							<td align="left">
								<s:submit name="action" type="button" value="Update" />
							</td>
							<td align="center">
								<s:submit name="action" type="button" value="Delete" />
							</td>			  
						</s:if>
						<td align="right">
							<s:if test="dispute.hasResolution()">			  
								<button onclick="document.location='<s:property value='#application.url' />resolutionView.action?id=<s:property value='dispute.resolution.id' />';return false;">View Resolution</button>
							</s:if>
							<s:else>
								<button onclick="document.location='<s:property value='#application.url' />resolutionEdit.action?dispute_id=<s:property value='dispute.id' />';return false;">Start Resolution</button>			  
							</s:else>
						</td>
					</tr>
				</table>
			</td>
		</tr>
  </table>
</s:form>

<s:if test="disputes != null && disputes.size() > 0">
  <s:set var="disputes" value="disputes" />
  <s:set var="disputesTitle" value="disputesTitle" />  
  <%@  include file="disputes.jsp" %>	
</s:if>
<%@  include file="footer.jsp" %>	






































