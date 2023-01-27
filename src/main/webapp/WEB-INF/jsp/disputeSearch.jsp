<%@  include file="header.jsp" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="disputeSearch" method="post">    
  <h3>Dispute Search</h3>
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
  <table border="1" width="80%">
	<tr><td> 
	  <table width="100%">
			<tr>
				<td align="right" width="20%"><label>Status:</label></td>
				<td align="left"><s:radio name="disputeList.status" value="%{disputeList.status}" list="#{'-1':'All','Waiting':'Waiting','Rejected':'Rejected','Resolved':'Resolved'}"/></td>
			</tr>
			<tr>
				<td align="right"><label>Reason:</label></td>
				<td align="left"><s:radio name="disputeList.reason" value="%{disputeList.reason}" list="#{'-1':'All','Expired':'Expired','Not Exist':'Do not Exist','Not Issued':'Not Issued','Redeemed':'Already Redeemed'}"/></td>
			</tr>		
			<tr>
				<td align="right"><label>Redeem ID:</label></td>
				<td align="left"><s:textfield name="disputeList.redeem_id" maxlength="10" size="10" value="%{disputeList.redeem_id}" /></td>
			</tr>	  
			<tr>
				<td align="right" valign="top"><label>Date, from:</label></td>
				<td align="left"><s:textfield name="disputeList.date_from" maxlength="10" size="10" value="%{disputeList.date_from}" cssClass="date" /><label> to</label>
					<s:textfield name="disputeList.date_to" maxlength="10" size="10" value="%{disputeList.date_to}" cssClass="date" /></td>
			</tr>
	  </table></td>
	</tr>
	<tr>
	  <td valign="top" align="right">
			<s:submit name="action" type="button" value="Find" />
	  </td>
	</tr>
  </table>
</s:form>

<s:if test="disputes != null && disputes.size() > 0">
  <s:set var="disputes" value="disputes" />
  <s:set var="disputesTitle" value="disputesTitle" />
  <%@  include file="disputes.jsp" %>	
</s:if>
<s:elseif test="action !='' ">
  <p><s:property value="disputesTitle" /></p>
</s:elseif>

<%@  include file="footer.jsp" %>	






































