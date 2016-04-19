
require 'rubygems'
require 'ai4r'
include Ai4r::Data
include Ai4r::Clusterers
require 'net/http'

class ClusterController < ApplicationController


  THRESHOLD_TO_MAKE_CLUSTER=500
  MAX_PICK_UP_POINT_TO_SEND=6
  @clustering
  def initialize
    @clustering=Array.new
    @finalCluster=Array.new
  end
  def refreshClusters

    data=Array.new
    PickPointCluster.destroy_all
    DestinationCluster.destroy_all
    RouteSuggestionsCustomer.all.each do |customerSug|
      sugg=Array.new
      sugg.push(customerSug.from_lat)
      sugg.push(customerSug.from_long)
      sugg.push(customerSug.id)
      data << sugg
    end

    pickPointClusters=findCluster data
    pickPointClusters.each do |pickPoint|
      pc=PickPointCluster.new
      cenX,cenY,radius=findCentroidForCluser pickPoint
      pc.lat=cenX
      pc.lng=cenY
      pc.radius=radius
      pc.people=pickPoint.data_items.size
      pc.save
      updateClusterUsersWithPickClusterId(pc.id,pickPoint)
    end
    data=Array.new

    RouteSuggestionsCustomer.all.each do |customerSug|
      sugg=Array.new
      sugg.push(customerSug.to_lat)
      sugg.push(customerSug.to_long)
      sugg.push(customerSug.id)
      data << sugg
    end

    dropPointClusters=findCluster data

    dropPointClusters.each do |dropPoint|
      pc=DestinationCluster.new
      cenX,cenY,radius=findCentroidForCluser dropPoint
      pc.lat=cenX
      pc.lng=cenY
      pc.radius=radius
      pc.people=dropPoint.data_items.size
      pc.save
      updateClusterUsersWithDropClusterId(pc.id,dropPoint)
    end

    render :json=>@clustering.to_json
    end


  def findCluster(data)

    @finalCluster=Array.new

    finalCluster=Array.new
    dataSet=DataSet.new(:data_items=>data,:data_labels=>["lat","lng","id"])
    clusterer=CentroidLinkage.new
    clusterer.distance_function= lambda {|a,b| Location.distance(a[0],a[1],b[0],b[1])}
    clusterer.build dataSet,2
    findValidClusters clusterer
    @finalCluster
  end
  def findValidClusters(clusterer)
    clusterer.clusters.each do |cluster|

      if (isValidCluster(cluster))
        if (cluster!=nil && cluster.data_items.length>0)

          @finalCluster.push cluster

        end

      else
        clusten=CentroidLinkage.new
        clusten.distance_function= lambda {|a,b| Location.distance(a[0],a[1],b[0],b[1])}
        clusten.build(cluster,2)
        findValidClusters(clusten)
      end
    end

  end


  def isValidCluster(dataSet)

    dataI=Array.new
    if (dataSet== nil || dataSet.data_items.length==0)
      return true
    end
    meanLat=0
    meanLng=0
    dataSet.data_items.each do |data|
      dataI.push(data[2])
      meanLat=meanLat+data[0]
      meanLng=meanLng+data[1]
    end
    @clustering.push(dataI)
    meanLat=meanLat/dataSet.data_items.length
    meanLng=meanLng/dataSet.data_items.length

    maxDistance=0


    dataSet.data_items.each do |data|

      if Location.distance(data[0],data[1],meanLat,meanLng)>THRESHOLD_TO_MAKE_CLUSTER

        return false

      end

    end
    return true
  end


  def findCentroidForCluser(cluster)

    meanLat=0
    meanLng=0
    radius=0
    cluster.data_items.each do |data|

      meanLat=meanLat+data[0]
      meanLng=meanLng+data[1]
    end
    meanLat=meanLat/cluster.data_items.size
    meanLng=meanLng/cluster.data_items.size

    cluster.data_items.each do |data|

      if (Location.distance(meanLat,meanLng,data[0],data[1])>radius)
        radius=Location.distance(meanLat,meanLng,data[0],data[1])
      end

    end

    return meanLat,meanLng,radius
  end


  def updateClusterUsersWithDropClusterId(id,cluster)
    cluster.data_items.each do |it|
      RouteSuggestionsCustomer.update(it[2],:drop_cluster_id=>id)
    end

  end


  def updateClusterUsersWithPickClusterId(id,cluster)
    cluster.data_items.each do |it|
      RouteSuggestionsCustomer.update(it[2],:pick_cluster_id=>id)
    end

  end


  def showClusterInfoforPPD
    from_lat=params[:from_lat]
    from_lng=params[:from_lng]
    radius=2000
    type=params[:type]
    pickPoint=Hash.new
    if (type==1)
      results=PickPointCluster.where("lat>#{from_lat-0.001}").where("lat<#{from_lat+0.001}")
      results.each do |res|
        sugg=RouteSuggestionsCustomer.where(:pick_cluster_id=>res.id)
        sugg.each do |su|


        end


      end
    end
  end

  def getDescripData
    RouteSuggestionsCustomer.all.each do |d|
      if (d.description!=nil)
        lat,lng=getLatLng(d.description)
        if (lat!=nil && lng!=nil)
          d.from_lat=lat
          d.from_long=lng
          d.to_lat=28.4128529
          d.to_long=77.03798019999999
          d.save
        else
          d.destroy!
        end
      end
    end
  end

  def getLatLng(description)
    url = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?address="+description+"&key=AIzaSyDpbacUKJxxWYkWgrSPEphRPURFx8hP8rI")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port,:use_ssl => url.scheme == 'https') {|http|
      http.request(req)
    }
    res=JSON.parse(res.body)

    if (res!=nil && res["results"].size>0)

      lat=res["results"][0]["geometry"]["location"]["lat"]
      lng=res["results"][0]["geometry"]["location"]["lng"]
      return lat,lng
    end
    return nil,nil

  end

  def getCluster
    page=1
    destinationPeopleArray=Array.new
    destination=DestinationCluster.order(" people desc ").limit(page)
    destination=destination.last
    destinationId=0
    if (destinationId.size>0)
     destinationId=destination.id
    end
    if (destinationId==0)
      render :text=> "Error not data"
      return
    end

    result=RouteSuggestionsCustomer.where(:drop_cluster_id => destinationId).group(:pick_cluster_id).select(" route_suggestions_customers.id,count(*) as count,pick_point_clusters.* ").order("count desc").limit(MAX_PICK_UP_POINT_TO_SEND).joins("join pick_point_clusters on pick_point_clusters.id=pick_cluster_id")
    res=Array.new
    puts result.length.to_s
    result.each do |r|
      dat=Hash.new
      dat["lat"]=r["lat"]
      dat["lng"]=r["lng"]
      dat["people"]=r["count"]
      dat["distance"]=Location.distance destination.lat,destination.lng,r["lat"],r["lng"]
      puts "hey"
      res.push dat
    end

    res.push({:lat=>destination.lat,:lng=>destination.lng,"distance"=>0})

    res.sort! {|a,b|
      b["distance"]<=>a["distance"]
    }

    render :json=>res.to_json
  end


  def getAllPickPointsForRoute
    pickUpPoints=params[:pick_up_points]


  end

  def getDirections(pickUpPoints)

    if (pickUpPoints==nil || pickUpPoints.size==0)
      return nil
    end
    url = URI.parse("https://maps.googleapis.com/maps/api/directions/json?origin="+pickUpPoints[0]["lat"]+","+pickUpPoints[0]["lng"]+"&destination="+pickUpPoints[pickUpPoints.size-1]["lat"]+","+pickUpPoints[pickUpPoints.size-1]["lng"]+"&sensor=false&units=metric&mode=driving&key=AIzaSyBvaX6apQloHSxGg6XHmY-l_LbUjyIIUkA")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port,:use_ssl => url.scheme == 'https') {|http|
      http.request(req)
    }

    return nil,nil

  end



  def generateRoutesDuration

    sql="(
