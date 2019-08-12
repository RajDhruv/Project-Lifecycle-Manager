class Project < ApplicationRecord
	has_and_belongs_to_many :users
	belongs_to :admin,class_name:"User",foreign_key: :admin
	has_many :tasks
end
