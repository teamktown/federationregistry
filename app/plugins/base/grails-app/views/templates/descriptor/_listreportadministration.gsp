<div id="descriptorreportadministratorlist">
  <h3><g:message encodeAs="HTML" code="templates.fr.descriptor.report.administrators" default="Report Viewers"/></h3>
  <g:if test="${reportAdministrators}">
    <p><g:message encodeAs="HTML" code="templates.fr.descriptor.report.administrators.detail" default="The following users are able to view reports for this descriptor but otherwise have no administrative control."/>
    <p><strong><g:message encodeAs="HTML" code="templates.fr.descriptor.reportadministrator.obtain" default="To obtain access to reports for this descriptor please contact one of the administrators listed below directly." /></strong></p>
    <table class="table borderless">
      <thead>
        <tr>
          <th><g:message encodeAs="HTML" code="label.name" default="Name"/></th>
          <th><g:message encodeAs="HTML" code="label.organization" default="Organisation"/></th>
          <th/>
        </tr>
      </thead>
      <tbody>
        <g:each in="${reportAdministrators.sort{it.principal}}" var="admin" status="i">
          <tr>
            <td>${fieldValue(bean: admin, field: "cn")}</td>
            <td><g:link controller='organization' action='show' id="${admin.contact?.organization?.id}">${fieldValue(bean: admin, field: "contact.organization.displayName")}</g:link></td>
            <td>
              <fr:hasPermission target="federation:management:descriptor:${descriptor.id}:manage:administrators">
                <g:form controller="descriptorAdministration" action="revokeReportAdministration" method="DELETE">
                  <g:hiddenField name="id" value="${descriptor.id}" />
                  <g:hiddenField name="subjectID" value="${admin.id}" />
                  <a href="#" class="btn btn-small ajax-modal" data-load="${createLink(controller:'subject', action:'showpublic', id:admin.id, absolute:true)}" ><g:message encodeAs="HTML" code="label.quickview" default="Quick View"/></a>
                  <g:submitButton name="submit" value="${message(code: 'label.revoke', default: 'Revoke')}" class="btn" />
                </g:form>
              </fr:hasPermission>
            </td>
          </tr>
        </g:each>
      </tbody>
    </table>
  </g:if>
  <g:else>
    <p class="alert alert-info"><g:message encodeAs="HTML" code="templates.fr.descriptor.reportadministrator.noresults" default="No user has been granted report viewing rights at this time." /></p>
  </g:else>

  <fr:hasPermission target="federation:management:descriptor:${descriptor.id}:manage:administrators">
    <a href="#" class="show-manage-report-viewers btn"><g:message encodeAs="HTML" code="label.addreportmembers" default="Add Viewer"/></a>
    <div id="manage-report-viewers" class="revealable row-spacer"></div>
  </fr:hasPermission>
</div>
