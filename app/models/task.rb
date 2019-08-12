class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project
  enum status:{new:0 ,in_progress:1 ,done:2 }
end
