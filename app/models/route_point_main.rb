class RoutePointMain < ActiveRecord::Base
  self.table_name="route_points"
  if (Rails.env.production?)
    establish_connection "db_main".to_sym
  else
    establish_connection "db_main".to_sym
  end

end