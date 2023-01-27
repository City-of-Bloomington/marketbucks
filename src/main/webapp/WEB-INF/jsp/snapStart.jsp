<%@  include file="header.jsp" %>
<%@ page session="false" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="snap" method="post" id="form_id">
	<h4>New Online Purchase</h4>
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
			<dt><label>*Purchase Amount: </label></dt>
			<dd>$<s:textfield name="snap.snapAmount" maxlength="8" size="8" required="true" value="%{snap.snapAmount}" cssClass="need_focus" />(xx.xx format only)</dd>
			<dt><label>Include Double? </label></dt>
			<dd>
				<s:checkbox name="snap.includeDouble" value="%{snap.includeDouble}" />Yes (uncheck if not included)
			</dd>
		</dl>
		<hr />
		<dl>
			<dd>
				<s:submit name="action" type="button" id="save_button" value="Next" />
			</dd>
		</dl>
		<hr />
</s:form>
<br />
For online purchase search click <a href="<s:property value='#application.url'/>snapSearch.action"> here. </a>
<br />
<s:if test="hasSnaps()">
	<s:set var="snaps" value="snaps" />
	<s:set var="snapsTitle" value="snapsTitle" />
	<s:set var="snapTotal" value="snapTotal" />
	<s:set var="ebtTotal" value="ebtTotal" />
	<s:set var="dblTotal" value="dblTotal" />
	<%@  include file="snaps.jsp" %>	
</s:if>
<%@  include file="footer.jsp" %>	






































