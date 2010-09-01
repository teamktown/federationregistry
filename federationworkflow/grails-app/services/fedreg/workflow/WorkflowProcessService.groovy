package fedreg.workflow

import org.apache.shiro.SecurityUtils

class WorkflowProcessService {
	
	def workflowTaskService
	
	def create(def definition) {
		Binding binding = new Binding()
		binding.process = { m, closure ->
			this.interpret(m, definition, closure)
		}
		
		def script = new GroovyShell().parse(definition)
		script.binding = binding
		def (created, process) = script.run()
		
		[created, process]
	}
	
	def update(String processName, def definition) {
		def process = Process.findWhere(name: processName, active: true)
		if (!process) {
			log.error "Unable to update process ${processName}"
			log.error "The process definition for ${processName} was not found, no such process by name or no process definition is active"
			return [false, null]
		}
		
		Binding binding = new Binding()
		binding.process = { m, closure ->
			this.interpret(m, definition, closure)
		}
	
		def script = new GroovyShell().parse(definition)
		script.binding = binding
		def (created, newProcess) = script.run()
		
		process.active = false
		if(!process.save()) {
			log.error "Unable to update ${process} with false active state"
			process.errors.each {
				log.error it
			}
			throw new RuntimeException("Unable to save when applying update to ${process}")
		}
		
		[created, newProcess]
	}
	
	def interpret(Map m, String definition, Closure closure) {
		def processes = Process.findAllByName(m.name)
		int processVersion = 1
		if (processes) {
			processVersion = processes.size() + 1
		}
		
		def process = new Process(name: m.name, description: m.description, processVersion: processVersion, creator: authenticatedUser, definition: definition, active:true)
		closure.delegate = new ProcessDelegate(process)
		closure()
		
		if(!process.validate()) {
			process.errors.each {
				log.error it
			}
			return [false, process]
		}
		
		if(!process.save()) {
			process.errors.each {
				log.error it
			}
			throw new RuntimeException("Unable to save when interpreting ${process}")
		}
		
		[true, process]
	}
	
	def initiate(String processName, String instanceDescription, ProcessPriority priority, Map params) {

		def process = Process.findWhere(name: processName, active: true)
		if (!process) {
			log.error "Unable to initiate an instance of process ${processName}"
			log.error "The process definition for ${processName} was not found, no such process by name or no process definition is active"
			return [false, null]
		}

		def processInstance = new ProcessInstance(process: process, description: instanceDescription, status: ProcessStatus.INPROGRESS, priority: priority ?:ProcessPriority.LOW, params:params)
		process.addToInstances(processInstance)
		
		if(!processInstance.save()) {
			log.error "Unable to initiate an instance of process ${processName}"
			processInstance.errors.each {
				log.error it
			}
			throw new RuntimeException("Unable to save ${processInstance} when initiating instance of ${process}")
		}
		
		if(!process.save()) {
			log.error "Unable to initiate an instance of process ${processName}"
			process.errors.each {
				log.error it
			}
			throw new RuntimeException("Unable to save ${process} when initiating instance for ${instanceDescription}")
		}

        [true, processInstance]
	}
	
	def run(ProcessInstance processInstance) {
		workflowTaskService.initiate(processInstance.id, processInstance.process.tasks.get(0).id)
	}
	
}