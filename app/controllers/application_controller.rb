class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  before_filter :add_allow_credentials_headers
  private
    def add_allow_credentials_headers                                                                                                                                                                                                                                                        
      response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'                                                                                                                                                                                                     
      response.headers['Access-Control-Allow-Credentials'] = 'true'                                                                                                                                                                                                                          
    end 
end
