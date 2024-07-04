class List < ApplicationRecord
    #Connect lists to tasks
    validates :name, presence: true
    has_many :tasks, dependent: :destroy
    belongs_to :user

    #Add ranked model
    include RankedModel
    ranks :row_order
end

