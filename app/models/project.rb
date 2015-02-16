class Project < ActiveRecord::Base
    validates :project_item, presence: true
end
