# encoding: UTF-8

namespace :db do
	desc "Llena la base de datos con datos aleatorios"
	task populate: :environment do
		make_departments
		make_users
		make_ticket_types
		make_survey_scores
		make_categories
		make_subcategories
		make_tickets
		assign_tickets
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

	tech1 = User.create!(name: "Tech User #1",
		email: "tech1@domain.com",
		department_id: 13,
		password: "foobar",
		password_confirmation: "foobar")
	tech1.toggle!(:tech)

	tech2 = User.create!(name: "Tech User #2",
		email: "tech2@domain.com",
		department_id: 13,
		password: "foobar",
		password_confirmation: "foobar")
	tech2.toggle!(:tech)

	tech3 = User.create!(name: "Tech User #3",
		email: "tech3@domain.com",
		department_id: 13,
		password: "foobar",
		password_confirmation: "foobar")
	tech3.toggle!(:tech)

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

def make_ticket_types
	TicketType.create!(type_descr: "Preventivo")
	TicketType.create!(type_descr: "Correctivo")
end

def make_survey_scores
	Score.create!(description: "Muy Insatisfecho")
	Score.create!(description: "Insatisfecho")
	Score.create!(description: "Neutral")
	Score.create!(description: "Satisfecho")
	Score.create!(description: "Muy Satisfecho")
end

def make_categories
	Category.create!(name: "Hardware")
	Category.create!(name: "Software")
	Category.create!(name: "Otros")
end

def make_subcategories
	category = Category.find_by_name("Hardware")
	category.subcategories.create!(name: "Pantalla")
	category.subcategories.create!(name: "Teclado")
	category.subcategories.create!(name: "Mouse")
	category.subcategories.create!(name: "Speakers")
	category.subcategories.create!(name: "PC")
	category.subcategories.create!(name: "Disco Duro Portatil")
	category.subcategories.create!(name: "Fuente de Poder")
	category.subcategories.create!(name: "UPS")
	category.subcategories.create!(name: "Camara Web")
	category.subcategories.create!(name: "Otros (Hardware)")

	category = Category.find_by_name("Software")
	category.subcategories.create!(name: "Antivirus")
	category.subcategories.create!(name: "Microsoft Office")
	category.subcategories.create!(name: "Correo Electronico")
	category.subcategories.create!(name: "Sistema Academico")
	category.subcategories.create!(name: "Sistema Operativo (Windows)")
	category.subcategories.create!(name: "Sistema Operativo (Mac OS)")
	category.subcategories.create!(name: "Otros (Software)")

	category = Category.find_by_name("Otros")
	category.subcategories.create!(name: "Otros (General)")

end

def make_tickets
	users = User.all(limit: 10)
	users.each do |user|
		5.times do
			description = Faker::Lorem.sentence(5)
			ticket = user.tickets.create!(description: description,
				category_id: Category.where("parent_id IS NOT NULL").sample.id,
				ticket_type_id: TicketType.find_by_type_descr("Correctivo").id)

			log = Log.create!(ticket_id: ticket.id, content: Faker::Lorem.sentence(5), user_id: user.id)
			log.event = "Abierto"
			log.save
		end
	end
end

def assign_tickets
	tickets = Ticket.all

	tickets.each do |t|
		tech = User.is_tech.sample
		t.assign_to(tech)
		t.assign
		
		log = Log.create!(ticket_id: t.id, content: "Asignado automaticamente a #{tech.name}", user_id: 1)
		log.event = "Asignado"
		log.save
	end
end



