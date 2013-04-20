CarrierWave.configure do |config|
	config.fog_credentials = {
		:provider								=> 'AWS',
		:aws_access_key_id			=> ENV['AWS_ACCESS_KEY'],
		:aws_secret_access_key	=> ENV['AWS_SECRET_ACCESS_KEY'],
		:region									=> 'us-east-1' #,
		#:host										=> 's3.example.com',
		#:endpoint								=> 'https://s3.example.com'
	}

	config.fog_directory = ENV['AWS_BUCKET']    # 'madrimgd'
	config.fog_public    = false
	config.fog_attributes = {'Cache-Control'=>'max-age=315576000'} 
	#config.fog_attributes = { }
end

