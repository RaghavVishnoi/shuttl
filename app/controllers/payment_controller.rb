class PaymentController < ApplicationController

  def hmac_sha1(data, secret)
    require 'base64'
    require 'cgi'
    require 'openssl'
    hmac = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), secret.encode("ASCII"), data.encode("ASCII"))
    return hmac
  end


  def createSignature
  #Need to change with your Secret Key
    phoneNumber=params[:phoneNumber]
    @orderAmount=params[:amount]
  @secret_key="123a075a4bf21a6d91331c9575ac0f1aeb38e548"
  #Need to change with your Vanity URL Key from the citrus panel
  @vanityUrl="w0fg7lg1vt"
  transaction =Transaction.create(:phone_number=>phoneNumber,:amount=>@orderAmount)
  @merchantTxnId=transaction.id

  #Need to change with your Order Amount



  @currency = "INR";
  @data=@vanityUrl + @orderAmount.to_s + @merchantTxnId.to_s + @currency


  @securitySignature = hmac_sha1(@data,@secret_key)
    result=Hash.new
    result["errorCode"]=0
    result["signature"]=@securitySignature
    result["transactionId"]=@merchantTxnId
    render :json=>result.to_json
  end






end