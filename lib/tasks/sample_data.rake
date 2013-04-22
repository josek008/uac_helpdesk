# encoding: UTF-8

namespace :db do
	desc "Llena la base de datos con datos aleatorios"
	task populate: :environment do
		make_departments
		make_users
		make_events
		make_survey_scores
		make_ticket_statuses
		make_ticket_types
		make_categories
		make_subcategories
		#make_tickets
	end
end

def make_departments
	Department.create!(name: "Secretaria General")
	Department.create!(name: "Rectoría")
	Department.create!(name: "Polideportivo")
	Department.create!(name: "Facultad de Ciencias Administrativas Económicas y Contables")
	Department.create!(name: "Facultad de Ingeniería")
	Department.create!(name: "Facultad de Arquitectura , Arte y Diseño")
	Department.create!(name: "Facultad de Jurisprudencia")
	Department.create!(name: "Facultad de Ciencias Sociales y Humanas")
	Department.create!(name: "Biblioteca")
	Department.create!(name: "Bienestar")
	Department.create!(name: "Canal 23")
	Department.create!(name: "Casa de Eventos")
	Department.create!(name: "Centro de Desarrollo de Sistemas")
	Department.create!(name: "Centro de Educación Permanente")
	Department.create!(name: "Centro de Investigaciones")
	Department.create!(name: "Contact Center")
	Department.create!(name: "Crédito y Cobranzas")
	Department.create!(name: "Dirección Académica")
	Department.create!(name: "Dirección de Extensión y proyección Social")
	Department.create!(name: "Egresados")
	Department.create!(name: "Marketing")
	Department.create!(name: "Planeación")
	Department.create!(name: "Postgrados")
	Department.create!(name: "Salas de Informática")
	Department.create!(name: "Parqueaderos")
end

def make_users
	admin = User.create!(name: "Admin User",
		email: "admin@domain.com",
		department_id: 13,
		password: "foobar",
		password_confirmation: "foobar")
	admin.toggle!(:admin)
	admin.toggle!(:tech)

	tech = User.create!(name: "Tech User",
		email: "tech@domain.com",
		department_id: 13,
		password: "foobar",
		password_confirmation: "foobar")
	tech.toggle!(:tech)

	50.times do |n|
		name = Faker::Name.name
		email = "example-#{n+1}@domain.com"
		password = "password"
		User.create!(name: name,
			email: email,
			department_id: [*1..25].sample,
			password: password,
			password_confirmation: password)
	end
end

def make_events
	Event.create!(event_descr: "Creación")
	Event.create!(event_descr: "Asignación")
	Event.create!(event_descr: "Seguimiento")
	Event.create!(event_descr: "Reasignación")
	Event.create!(event_descr: "Marcado como 'Espera por acción'")
	Event.create!(event_descr: "Marcado como 'Cerrado'")
	Event.create!(event_descr: "Cerrado")
end

def make_survey_scores
	SurveyScore.create!(survey_descr: "Muy Insatisfecho")
	SurveyScore.create!(survey_descr: "Insatisfecho")
	SurveyScore.create!(survey_descr: "Neutral")
	SurveyScore.create!(survey_descr: "Satisfecho")
	SurveyScore.create!(survey_descr: "Muy Satisfecho")
end

def make_ticket_statuses
	TicketStatus.create!(status_descr: "Abierto")
	TicketStatus.create!(status_descr: "En espera por acción")
	TicketStatus.create!(status_descr: "Cerrado")
end

def make_ticket_types
	TicketType.create!(type_descr: "Preventivo")
	TicketType.create!(type_descr: "Correctivo")
end

def make_categories
	Category.create!(name: "Hardware")
	Category.create!(name: "Software")
	Category.create!(name: "Otros")
end

def make_subcategories
	Category.create!(name: "Pantalla", 	parent_id: 0)
	Category.create!(name: "Teclado", 	parent_id: 0)
	Category.create!(name: "Mouse", 	parent_id: 0)
	Category.create!(name: "Speakers", 	parent_id: 0)
	Category.create!(name: "PC", 		parent_id: 0)
	Category.create!(name: "Disco Duro Portatil", 	parent_id: 0)
	Category.create!(name: "Fuente de Poder", 		parent_id: 0)
	Category.create!(name: "UPS", 		 parent_id: 0)
	Category.create!(name: "Camara Web", parent_id: 0)
	Category.create!(name: "Otros (Hardware)", 		parent_id: 0)
	Category.create!(name: "Antivirus",  parent_id: 1)
	Category.create!(name: "Microsoft Office", 		parent_id: 1)
	Category.create!(name: "Correo Electronico", 	parent_id: 1)
	Category.create!(name: "Sistema Academico", 	parent_id: 1)
	Category.create!(name: "Sistema Operativo (Windows)", parent_id: 1)
	Category.create!(name: "Sistema Operativo (Mac OS)",  parent_id: 1)
	Category.create!(name: "Otros (Software)", 		parent_id: 1)
	Category.create!(name: "Otros (General)", 		parent_id: 2)
end

def make_tickets
	users = User.all(limit: 10)
	10.times do
		description = Faker::Lorem.sentence(5)
		users.each do |user|
			user.ticket.create!(description: description,
				category: Category.where("parent_id IS NOT NULL").sample,
				ticket_type: 1)
		end
	end
end



