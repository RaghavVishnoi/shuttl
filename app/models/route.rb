class Route < ActiveRecord::Base


  if (Rails.env.production?)
    establish_connection "db_main".to_sym
  else
    establish_connection "db_main".to_sym
  end

end
