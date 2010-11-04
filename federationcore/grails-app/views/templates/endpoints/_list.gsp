
<g:if test="${endpoints}">

<g:if test="${!minEndpoints}">
	<g:set var="minEndpoints" value="${0}" />
</g:if>

<table>
	<tbody>
	<g:each in="${endpoints.sort { it.binding.uri }}" status="i" var="ep">
		<tr>
			<td colspan="2"><h4><g:message code="label.endpoint"/> ${i+1}</h4></td>
		</tr>
		<tr>
			<th><g:message code="label.status" /></th>
			<td>
			<g:if test="${ep.active}">
				<div class="icon icon_tick"><g:message code="label.active" /></div>
			</g:if>
			<g:else>
				<div class="icon icon_cross"><g:message code="label.inactive" /></div>
			</g:else>
			</td>
		</tr>
		<tr>
			<th><g:message code="label.approved" /></th>
			<td>
				<g:if test="${ep.approved}">
					<g:message code="label.yes" />
				</g:if>
				<g:else>
					<g:message code="label.no" />
				</g:else>
			</td>
		</tr>
		<tr>
			<th><g:message code="label.location" /></th>
			<td>${ep.location.uri.encodeAsHTML()}</td>
		</tr>
		<g:if test="${resloc}">
			<tr>
				<th><g:message code="label.responselocation" /></th>
				<td colspan="2">${(ep.responseLocation?.uri ?:ep.location.uri).encodeAsHTML()}</td>
			</tr>
		</g:if>
		<g:if test="${ep.instanceOf(fedreg.core.IndexedEndpoint)}">
			<tr>
				<th><g:message code="label.isdefault" /></th>
				<td>
					<g:if test="${ep.isDefault}">
						<g:message code="label.yes" />
					</g:if>
					<g:else>
						<g:message code="label.no" />
					</g:else>
				</td>
			</tr>
		</g:if>
		<tr>
			<th><g:message code="label.binding" /></th>
			<td>${ep.binding.uri.encodeAsHTML()}</td>
			<td/>
		</tr>
		<tr>
			<td colspan="2">
				<n:hasPermission target="descriptor:${ep.descriptor.id}:endpoint:toggle">
					<n:confirmaction action="fedreg.endpoint_toggle(${ep.id}, '${endpointType}', '${containerID}' );" title="${message(code: 'fedreg.template.endpoints.toggle.confirm.title')}" msg="${message(code: 'fedreg.template.endpoints.toggle.confirm.descriptive')}" accept="${message(code: 'label.accept')}" cancel="${message(code: 'label.cancel')}" label="${message(code: 'label.togglestate')}" icon="refresh" />
				</n:hasPermission>
				<g:if test="${ep.instanceOf(fedreg.core.IndexedEndpoint) && !ep.isDefault}">
					<n:hasPermission target="descriptor:${ep.descriptor.id}:endpoint:toggle">
						<n:confirmaction action="fedreg.endpoint_makedefault(${ep.id}, '${endpointType}', '${containerID}' );" title="${message(code: 'fedreg.template.endpoints.makedefault.confirm.title')}" msg="${message(code: 'fedreg.template.endpoints.makedefault.confirm.descriptive')}" accept="${message(code: 'label.accept')}" cancel="${message(code: 'label.cancel')}" label="${message(code: 'label.makedefault')}" icon="pin-s" />
					</n:hasPermission>
				</g:if>
				<n:hasPermission target="descriptor:${ep.descriptor.id}:endpoint:remove">
					<g:if test="${endpoints.size() > minEndpoints}">
						<n:confirmaction action="fedreg.endpoint_delete(${ep.id}, '${endpointType}', '${containerID}' );" title="${message(code: 'fedreg.template.endpoints.remove.confirm.title')}" msg="${message(code: 'fedreg.template.endpoints.remove.confirm.descriptive')}" accept="${message(code: 'label.accept')}" cancel="${message(code: 'label.cancel')}" icon="trash" label="${message(code: 'label.delete')}"/>
					</g:if>
				</n:hasPermission>
			</td>
		</tr>
		<g:if test="${i+1 != endpoints.size()}">
			<tr>
				<td colspan="3"><hr></td>
			</tr>
		</g:if>
	</g:each>
	</tbody>
</table>

</g:if>
<g:else>
	<p class="icon icon_information"><g:message code="fedreg.template.endpoints.noresults"/></p>
</g:else>