SELECT id,routeid, from_latitude as lat, from_longitude as lng
from Path
where startLocationId<>0
and routeid in (3,4,6,7,8,10,16,17,18,19,21,22,28,29,30,31,32,33,37,38,39,40,78,79,87,160,161,162,163,171,172,204,223,224,333,334,385,386,389,390,396,397,409,410,413,414,467,468,472,473)
)
UNION
(
select a.id as id,a.routeid as routeid, a.to_latitude as lat, a.to_longitude as lng
from
(
select *
from Path
where endlocationid<>0
and routeid in (3,4,6,7,8,10,16,17,18,19,21,22,28,29,30,31,32,33,37,38,39,40,78,79,87,160,161,162,163,171,172,204,223,224,333,334,385,386,389,390,396,397,409,410,413,414,467,468,472,473)
order by id desc
)a
group by a.routeid
)
order by routeid,id"
    connection = ActiveRecord::Base.establish_connection(
        :adapter => "mysql2",
        :host => "52.74.42.151",
        :database => "shuttl",
        :username => "shuttl",
        :password => "hakunamatata"
    )

    result=connection.connection.execute(sql)
    routePick=Hash.new
    result.each do |res|

      if (routePick[res[1]]==nil)
        routePick[res[1]]=Array.new
      end
      a=Hash.new
      a["lat"] =res[2]
      a["lng"] =res[3]
      routePick[res[1]].push a

    end

    connection = ActiveRecord::Base.establish_connection(
        :adapter => "mysql2",
        :host => "52.38.247.134",
        :database => "shuttl",
        :username => "root",
        :password => "shuttl@12345"
    )

    routePick.each do |key,value|

      i=0
      url=""
      value.each do |val|

        if (i==0)
          url = "https://maps.googleapis.com/maps/api/directions/json?origin="+val["lat"].to_s+","+val["lng"].to_s

        elsif (i==1)
          url = url+"&waypoints=via:"+val["lat"].to_s+","+val["lng"].to_s
        elsif (i<20)

          url = url+"|via:"+val["lat"].to_s+","+val["lng"].to_s
        end
        i=i+1
      end

      routePick.each do |key2,value|
        begin
          url1=""
        url1=url+"&destination="+value[0]["lat"].to_s+","+value[0]["lng"].to_s+"&key=AIzaSyBaYDdManjfRZsMApOyTUkluKQugnivKMA"
        url1=URI.parse url1
          noOfTry=0
          while (noOfTry<3)

            begin
            req = Net::HTTP::Get.new(url1)
            success=false
            res = Net::HTTP.start(url1.host, url1.port,:use_ssl => url1.scheme == 'https') {|http|
              success=true
              http.request(req)

            }
            rescue Exception=>e
             noOfTry=noOfTry+1
             next
            end
            break
          end
          if (!success)

           RouteDist.create(:distance=>0,:duration=>-1,:routeid=>key,:routeidD=>key2)
           next

          end


        response=res.body

        response=JSON.parse response
        if (response!=nil && response["routes"][0]["legs"].length>0)
          distance=0
          duration=0
          response["routes"][0]["legs"].each do |leg|
            distance=distance+leg["distance"]["value"]
            duration=duration+leg["duration"]["value"]
          end
          RouteDist.create(:distance=>distance,:duration=>duration,:routeid=>key,:routeidD=>key2)
        end
        rescue Exception=>e

          k=0
          k=k+1
        end
      end
    end

  end

end