class Collegemodule < ApplicationRecord
    #Adds link to signed in user
    belongs_to :user
end