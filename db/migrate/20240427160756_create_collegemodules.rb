class CreateCollegemodules < ActiveRecord::Migration[7.0]
  def change
    create_table :collegemodules do |t|

      t.timestamps
    end
  end
end
