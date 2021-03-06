
<html>
  <head>
    <meta name="layout" content="members" />

    <title><g:message encodeAs="HTML" code="views.fr.foundation.serviceprovider.show.title" /></title>
  </head>
  <body>
    <h2><g:message encodeAs="HTML" code="views.fr.foundation.serviceprovider.show.heading" args="[serviceProvider.displayName]"/></h2>

    <g:if test="${!serviceProvider.functioning()}">
      <p class="alert alert-message alert-danger">
        <g:message encodeAs="HTML" code="views.fr.foundation.serviceprovider.show.notfunctioning"/>
      </p>
    </g:if>

    <g:render template="/templates/flash" plugin="foundation"/>
    
    <ul class="nav nav-tabs">
      <li class="active"><a href="#tab-overview" data-toggle="tab"><g:message encodeAs="HTML" code="label.overview" /></a></li>
      <li><a href="#tab-categories" data-toggle="tab"><g:message encodeAs="HTML" code="label.categories" /></a></li>
      <li><a href="#tab-contacts" data-toggle="tab"><g:message encodeAs="HTML" code="label.contacts" /></a></li>
      <li><a href="#tab-saml" data-toggle="tab"><g:message encodeAs="HTML" code="label.saml" /></a></li>
      
      <fr:hasAnyPermission in='["federation:management:descriptor:${serviceProvider.id}:reporting" , "federation:management:reporting"]'>
        <li><a href="#tab-reports" data-toggle="tab"><g:message encodeAs="HTML" code="label.reporting" /></a></li>
      </fr:hasAnyPermission>
      <li><a href="#tab-monitors" data-toggle="tab"><g:message encodeAs="HTML" code="label.monitoring" /></a></li>
      <g:if test="${serviceProvider.approved}">
        <li><a href="#tab-admins" data-toggle="tab"><g:message encodeAs="HTML" code="label.administrators" /></a></li>
      </g:if>
    </ul>

    <div class="tab-content">
      
      <div id="tab-overview" class="tab-pane active">
        <g:render template="/templates/serviceprovider/overview" plugin="foundation" model="[descriptor:serviceProvider]" />
      </div>
      
      <div id="tab-categories" class="tab-pane">
        <div id="categories">
          <g:render template="/templates/servicecategories/list" plugin="foundation" model="[descriptor:serviceProvider, categories:serviceProvider.serviceCategories, containerID:'categories']" />
        </div>
        
        <g:render template="/templates/servicecategories/add" plugin="foundation" model="[descriptor:serviceProvider]"/>
      </div>

      <div id="tab-contacts" class="tab-pane">
        <g:render template="/templates/contacts/list" plugin="foundation" model="[host:serviceProvider, hostType:'descriptor']" />
        <g:render template="/templates/contacts/create" plugin="foundation" model="[host:serviceProvider, hostType:'descriptor', contactTypes:contactTypes]" />
      </div>

      <div id="tab-saml" class="tab-pane">
          <div class="tabbable">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#tab-crypto" data-toggle="tab"><g:message encodeAs="HTML" code="label.crypto" /></a></li>
              <li><a href="#tab-endpoints" data-toggle="tab"><g:message encodeAs="HTML" code="label.endpoints" /></a></li>
              <li><a href="#tab-attributes" data-toggle="tab"><g:message encodeAs="HTML" code="label.attributeconsumingservices" /></a></li>
              <li><a href="#tab-nameidformats" data-toggle="tab"><g:message encodeAs="HTML" code="label.supportednameidformats" /></a></li>
              <fr:hasPermission target="federation:management:descriptor:${serviceProvider.id}:manage">
                <li><a href="#tab-metadata"data-toggle="tab"><g:message encodeAs="HTML" code="label.metadata" /></a></li>
              </fr:hasPermission>
            </ul>

            <div class="tab-content">

              <div id="tab-crypto" class="tab-pane active">
                <g:render template="/templates/certificates/list" plugin="foundation" model="[descriptor:serviceProvider, allowremove:true]" />

                <g:render template="/templates/certificates/create" plugin="foundation" model="[descriptor:serviceProvider]"/>
              </div>

              <div id="tab-endpoints" class="tab-pane">
                <div class="tabbable tabs-left">
                  <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-acs" data-toggle="tab">Assertion</a></li>
                    <li><a href="#tab-ars" data-toggle="tab">Artifact</a></li>
                    <li><a href="#tab-slo" data-toggle="tab">Logout</a></li>
                    <li><a href="#tab-drs" data-toggle="tab">Discovery</a></li>
                    <li><a href="#tab-nim" data-toggle="tab">Name ID</a></li>
                  </ul>

                  <div class="tab-content span8">
                    <div id="tab-acs" class="tab-pane active">
                      <g:render template="/templates/endpoints/list" plugin="foundation" model="[endpoints:serviceProvider.assertionConsumerServices, allowremove:true, endpointType:'assertionConsumerServices']" />
                      
                      <g:render template="/templates/endpoints/create" plugin="foundation" model="[descriptor:serviceProvider, endpointType:'assertionConsumerServices', containerID:'assertionconsumerendpoints', indexed:true]" />
                    </div>

                    <div id="tab-ars" class="tab-pane">
                      <g:render template="/templates/endpoints/list" plugin="foundation" model="[endpoints:serviceProvider.artifactResolutionServices, allowremove:true, endpointType:'artifactResolutionServices']" />
                      
                      <g:render template="/templates/endpoints/create" plugin="foundation" model="[descriptor:serviceProvider, endpointType:'artifactResolutionServices', containerID:'artifactendpoints', indexed:true]" />
                    </div>

                    <div id="tab-slo" class="tab-pane">
                      <g:render template="/templates/endpoints/list" plugin="foundation" model="[endpoints:serviceProvider.singleLogoutServices, allowremove:true, endpointType:'singleLogoutServices']" />
                      
                      <g:render template="/templates/endpoints/create" plugin="foundation" model="[descriptor:serviceProvider, endpointType:'singleLogoutServices', containerID:'singlelogoutendpoints']" />
                    </div>

                    <div id="tab-drs" class="tab-pane">
                      <g:render template="/templates/endpoints/list" plugin="foundation" model="[endpoints:serviceProvider.discoveryResponseServices, allowremove:true, endpointType:'discoveryResponseServices']" />
                      
                      <g:render template="/templates/endpoints/create" plugin="foundation" model="[descriptor:serviceProvider, endpointType:'discoveryResponseServices', indexed:true]" />
                    </div>

                    <div id="tab-nim" class="tab-pane">
                      <g:render template="/templates/endpoints/list" plugin="foundation" model="[endpoints:serviceProvider.manageNameIDServices, allowremove:true, endpointType:'manageNameIDServices']" />
                      
                      <g:render template="/templates/endpoints/create" plugin="foundation" model="[descriptor:serviceProvider, endpointType:'manageNameIDServices']" />
                    </div>

                    <g:render template="/templates/endpoints/modals" plugin="foundation" />
                  </div>
                </div>
              </div>

              <div id="tab-attributes" class="tab-pane">
                <g:render template="/templates/acs/list" plugin="foundation" model="[attributeConsumingServices:serviceProvider.attributeConsumingServices]"/>
              </div>

              <div id="tab-nameidformats" class="tab-pane">       
                <g:render template="/templates/nameidformats/list" plugin="foundation" model="[descriptor:serviceProvider, nameIDFormats:serviceProvider.nameIDFormats]" />
                
                <g:render template="/templates/nameidformats/add" plugin="foundation" model="[descriptor:serviceProvider]"/>
              </div>

              <fr:hasPermission target="federation:management:descriptor:${serviceProvider.id}:manage">
                <div id="tab-metadata" class="tab-pane">
                  <g:if test="${serviceProvider.functioning()}">
                    <div class="row">
                    <div class="span8">
                      <p><g:message encodeAs="HTML" code="views.fr.foundation.serviceprovider.show.metadata.details" /></p>
                    </div>
                    <div class="span1 offset1">
                      <a class="load-descriptor-metadata btn btn-info"><g:message encodeAs="HTML" code="label.load" /></a>
                    </div>
                    </div>
                    <pre id="descriptormetadata" class="metadata hidden"></pre>
                  </g:if>
                  <g:else>
                    <div class="alert alert-message">
                      <g:message encodeAs="HTML" code="views.fr.foundation.serviceprovider.show.metadata.unavailable.details" />
                    </div>
                  </g:else>
                </div>
              </fr:hasPermission>
            </div>
          </div>
      </div>

      <fr:hasAnyPermission in='["federation:management:descriptor:${serviceProvider.id}:reporting" , "federation:management:reporting"]'>
        <div id="tab-reports" class="tab-pane">
          <g:render template="/templates/serviceprovider/reporting" model="[spID:serviceProvider.id]" />
        </div>
      </fr:hasAnyPermission>

      <div id="tab-monitors" class="tab-pane">
        <g:render template="/templates/monitor/list" plugin="foundation" model="[roleDescriptor:serviceProvider]" />
        <fr:hasPermission target="federation:management:descriptor:${serviceProvider.id}:manage:monitors">
          <g:render template="/templates/monitor/create" plugin="foundation" model="[descriptor:serviceProvider]" />
        </fr:hasPermission>
      </div>

      <g:if test="${serviceProvider.approved}">
        <div id="tab-admins" class="tab-pane">
          <g:render template="/templates/descriptor/listreportadministration" plugin="foundation" model="[descriptor:serviceProvider]" />
          <hr>
          <g:render template="/templates/descriptor/listfulladministration" plugin="foundation" model="[descriptor:serviceProvider]" />
        </div>
      </g:if>

    </div>

    <r:script>
      var updateServiceProviderEndpoint = "${createLink(controller:'serviceProvider', action:'update', id:serviceProvider.id )}";

      var contactCreateEndpoint = "${createLink(controller:'descriptorContact', action:'create', id:serviceProvider.id )}";
      var contactDeleteEndpoint = "${createLink(controller:'descriptorContact', action:'delete' )}";
      var contactListEndpoint = "${createLink(controller:'descriptorContact', action:'list', id:serviceProvider.id ) }";
      var contactSearchEndpoint = "${createLink(controller:'descriptorContact', action:'search')}";
      
      var acsAddAttr = "${createLink(controller:'attributeConsumingService', action:'addRequestedAttribute')}";
      var acsListAttr = "${createLink(controller:'attributeConsumingService', action:'listRequestedAttributes')}";
      var acsRemoveAttr = "${createLink(controller:'attributeConsumingService', action:'removeRequestedAttribute')}";
      var acsUpdateAttr = "${createLink(controller:'attributeConsumingService', action:'updateRequestedAttribute')}";
      var acsAddSpecAttrVal = "${createLink(controller:'attributeConsumingService', action:'addSpecifiedAttributeValue')}";
      var acsRemoveSpecAttrVal = "${createLink(controller:'attributeConsumingService', action:'removeSpecifiedAttributeValue')}";
      var acsListSpecAttrValues = "${createLink(controller:'attributeConsumingService', action:'listSpecifiedAttributeValue')}";
      
      var certificateListEndpoint = "${createLink(controller:'roleDescriptorCrypto', action:'list', id:serviceProvider.id )}";
      var certificateCreationEndpoint = "${createLink(controller:'roleDescriptorCrypto', action:'create', id:serviceProvider.id)}";
      var certificateDeleteEndpoint = "${createLink(controller:'roleDescriptorCrypto', action:'delete')}";
      var certificateValidationEndpoint = "${createLink(controller:'coreUtilities', action:'validateCertificate')}";
      
      var endpointDeleteEndpoint = "${createLink(controller:'descriptorEndpoint', action:'delete')}";
      var endpointListEndpoint = "${createLink(controller:'descriptorEndpoint', action:'list', id:serviceProvider.id)}";
      var endpointCreationEndpoint = "${createLink(controller:'descriptorEndpoint', action:'create', id:serviceProvider.id)}";
      var endpointToggleStateEndpoint = "${createLink(controller:'descriptorEndpoint', action:'toggle')}";
      var endpointMakeDefaultEndpoint = "${createLink(controller:'descriptorEndpoint', action:'makeDefault')}";
      var endpointEditEndpoint = "${createLink(controller:'descriptorEndpoint', action:'edit')}";
      var endpointUpdateEndpoint = "${createLink(controller:'descriptorEndpoint', action:'update')}";
      
      var nameIDFormatRemoveEndpoint = "${createLink(controller:'descriptorNameIDFormat', action:'remove', id:serviceProvider.id )}";
      var nameIDFormatListEndpoint = "${createLink(controller:'descriptorNameIDFormat', action:'list', id:serviceProvider.id )}";
      var nameIDFormatAddEndpoint = "${createLink(controller:'descriptorNameIDFormat', action:'add', id:serviceProvider.id )}";
      
      var serviceCategoryListEndpoint = "${createLink(controller:'serviceCategory', action:'list', id:serviceProvider.id )}";
      var serviceCategoryAddEndpoint = "${createLink(controller:'serviceCategory', action:'add', id:serviceProvider.id )}";
      var serviceCategoryRemoveEndpoint = "${createLink(controller:'serviceCategory', action:'remove', id:serviceProvider.id )}";
      
      var attributeRemoveEndpoint = "${createLink(controller:'descriptorAttribute', action:'remove', id:serviceProvider.id )}";
      var attributeListEndpoint = "${createLink(controller:'descriptorAttribute', action:'list', id:serviceProvider.id )}";
      var attributeAddEndpoint = "${createLink(controller:'descriptorAttribute', action:'add', id:serviceProvider.id )}";
      
      var searchNewAdministratorsEndpoint = "${createLink(controller:'descriptorAdministration', action:'searchNewAdministrators', id:serviceProvider.id)}";
      var searchNewReportViewersEndpoint = "${createLink(controller:'descriptorAdministration', action:'searchNewReportViewers', id:serviceProvider.id)}";
      var descriptorFullAdministratorGrantEndpoint = "${createLink(controller:'descriptorAdministration', action:'grantFullAdministration', id:serviceProvider.id)}";
      var descriptorFullAdministratorRevokeEndpoint = "${createLink(controller:'descriptorAdministration', action:'revokeFullAdministration', id:serviceProvider.id)}";
      var descriptorFullAdministratorListEndpoint = "${createLink(controller:'descriptorAdministration', action:'listFullAdministration', id:serviceProvider.id)}";
      var descriptorFullAdministratorSearchEndpoint = "${createLink(controller:'descriptorAdministration', action:'searchFullAdministration', id:serviceProvider.id)}";
      
      var monitorDeleteEndpoint = "${createLink(controller:'roleDescriptorMonitor', action:'delete')}";
      var monitorListEndpoint = "${createLink(controller:'roleDescriptorMonitor', action:'list', id:serviceProvider.id )}";
      var monitorCreateEndpoint = "${createLink(controller:'roleDescriptorMonitor', action:'create', id:serviceProvider.id )}";
      
      var descriptorMetadataEndpoint = "${createLink(controller:'metadata', action:'entity', id:serviceProvider.entityDescriptor.id )}";

      var spReportsSessionsEndpoint = "${createLink(controller:'serviceProviderReports', action:'sessionsjson', id:serviceProvider.id)}"
      var spReportsLoginsEndpoint = "${createLink(controller:'serviceProviderReports', action:'loginsjson', id:serviceProvider.id)}"
      var spReportsTotalsEndpoint = "${createLink(controller:'serviceProviderReports', action:'totalsjson', id:serviceProvider.id)}"
      var spReportsConnectivityEndpoint = "${createLink(controller:'serviceProviderReports', action:'connectivityjson', id:serviceProvider.id)}"
    </r:script>
  </body>
</html>
