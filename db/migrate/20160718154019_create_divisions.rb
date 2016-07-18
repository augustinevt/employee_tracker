class CreateDivisions < ActiveRecord::Migration
  def change
    create_table(:divisions) do |t|
      t.column(:title, :string)

      t.timestamps()
    end
  end
end
