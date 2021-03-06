package aaf.fr.foundation

class Contact {
	static auditable = true
	
	String givenName
	String surname
	String description
	
	Organization organization
	
	String email
	String secondaryEmail
	
	String workPhone 
	String homePhone 
	String mobilePhone
	
	Date dateCreated
	Date lastUpdated

	static hasMany = [
		contactPersons: ContactPerson
	]

	static constraints = {
		givenName(nullable:false, blank: false)
		surname(nullable:false, blank: false)
		description(nullable:true, blank:true)
		organization(nullable:true)
		email(nullable:false, email:true, unique:true)
		secondaryEmail(nullable:true, email:true)
		workPhone(nullable:true)
		homePhone(nullable:true)
		mobilePhone(nullable:true)
		dateCreated(nullable:true)
		lastUpdated(nullable:true)
	}
	
	static mapping = {
		autoImport false
		sort "surname"
	}
	
	public String toString() { "contact:[id:$id, givenName: $givenName, surname: $surname, email: $email]" }
}