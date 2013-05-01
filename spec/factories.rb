FactoryGirl.define do 
	factory :salon do
		cut
		color
		stylist
		name "Great Clips"
		address "123 Gunbarrel Road"
		city "Chattanooga"
		state "TN"
		zip "37412"
		email "info@example.com"
		url "http://greatclips.com"
		sunday_hours "9-5"
		monday_hours "9-5"
		tuesday_hours "9-5"
		wednesday_hours "9-5"
		thursday_hours "9-5"
		friday_hours "9-5"
		saturday_hours "9-5"
	end

	# factory :service, aliases: [:cut] do
	#   name "Cut"
	#   description "Cut"
	#   price 10
	# end

	# factory :service, aliases: [:color] do
	#   name "Color"
	#   description "Color"
	#   price 20
	# end


	# factory :user, aliases: [:customer] do
	# 	wireless
 #  	name "Andrew Pierce"
 #  	email "andrew@andrunix.com"
 #  	phone "4232601810"
 #  	wireless_provider_id 1
	#   type "Client"
	# end

	# factory :user, aliases: [:stylist, :employee] do
	# 	wireless
 #  	name "Bonnie Pierce"
 #  	email "bmp@21knots.com"
 #  	phone "4232601810"
 #  	wireless_provider_id 1
 #  	type "Stylist"
 #  end

 #  factory :appointment do 
 #  	customer
 #  	employee
 #  	appointment_time { 2.weeks.from_now }
 #  	state 0
 #  	note 'This is a great appointment'
 #  end

  factory :wireless_provider, aliases: [:wireless] do
  	description "Verizon Wireless"
  	domain "vtext.com"
  end


end


