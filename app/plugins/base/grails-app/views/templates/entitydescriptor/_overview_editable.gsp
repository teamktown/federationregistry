<div id="overview-entitydescriptor-editable">
  <table class="table borderless fixed">
    <tbody>
      <tr>
        <th><g:message encodeAs="HTML" code="label.status"/></th>
        <td>
          <g:if test="${entity.active}">
            <g:message encodeAs="HTML" code="label.active" />
          </g:if>
          <g:else>
            <span class="label label-important"><g:message encodeAs="HTML" code="label.inactive" /></span><fr:tooltip code='label.warningmetadata'/>
          </g:else>
        </td>
      </tr>
      <tr>
        <th><g:message encodeAs="HTML" code="label.entitydescriptor"/></th>
        <td>${fieldValue(bean: entity, field: "entityID")}</td>
      </tr>
      <tr>
        <th><g:message encodeAs="HTML" code="label.extensions"/></th>
        <td>
          <g:if test="${entity.extensions}">
            <pre class="metadata">${fieldValue(bean: entity, field: "extensions")}</pre>
          </g:if>
          <g:else>
            <g:message encodeAs="HTML" code="templates.fr.entitydescriptor.noextensions"/>
          </g:else>
        </td>
      </tr>
      <tr></tr>
    </tbody>
  </table>
</div>
