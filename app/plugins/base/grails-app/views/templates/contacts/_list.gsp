<div id="contacts">
  <g:if test="${host.contacts.size() > 0}">
    <table class="table borderless">
      <thead>
        <tr>
          <th><g:message encodeAs="HTML" code="label.name" /></th>
          <th><g:message encodeAs="HTML" code="label.email" /></th>
          <th><g:message encodeAs="HTML" code="label.type" /></th>
          <th/>
        </tr>
      </thead>
      <tbody>
        <g:each in="${host.contacts?.sort{it.contact.surname}}" var="contactPerson" status="i">
          <tr>
            <td>${contactPerson.contact.givenName?.encodeAsHTML()} ${contactPerson.contact.surname?.encodeAsHTML()}</td>
            <td><a href="mailto:${contactPerson.contact.email?.encodeAsHTML()}">${contactPerson.contact.email?.encodeAsHTML()}</a></td>
            <td>${contactPerson.type.displayName.encodeAsHTML()}</td>
            <td>
              <a href="${createLink(controller:'contacts', action:'show', id: contactPerson.contact.id)}" class="btn btn-small"><g:message encodeAs="HTML" code='label.view'/></a>
              <fr:hasAnyPermission in='["federation:management:${hostType}:${host.id}:contact:remove", "federation:management:contacts"]'>
                <a class="confirm-delete-contact btn btn-small" data-contact="${contactPerson.id}"><g:message encodeAs="HTML" code='label.delete'/></a>
              </fr:hasAnyPermission>
            </td>
          </tr>
        </g:each>
      </tbody>
    </table>
  </g:if>
  <g:else>
    <p class="alert alert-message"><g:message encodeAs="HTML" code="templates.fr.contacts.noresults" /></p>
  </g:else>
</div>
