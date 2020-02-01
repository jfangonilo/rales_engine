class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :with_id, ->(id) { where(id: id) }
  scope :created_on, ->(date) { where(created_at: date) }
  scope :updated_on, ->(date) { where(updated_at: date) }
end
