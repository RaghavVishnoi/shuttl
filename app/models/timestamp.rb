class Timestamp < ActiveRecord::Base

  self.table_name="timestamps"
  if (Rails.env.production?)
    establish_connection "db_main".to_sym
  else
    establish_connection "db_main".to_sym
  end


end
