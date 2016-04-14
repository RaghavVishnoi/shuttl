
require 'rubygems'
require 'ai4r'
include Ai4r::Data
include Ai4r::Clusterers


class ClusterController < ApplicationController


  THRESHOLD_TO_MAKE_CLUSTER=200


  def initialize
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
      cenX,cenY=findCentroidForCluser pickPoint
      pc.lat=cenX
      pc.lng=cenY
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
      cenX,cenY=findCentroidForCluser dropPoint
      pc.lat=cenX
      pc.lng=cenY
      pc.save
      updateClusterUsersWithDropClusterId(pc.id,dropPoint)
    end

    end


  def findCluster(data)

    @finalCluster=Array.new

    finalCluster=Array.new
    dataSet=DataSet.new(:data_items=>data,:data_labels=>["lat","lng","id"])
    clusterer=KMeans.new.build(dataSet,2)
    clusterer.distance_function= lambda {|a,b| Location.distance(a[0],a[1],b[0],b[1])}
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
        findValidClusters(KMeans.new.build(cluster,2))
      end
    end

  end


  def isValidCluster(dataSet)

    if (dataSet== nil || dataSet.data_items.length==0)
      return true
    end
    meanLat=0
    meanLng=0
    dataSet.data_items.each do |data|

      meanLat=meanLat+data[0]
      meanLng=meanLng+data[1]
    end
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
    cluster.data_items.each do |data|

      meanLat=meanLat+data[0]
      meanLng=meanLng+data[1]
    end
    meanLat=meanLat/cluster.data_items.length
    meanLng=meanLng/cluster.data_items.length

    return meanLat,meanLng
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
end