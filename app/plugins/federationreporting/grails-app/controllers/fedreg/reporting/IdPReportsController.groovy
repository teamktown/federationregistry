package fedreg.reporting

import org.apache.shiro.SecurityUtils

import fedreg.core.*
import grails.plugins.nimble.core.Role
import grails.plugins.nimble.core.LoginRecord

import grails.converters.JSON

/**
 * Provides IdP reporting data
 *
 * @author Bradley Beddoes
 */
class IdPReportsController {

	def view = {
		def idpList = IDPSSODescriptor.listOrderByDisplayName()
		[idpList:idpList]
	}
	
	def loginsjson = {

		if(!params.id) {
			log.warn "IdP was not present"
			render message(code: 'fedreg.controllers.namevalue.missing')
			response.setStatus(500)
			return
		}
		def idp = IDPSSODescriptor.get(params.id)
		if (!idp) {
			render message(code: 'fedreg.core.idpssoroledescriptor.nonexistant')
			response.setStatus(500)
			return
		}
			
		if(SecurityUtils.subject.isPermitted("descriptor:${idp.id}:reporting") || SecurityUtils.subject.isPermitted("federation:reporting")) {
			def year, month, day, min, max
			year = params.int('year')
			if(!year) {
				def cal = Calendar.instance
				year = cal.get(Calendar.YEAR)
			}
			month = params.int('month')
			if(month)
				day = params.int('day')

			def maxLogins = 0
			def results = [:]
			def logins = []
			results.logins = logins

			results.title = "${g.message(code:'fedreg.templates.reports.identityprovider.logins.title', args:[idp.displayName])} ${day ? day + ' /':''} ${month ? month + ' /':''} $year"
		
			def loginsQuery = new StringBuilder("select count(*) as count, hour(date_created) as hour from WayfAccessRecord where idpid = :idpid and year(dateCreated) = :year")
			def loginsParams = [:]
			loginsParams.idpid = idp.id
			loginsParams.year = year

			if(month) {
				loginsQuery << " and month(dateCreated) = :month"
				loginsParams.month = month
			}
			if(day) {
				loginsQuery << " and day(dateCreated) = :day"
				loginsParams.day = day
			}
		
			loginsQuery << " group by hour(date_created)"
		
			def totalLogins = WayfAccessRecord.executeQuery(loginsQuery.toString(), loginsParams)
			if(totalLogins.size() == 0)
				results.populated = false
			else
				results.populated = true

			totalLogins.each {
				def login = [:]
				login.count = it[0]
				login.hour = it[1]
				
				if(maxLogins < login.count)
					maxLogins = login.count
				
				logins.add(login)
			}
			results.maxlogins = maxLogins
		
			render results as JSON
		}
		else {
			log.warn("Attempt to query logins json for $idp by $authenticatedUser was denied, incorrect permission set")
			render message(code: 'fedreg.help.unauthorized')
			response.setStatus(403)
		}
	}
	
