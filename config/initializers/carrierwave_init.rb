CarrierWave.configure do |config|
 config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAIENXMFVOKDJTHOFA',                        # required
    :aws_secret_access_key  => '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',                        # required
    # :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
    # :host                   => 's3.example.com',             # optional, defaults to nil
    # :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
  }
  config.fog_directory  = Rails.env                     # required
  config.fog_public     = true                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  #
end
