<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="ebtAdd" method="post" id="form_id" onsubmit="return confirmForCancel()">
  <s:if test="ebt.id == ''">
	  <h4>Issue Ebt Market Bucks</h4>
  </s:if>
  <s:else>
	  <h3>Edit Ebt Market Bucks Request</h3>
	  <s:hidden name="ebt.id" value="%{ebt.id}" />
	  <s:hidden name="ebt.ebt_donor_max" value="%{ebt.ebt_donor_max}" />
	  <s:hidden name="ebt.ebt_buck_value" value="%{ebt.ebt_buck_value}" />
	  <s:if test="!ebt.isCancelled()">
		  <ul>
			  <li>If the amount is changed, this may cause the removal of all of the bucks that have been added to this transaction.</li>
			  <li>if you want to "Cancel" this transaction, first you need to collect all the issued MB's from the customer. Mark them as voided. These MB's can not be issued or redeemed any more. Then click on Cancel.</li>
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
  <p>*indicates a required field</p>
	<hr />
	<dl>
		<dd><label>Transaction ID: </label><s:property value="ebt.id" /></dd>
		<dt><label>*EBT Amount:</label></dt>
		<dd>$ <s:textfield name="ebt.amount" maxlength="4" size="4" required="true" value="%{ebt.amount}" id="div3" cssClass="need_focus" />.00 (Must be multiple of 3 ($))</dd>
		<dt><label>*Authorization #:</label></dt>
		<dd><s:textfield name="ebt.approve" maxlength="20" size="20" required="true" value="%{ebt.approve}" /></dd>
		<dt><label>*Customer Card #:</label></dt>
		<dd><s:textfield name="ebt.card_last_4" maxlength="4" size="4" required="true" value="%{ebt.card_last_4}" /></dd>
		<dt><label>Include Double? </label></dt>
		<dd><s:checkbox name="ebt.includeDouble" value="%{ebt.includeDouble}" />Yes (uncheck if not included)</dd>
		<s:if test="ebt.isCancelled()">
			<dt><label>Status: </label></dt>
			<dd>Cancelled</dd>
		</s:if>
		<s:if test="ebt.isDispute_resolution()">
			<dt><label>Status: </label></dt>
			<dd>In Dispute</dd>
		</s:if>
	</dl>
	<hr />
	<dl>
		<s:if test="ebt.id == ''">
			<dd valign="top" align="right">
					<s:submit name="action" type="button" value="Next" id="next_button" />
			</dd>
		</s:if>
		<s:elseif test="!ebt.isCancelled() && !ebt.isDispute_resolution()">
			<dd>
				<s:submit name="action" type="button" id="update_button" value="Update" />
				<s:submit name="action" type="button"  id="cancel_button" value="Cancel" />
			</dd>
		</s:elseif>
	</dl>
	<hr />
</s:form>
<br />
For issued market bucks search click<a href="<s:property value='#application.url'/>ebtSearch.action"> here. </a>
<br />
For any (issued /unissued) MB/GC search click<a href="<s:property value='#application.url'/>buckSearch.action"> here. </a> <br />

<s:if test="ebt.id == ''">
	<s:if test="hasEbts()">
		<s:set var="ebts" value="ebts" />
		<s:set var="ebtsTitle" value="ebtsTitle" />  
		<%@  include file="ebts.jsp" %>	
	</s:if>
</s:if>
<%@  include file="footer.jsp" %>	






































