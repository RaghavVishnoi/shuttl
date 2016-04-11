class CreateRouteSuggestionsOtp < ActiveRecord::Migration
  def change
    create_table :route_suggestions_otps do |t|
    	t.string :phone
    	t.string :otp
    	t.timestamps
    end
  end
end
