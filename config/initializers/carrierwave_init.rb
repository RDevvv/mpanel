CarrierWave.configure do |config|
 config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAIHKA2QIPCJHWW2MQ',                        # required
    :aws_secret_access_key  => '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',                        # required
    # :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
    # :host                   => 's3.example.com',             # optional, defaults to nil
    # :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
  }
  config.fog_directory  = "gullakbucket"                     # required
  config.fog_public     = true                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  #
end
