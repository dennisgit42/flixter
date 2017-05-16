CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = ENV["AWS_BUCKET"]
  config.aws_acl    = "public-read"

  config.aws_credentials = {
    access_key_id:      ENV["AWS_ACCESS_KEY"],
    secret_access_key:  ENV["AWS_SECRET_KEY"],
    region:             ENV["AWS_REGION"]
  }

  if Rails.env.development?
    config.cache_dir = "/home/vagrant/uploads_tmp/tmp/uploads"
    config.root = "/home/vagrant/uploads_tmp/tmp"
  end

end