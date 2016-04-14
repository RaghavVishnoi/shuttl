class AddAdministrativeLevelToCluster < ActiveRecord::Migration
  def change
    add_column :clusters, :administrative_level, :string
  end
end
