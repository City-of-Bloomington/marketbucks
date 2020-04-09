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
  <table border="1" width="80%">
	  <tr><td> 
		  <table width="100%">
			  <tr>
				  <td align="right" width="35%"><label>*Online Purchase Amount:</label></td>
				  <td align="left">$<s:textfield name="snap.snapAmount" maxlength="8" size="8" required="true" value="%{snap.snapAmount}" cssClass="need_focus" />(xx.xx format only)</td>
			  </tr>
			  <tr>
				  <td align="right"><label>*Customer Card #:</label></td>
				  <td align="left"><s:textfield name="snap.cardNumber" maxlength="4" size="4" required="true" value="%{snap.cardNumber}" /></td>
			  </tr>			  
			  <tr>
				  <td align="right"><label>*Authorization #:</label></td>
				  <td align="left"><s:textfield name="snap.authorization" maxlength="10" size="10" required="true" value="%{snap.authorization}" /></td>
			  </tr>	  

			  <tr>
				  <td align="right"><label>Ebt Amount:</label></td>
				  <td align="left">$<s:property value="snap.ebtAmount" /></td>
			  </tr>
			  <tr>
				  <td align="right"><label>Dbl Amount:</label></td>
				  <td align="left">$<s:property value="snap.dblAmount" /></td>
			  </tr>				  
			  <s:if test="snap.isCancelled()">
				  <tr>
					  <td align="right"><label>Status:</label></td>
					  <td align="left">Cancelled</td>
				  </tr>
			  </s:if>
		  </table></td>
		</tr>
		<s:if test="snap.id == ''">
			<tr>		
				<td valign="top" align="right">
					<s:submit name="action" type="button" value="Save" />
				</td>
			</tr>
		</s:if>
		<s:elseif test="!snap.isCancelled()">
			<tr>		
				<td valign="top">	  
					<table width="100%">
						<tr>
							<td align="center">
								<s:submit name="action" type="button" id="update_button" value="Update" />
							</td>
							<td align="right">
								<s:submit name="action" type="button"  id="cancel_button" value="Cancel" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</s:elseif>
  </table>
</s:form>
<br />

<%@  include file="footer.jsp" %>	






































