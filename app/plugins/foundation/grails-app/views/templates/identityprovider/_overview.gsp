<div id="overview-identityprovider">
  <g:render template="/templates/identityprovider/overview_editable" plugin="foundation" model="[descriptor:identityProvider]" />
  <fr:hasPermission target="descriptor:${identityProvider.id}:update">
    <a class="show-edit-identityprovider btn btn-info"><g:message code="label.edit"/></a>
  </fr:hasPermission>
</div>
<g:render template="/templates/identityprovider/edit" plugin="foundation" model="[descriptor:identityProvider]" />

<hr>

<div id="internalstate-identityprovider">
  <h4><g:message code="fedreg.templates.identityprovider.overview.internalstate" /></h4>
  <table class="borderless fixed">
    <tbody>   
      <tr>
        <th><g:message code="label.organization"/></th>
        <td><g:link controller="organization" action="show" id="${identityProvider.organization.id}">${fieldValue(bean: identityProvider, field: "organization.displayName")}</g:link></td>
      </tr>
      <fr:hasPermission target="saml:advanced">
        <tr>
          <th><g:message code="label.entitydescriptor"/></th>
          <td><g:link controller="entityDescriptor" action="show" id="${identityProvider.entityDescriptor.id}">${fieldValue(bean: identityProvider, field: "entityDescriptor.entityID")}</g:link></td>
        </tr>
      </fr:hasPermission>
      <n:lacksPermission target="saml:advanced">
        <tr>
          <th><g:message code="label.entitydescriptor"/></th>
          <td>${fieldValue(bean: identityProvider, field: "entityDescriptor.entityID")}</td>
        </tr>
      </n:lacksPermission>
      <tr>
        <th><g:message code="label.protocolsupport"/></th>
        <td>
          <g:each in="${identityProvider.protocolSupportEnumerations}" status="i" var="pse">
          ${fieldValue(bean: pse, field: "uri")}  <br/>
          </g:each>
        </td>
      <g:if test="${identityProvider.errorURL}">
      <tr>
        <th><g:message code="label.errorurl"/></th>
        <td><a href="${identityProvider.errorURL}">${fieldValue(bean: identityProvider, field: "errorURL")}</a></td>
      </tr>
      </g:if>
      <tr>
        <th><g:message code="label.status"/></th>
        <td>
          <g:if test="${identityProvider.active}">
            <g:message code="label.active" />
          </g:if>
          <g:else>
            <g:message code="label.inactive" /> <div class="error"><g:message code="label.warningmetadata" /></div>
          </g:else>
        </td>
      </tr>
      <tr>
        <th><g:message code="label.archived"/></th>
        <td>
          <g:if test="${identityProvider.archived}"> 
            <g:message code="label.yes" /> <div class="alert alert-message"><g:message code="label.warningmetadataarchived" /></div>
          </g:if>
          <g:else>
            <g:message code="label.no" /> 
          </g:else>
        </td>
      </tr>
      <tr>
        <th><g:message code="label.approved"/></th>
        <td>
          <g:if test="${identityProvider.approved}">
            <g:message code="label.yes" />
          </g:if>
          <g:else>
            <g:message code="label.no" /> <div class="alert alert-message alert-danger"><g:message code="label.undergoingapproval" /></div>
          </g:else>
        </td>
      </tr>
      <tr>
        <th><g:message code="label.requiresignedauthn"/></th>
        <td>
          <g:if test="${identityProvider.wantAuthnRequestsSigned}">
            <g:message code="label.yes" />
          </g:if>
          <g:else>
            <g:message code="label.no" />
          </g:else>
        </td>
      </tr>
      <tr>
        <th><g:message code="label.datecreated" /></th>
        <td>${fieldValue(bean: identityProvider, field: "dateCreated")}</td>
      </tr>
      <tr>
        <th><g:message code="label.lastupdated" /></th>
        <td>${fieldValue(bean: identityProvider, field: "lastUpdated")}</td>
      </tr> 
    </tbody>
  </table>
</div>