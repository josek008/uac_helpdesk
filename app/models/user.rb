# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  department_id   :integer
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  tech            :boolean          default(FALSE)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
	attr_accessible :email, :name, :department_id, :password, :password_confirmation
	
	scope :is_tech, where(:tech => true)

	has_many :tickets
	has_many :assignments, dependent: :destroy
	has_many :assigned_tickets, through: :assignments, source: :ticket
	has_many :answered_surveys, class_name: "Survey", foreign_key: "user_id"
	has_many :service_surveys, class_name: "Survey", foreign_key: "tech_id"

	belongs_to :department
	
	has_secure_password

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }

	validates :password, length: { minimum: 6 }
	validates :password_confirmation, presence: true

	validates :department_id, presence: true

	before_save { self.email.downcase! }
	before_save :create_remember_token

	def survey_avg_score
		service_surveys.average.(:score)
	end

	def be_tech
		self.update_attribute(:tech, true)
		self.update_attribute(:admin, false)
	end

	def be_admin
		self.update_attribute(:tech, false)
		self.update_attribute(:admin, true)
	end

	def be_normal
		self.update_attribute(:tech, false)
		self.update_attribute(:admin, false)
	end

	def update_password(new_password)
		self.update_attribute(:password, new_password)
	end

	def role
		case
		when self.tech then "Tecnico"
		when self.admin then "Admin"
		else "Usuario"
		end
	end

	def to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |user|
				csv << user.attributes.values_at(*column_names)
			end
		end
	end

	private
	
	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end

end
