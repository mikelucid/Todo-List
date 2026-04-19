class Todo < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, length: { maximum: 500 }
  
  scope :completed, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
  
  def toggle_completion!
    update(completed: !completed)
  end
end
