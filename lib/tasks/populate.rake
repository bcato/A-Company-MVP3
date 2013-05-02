namespace :db do
	desc "fill database with sample data"
	task populate: :environment do
		10.times do |n|
			puts "[DEBUG] creating user #{n+1} of 25"
			name = Faker::Name.name
			email = "user-#{n+1}@example.com"
			password = "andanteexample"
			User.create!( name: name,
						  email: email,
						  password: password,
						  password_confirmation: password )
		end

		User.all.each do |user|
			puts "[DEBUG] uploading images for user #{user.id} of #{User.last.id}"
			10.times do |n|
				image = File.open(Dir.glob(File.join(Rails.root, 'sample images', '*')).sample)
				name = %w(SampleInstrementName).sample
				category = %w(examplecategory).sample
				description = %w(cool awesome wow slammin favorite best ).sample
				user.instruments.create!(image: image, description: description)
			end
		end
	end
end