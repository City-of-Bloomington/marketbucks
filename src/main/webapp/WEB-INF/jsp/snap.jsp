<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="snap" method="post" id="form_id" onsubmit="return confirmForCancel()">
  <s:if test="snap.id == ''">
	  <h4>New Online Purchase</h4>
  </s:if>
  <s:else>
	  <h3>Edit Online Purchase</h3>
	  <p>Note: if you make a mistake you can Update the record or Cancel.
		  If Cancelled the record will not be deleted but marked as
		  Cancelled (Inactive)</p>
	  <s:hidden name="snap.id" value="%{snap.id}" />
	  <s:hidden name="snap.dblMax" value="%{snap.dblMax}" />
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
  <fieldset>
	  <dl>
		  <dt><label>*Purchase Amount: </label></dt>
		  <dd>$<s:textfield name="snap.snapAmount" maxlength="8" size="8" required="true" value="%{snap.snapAmount}" cssClass="need_focus" />(xx.xx format only)</dd>
		  <dt><label>Include Double:</label></dt>
		  <dd>
			  <s:checkbox name="snap.includeDouble" value="%{snap.includeDouble}" />Yes (uncheck if not included)
		  </dd>		  
		  <dt><label>*Customer Card #: </label></dt>
		  <dd><s:textfield name="snap.cardNumber" maxlength="4" size="4" required="true" value="%{snap.cardNumber}" /></dd>
		  <dt><label>*Authorization #: </label></dt>
		  <dd><s:textfield name="snap.authorization" maxlength="10" size="10" required="true" value="%{snap.authorization}" /></dd>
		  <dt><label>Ebt Amount: </label></dt>
		  <dd>$<s:property value="snap.ebtAmount" /></dd>
		  
	  <s:if test="snap.canDouble()">
		  <dt><label>Dbl Amount: </label></dt>
		  <dd>$<s:property value="snap.dblAmount" /></dd>
	  </s:if>
	  <s:else>
		  <dt><label>Dbl Amount: </label></dt>
		  <dd>No Double</dd>
	  </s:else>
	  <s:if test="snap.isCancelled()">
		  <dt><label>Status: </label></dt>
		  <dd>Cancelled</dd>
	  </s:if>
	  <s:if test="snap.hasUser()">
		  <dt><label>User: </label></dt>
		  <dd><s:property value="snap.user" /></dd>
	  </s:if>			  
	  <s:if test="snap.id == ''">
		  <dd>
			  <s:submit name="action" type="button" value="Save" />
		  </dd>
	  </s:if>
	  <s:elseif test="!snap.isCancelled()">
		  <dt><label>Date: </label></dt>
		  <dd><s:textfield name="snap.date" maxlength="10" size="10" required="true" value="%{snap.date}" cssClass="date" /> Time:<s:textfield name="snap.time" maxlength="5" size="5" required="true" value="%{snap.time}" /></dd>
	  	  <dd>
			  <s:submit name="action" type="button" id="update_button" value="Update" /> &nbsp;
			  <s:submit name="action" type="button"  id="cancel_button" value="Cancel" />
		  </dd>
	  </s:elseif>
	  </dl> 
  </fielset>
</s:form>
<br />

<%@  include file="footer.jsp" %>	






































