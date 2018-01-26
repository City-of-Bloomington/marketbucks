<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="giftAdd" method="post" onsubmit="return confirmForCancel()">
  <s:if test="gift.id == ''">
		<h3>Add New Gift Transaction</h3>
  </s:if>
  <s:else>
		<h3>Edit Gift Transaction</h3>
		<s:hidden name="gift.id" value="%{gift.id}" />
		<s:if test="!gift.isCancelled()">
			<ul>
				<li>If the amount is changed, this may cause the removal of all of the GC's that have been added to this transaction.</li>
				<li>if you want to "Cancel" this transaction, first you need to collect all the issued GC's from the customer. Mark them as voided. These GC's can not be issued or redeemed any more. Then click on Cancel.</li>
				<li>If you want to Cancel/Void certain GC's only. Check the corresponding checkbox(es) and then click on "Void Selected GC's".</li>
			</ul>
		</s:if>	
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
  <p>*indicate a required field </p>  
  <table border="1" width="90%">
		<tr><td> 
			<table width="100%">
				<tr>
					<td align="right" width="35%"><label>*Requested Amount:</label></td>
					<td align="left">$<s:textfield name="gift.amount" maxlength="4" size="4" required="true" value="%{gift.amount}" id="div5" cssClass="need_focus" />.00 (Must be divisible by $5)</td>
				</tr>
				<tr>
					<td align="right"><label>*Payment Type:</label></td>
					<td align="left"><s:radio name="gift.pay_type" required="true" value="%{gift.pay_type}" list="{'Cash','Check','Money Order','Credit Card','Honorary'}" /></td>
				</tr>	  
				<tr>
					<td align="right"><label>Check #/RecTrac:</label></td>
					<td align="left"><s:textfield name="gift.check_no" maxlength="20" size="20" value="%{gift.check_no}" /></td>
				</tr>
				<s:if test="gift.isCancelled()">
					<tr>
						<td align="right"><label>Status:</label></td>
						<td align="left">Cancelled</td>
					</tr>
				</s:if>
				<s:if test="ebt.isDispute_resolution()">
					<tr>
						<td align="right">Type:</td><
						td align="left">Dispute Resolution</td>
					</tr>
				</s:if>						
			</table></td>
		</tr>
		<tr>
			<s:if test="gift.id == ''">
				<td valign="top" align="right">
					<s:submit name="action" type="button" id="next_button" value="Next" />
				</td>
			</s:if>
			<s:elseif test="!gift.isCancelled() && !gift.isDispute_resolution()">
				<td>		
					<table width="100%">
						<tr>
							<td align="center">
								<s:submit name="action" type="button" id="update_button" value="Update" />
							</td>
							<td align="right">
								<s:submit name="action" type="button" id="cancel_button" value="Cancel" />
							</td>
						</tr>
					</table>
				</td>		  
			</s:elseif>
		</tr>
		<s:if test="gift.bucks != null && gift.bucks.size() > 0">
			<tr><td align="center">	  
				<table border="1" width="80%"><caption><s:property value="bucksTitle" /></caption>
					<tr>
						<td align="center"><b>**</b></td>
						<td align="center"><b>ID</b></td>
						<td align="center"><b>Expire Date</b></td>
						<td align="center"><b>Voided?</b></td>	
						<td align="center"><b>Face Value</b></td>
					</tr>
					<tr>
						<td colspan="4" align="right">Total</td>
						<td align="right">$<s:property value="gift.bucksTotal" />.00</td>
					</tr>
					<s:iterator var="one" value="gift.bucks">
						<tr>
							<td>&nbsp;
								<s:if test="!isVoided()">
									<input type="checkbox" name="gift.cancel_buck_id" value="<s:property value='id' />" />
								</s:if>
							</td>
							<td><s:property value="id" /></td>
							<td><s:property value="expire_date" /></td>
							<td><s:if test="isVoided()">Voided</s:if></td>	
							<td align="right">$<s:property value="value" />.00</td>
						</tr>
					</s:iterator>
					<tr><td colspan="5">** check to cancel and void the corresponding GC</td></tr>
				</table>
				
			</td></tr>
			<tr>
				<td align="right">
					<s:submit name="action" type="button" id="cancel_button_2" value="Void Selected GC's" />
				</td>
			</tr>
		</s:if>	
  </table>
</s:form>
For gift certificates advance search click<a href="<s:property value='#application.url'/>giftSearch.action"> here. </a>

<s:if test="hasGifts()">
  <s:set var="gifts" value="gifts" />
  <s:set var="giftsTitle" value="giftsTitle" />  
  <%@  include file="gifts.jsp" %>	
</s:if>
<%@  include file="footer.jsp" %>	






































