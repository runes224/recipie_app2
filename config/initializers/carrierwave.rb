if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws' #←ここを追記
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV["AWS_ACCESS_KEY_ID_MER60"],
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY_MER60"],
      region: 'ap-northeast-1' # S3バケット作成時に指定したリージョン。
    }
    config.fog_directory  = 'quick-recipe-images' # 作成したS3バケット名
  end
end