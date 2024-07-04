class AddDetailsToCollegemodules < ActiveRecord::Migration[7.0]
  def change
    add_column :collegemodules, :module_name, :string
    add_column :collegemodules, :module_id, :string
    add_column :collegemodules, :module_lecturer, :string
  end
end