	def sessionsjson = {
		if(!params.id) {
			log.warn "IdP was not present"
			render message(code: 'fedreg.controllers.namevalue.missing')
			response.setStatus(500)
			return
		}
		
		def idp = IDPSSODescriptor.get(params.id)
		if (!idp) {
			render message(code: 'fedreg.core.idpssoroledescriptor.nonexistant')
			response.setStatus(500)
			return
		}
		if(SecurityUtils.subject.isPermitted("descriptor:${idp.id}:reporting")  || SecurityUtils.subject.isPermitted("federation:reporting")) {
			def year, month, day
		
			year = params.int('year')
			if(!year) {
				def cal = Calendar.instance
				year = cal.get(Calendar.YEAR)
			}
			month = params.int('month')
			if(month)
				day = params.int('day')
				
			def activeSP = params.activesp as List
			def count = 0, maxLogins = 0, totalLogins
			def results = [:]
			def sessions = []
		
			results.sessions = sessions
			results.title = "${g.message(code:'fedreg.templates.reports.identityprovider.sessions.title', args:[idp.displayName])} ${day ? day + ' /':''} ${month ? month + ' /':''} $year"
			
			def sessionsQuery
			def sessionsParams = [:]
			sessionsParams.idpID = idp.id
			sessionsParams.year = year
			if(day) {
				sessionsQuery = "select count(*), hour(dateCreated) from WayfAccessRecord where idpID = :idpID and year(dateCreated) = :year and month(dateCreated) = :month and day(dateCreated) = :day group by hour(dateCreated)"
				sessionsParams.month = month
				sessionsParams.day = day
			} else {
				if(month) {
					sessionsQuery = "select count(*), day(dateCreated) from WayfAccessRecord where idpID = :idpID and year(dateCreated) = :year and month(dateCreated) = :month group by day(dateCreated)"
					sessionsParams.month = month
				} else {
					sessionsQuery = "select count(*), month(dateCreated) from WayfAccessRecord where idpID = :idpID and year(dateCreated) = :year group by month(dateCreated)"	
				}
			}

			def sessionCount = WayfAccessRecord.executeQuery(sessionsQuery, sessionsParams)
			sessionCount.each { s ->
				def session = [:]
				session.count = s[0]
				
				if(maxLogins < session.count)
					maxLogins = session.count
				
				session.date = s[1]
				
				sessions.add(session)
			}

			if(sessionCount.size() > 0)
				results.populated = true
			else
				results.populated = false
				
			results.maxlogins = maxLogins
		
			render results as JSON
		}
		else {
			log.warn("Attempt to query totals json for $idp by $authenticatedUser was denied, incorrect permission set")
			render message(code: 'fedreg.help.unauthorized')
			response.setStatus(403)
		}
	}
	
	def totalsjson = {
		if(!params.id) {
			log.warn "IdP was not present"
			render message(code: 'fedreg.controllers.namevalue.missing')
			response.setStatus(500)
			return
		}
		
		def idp = IDPSSODescriptor.get(params.id)
		if (!idp) {
			render message(code: 'fedreg.core.idpssoroledescriptor.nonexistant')
			response.setStatus(500)
			return
		}
		if(SecurityUtils.subject.isPermitted("descriptor:${idp.id}:reporting")  || SecurityUtils.subject.isPermitted("federation:reporting")) {
			def year, month, day, min, max
		
			year = params.int('year')
			if(!year) {
				def cal = Calendar.instance
				year = cal.get(Calendar.YEAR)
			}
			month = params.int('month')
			if(month)
				day = params.int('day')
		
			min = params.int('min')	
			max = params.int('max')
			
			def activeSP = params.activesp as List
		
			def count = 0, maxSessions = 0, totalSessions = 0
			def results = [:]
			def services = []
			def values = []
			def valueLabels = []
		
			results.title = "${g.message(code:'fedreg.templates.reports.identityprovider.totals.title', args:[idp.displayName])} ${day ? day + ' /':''} ${month ? month + ' /':''} $year"
	
			// We remove any SP with a -1 id as this indicates the SP could not be determined at record creation time
			def serviceSessionsQuery = new StringBuilder("select count(*), spID from WayfAccessRecord where spID != -1 and idpID = :idpid and year(dateCreated) = :year")
			def serviceSessionsParams = [:]
			serviceSessionsParams.idpid = idp.id
			serviceSessionsParams.year = year
		
			if(month) {
				serviceSessionsQuery << " and month(dateCreated) = :month"
				serviceSessionsParams.month = month
			}
			if(day) {
				serviceSessionsQuery << " and day(dateCreated) = :day"
				serviceSessionsParams.day = day
			}
		
			serviceSessionsQuery << " group by spID order by count(spID) desc"
		
			def serviceSessions = WayfAccessRecord.executeQuery(serviceSessionsQuery.toString(), serviceSessionsParams)
			serviceSessions.each { ss ->
				def sp = SPSSODescriptor.get(ss[1])
				if(sp) {
					def service = [:]
					service.name = sp.displayName
					service.id = sp.id
					service.count = ss[0]
					services.add(service)
					totalSessions = totalSessions + service.count
		
					if((activeSP == null || activeSP.contains(sp.id.toString())) && (!min || service.count >= min) && (!max || service.count <= max)) {
						service.rendered = true
						values.add(service.count)
						valueLabels.add(sp.displayName)
				
						if(maxSessions < service.count)
							maxSessions = service.count
						count++
					}
					else
						service.rendered = false
				}
			}

			results.services = services.sort{it.get('name').toLowerCase()}
			results.maxsessions = maxSessions
			results.totalsessions = totalSessions
			results.servicecount = count
			results.values = values
			results.valuelabels = valueLabels
		
			if(count > 0)
				results.populated = true
			else
				results.populated = false
		
			render results as JSON
		}
		else {
			log.warn("Attempt to query totals json for $idp by $authenticatedUser was denied, incorrect permission set")
			render message(code: 'fedreg.help.unauthorized')
			response.setStatus(403)
		}
	}
	
