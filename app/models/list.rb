class List < ApplicationRecord
    #Connect lists to tasks
    validates :name, presence: true
    has_many :tasks

    #Add ranked model
    include RankedModel
    ranks :row_order
end

