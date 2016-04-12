<%@  include file="header.jsp" %>
<!--  
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
 *
	-->
<s:form action="report" method="post">    
  <h3> Marketbucks' Reports</h3>
  <s:if test="hasActionErrors()">
		<div class="errors">
      <s:actionerror/>
	</div>
  </s:if>
  <s:if test="hasActionMessages()">
	<div class="welcome">
      <s:actionmessage/>
	</div>
  </s:if>
  <p>Select one or more of report types.</p>
  <table border="1" width="100%">
		<tr>
			<td>
				<table with="100%">
					<tr>
						<td align="right" valign="top" rowspan="8"><label>Report type:</label></td>
						<td align="left"><s:checkbox name="report.distributeMB" value="report.distributeMB"  />MB Distribution</td>
					</tr>
					<tr>
						<td align="left"><s:checkbox name="report.distributeGC" value="report.distributeGC"  />GC Distribution</td>
					</tr>
					<tr>
						<td align="left"><s:checkbox name="report.redeem" value="report.redeem"  />Redemptions</td>
					</tr>
					<tr>
						<td align="left">
							<s:checkbox name="report.redeemOld" value="report.redeemOld"  />Stats of MB/GC issued in
							<s:select name="report.prev_year" value="%{report.prev_year}" list="years" /> and redeemed in
							<s:select name="report.next_year" value="%{report.next_year}" list="years" /> 			  
						</td>
					</tr>		  
					<tr>
						<td align="left"><s:checkbox name="report.participate" value="report.participate"  />Household participation stats</td>
					</tr>
					<tr>
						<td align="left"><s:checkbox name="report.inventory" value="report.inventory"  />MB & GC current inventory stats (No need to set dates for this option)</td>
					</tr>
					<tr>
						<td align="left"><s:checkbox name="report.issued" value="report.inventory"  />Issued MB & GC</td>
					</tr>
					<tr>
						<td align="left"><s:checkbox name="report.unissued" value="report.inventory"  />Unissued MB & GC (May get long list)</td>
					</tr>		  		  
				</table>
			</td>
		</tr>
		<tr>
			<td align="left">
				<table width="100%">
					<tr>  
						<td align="right"><label>Day</label></td>
						<td align="left"><s:textfield name="report.day" value="%{report.day}" size="10" cssClass="date" />, </td>
					</tr>		
					<tr>  
						<td align="right"><label>Year</label></td>
						<td align="left"><s:select name="report.year" list="years" value="%{report.year}" /> or</td>
					</tr>
					<tr>
						<td align="right"><label>Date, from:</label></td>
						<td align="left"><s:textfield name="report.date_from" maxlength="10" size="10" value="%{report.date_from}" cssClass="date" /><label> To </label><s:textfield name="report.date_to" maxlength="10" size="10" value="%{report.date_to}" cssClass="date" /></td>
					</tr>
				</table>
			</td>
		</tr>	
		<tr>
			<td colspan="2" valign="top" align="right">
				<s:submit name="action" type="button" value="Submit" />
			</td>
		</tr>
  </table>
</s:form>  
<s:if test="action != ''">
  <%@  include file="reportResult.jsp" %>	
</s:if>
<%@  include file="footer.jsp" %>	






