	def connectivityjson = {
		if(!params.id) {
			log.warn "IdP was not present"
			render message(code: 'fedreg.controllers.namevalue.missing')
			response.setStatus(500)
			return
		}
		
		def idp = IDPSSODescriptor.get(params.id)
		if (!idp) {
			render message(code: 'fedreg.core.idpssoroledescriptor.nonexistant')
			response.setStatus(500)
			return
		}
		if(SecurityUtils.subject.isPermitted("descriptor:${idp.id}:reporting") || SecurityUtils.subject.isPermitted("federation:reporting")) {
			def year, month, day
		
			year = params.int('year')
			if(!year) {
				def cal = Calendar.instance
				year = cal.get(Calendar.YEAR)
			}
			month = params.int('month')
			if(month)
				day = params.int('day')
		
			def activeSP = params.activesp as List
		
			def target = 1
			def results = [:]
			def services = []
			def nodes = []
			def links = []
		
			results.nodes = nodes
			results.links = links
			results.title = "${g.message(code:'fedreg.templates.reports.identityprovider.connectivity.title', args:[idp.displayName])} ${day ? day + ' /':''} ${month ? month + ' /':''} $year"

			def totalQuery = new StringBuilder("select count(*) as count from WayfAccessRecord where idpid = :idpid and year(dateCreated) = :year")
			def totalParams = [:]
			totalParams.idpid = idp.id
			totalParams.year = year

			if(month) {
				totalQuery << " and month(dateCreated) = :month"
				totalParams.month = month
			}
			if(day) {
				totalQuery << " and day(dateCreated) = :day"
				totalParams.day = day
			}
			if(activeSP) {
				totalQuery << " and spid in (:activeSP)"
				totalParams.activeSP = activeSP
			}
		
			def totalSessions = WayfAccessRecord.executeQuery(totalQuery.toString(), totalParams)
			if(totalSessions[0] > 0) {
				results.populated = true
			
				def val = 0
				if(idp) {
					def node = [:]
					node.nodeName = idp.displayName
					node.group = 1
					nodes.add(node)
				}
					// We remove any SP with a -1 id as this indicates the SP could not be determined at record creation time
					def sessionsQuery = new StringBuilder("select count(*), spID from WayfAccessRecord where spID != -1 and idpID = :idpid and year(dateCreated) = :year")
					def queryParams = [:]
					queryParams.idpid = idp.id
					queryParams.year = year
				
					if(month) {
						sessionsQuery << " and month(dateCreated) = :month"
						queryParams.month = month
					}
					if(day) {
						sessionsQuery << " and day(dateCreated) = :day"
						queryParams.day = day
					}
					sessionsQuery << " group by spID"
					
					def sessions = WayfAccessRecord.executeQuery(sessionsQuery.toString(), queryParams)
					sessions.each { s ->
						def sp = SPSSODescriptor.get(s[1])
						if(sp) {
							def service = [:]
							service.id = sp.id
							service.name = sp.displayName
							services.add(service)
				
							if(activeSP == null || activeSP.contains(sp.id.toString())) {
								service.rendered = true
				
								def node = [:]
								node.nodeName = sp.displayName
								node.group = 2
								nodes.add(node)
	
								def link = [:]
								link.source = 0
								def value = ((s[0] / totalSessions[0]) * 20)		/* 0 - 20 instead of 0 - 1, makes graph look nicer */
								link.value = value
								link.target = target++

								links.add(link)
							}
							else
								service.rendered = false
						}
					}

			} else {
				results.populated = false
			}
			
			results.services = services.sort{it.get('name').toLowerCase()}
			render results as JSON
		}
		else {
			log.warn("Attempt to query connections json for $idp by $authenticatedUser was denied, incorrect permission set")
			render message(code: 'fedreg.help.unauthorized')
			response.setStatus(403)
		}
	}
}
