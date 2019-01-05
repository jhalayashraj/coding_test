class List < ApplicationRecord
	## Associations ##
  belongs_to :user

  ## Validations ##
  validates :title, presence: true
end
