class UtilityController < ApplicationController

  def refreshRoutePointsData

    RoutePoint.destroy_all
    RoutePointMain.all.each do |routePo|

      rp= RoutePoint,new
      rp.lat=routePo.lat
      rp.lng=routePo.lng
      rp.routeid=routePo.routeid
      rp.locationid=routePo.locationid
      rp.directionid=routePo.directionid
      rp.created_at=routePo.created_at
      rp.updated_at=routePo.updated_at
      rp.save
    end
  end
end