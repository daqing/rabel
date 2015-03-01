class QiniuImageUploader < CarrierWave::Uploader::Base
  storage :qiniu

  self.qiniu_bucket = Figaro.env.RABEL_QINIU_BUCKET
  self.qiniu_bucket_domain = Figaro.env.RABEL_QINIU_BUCKET_DOMAIN
  self.qiniu_protocal = Figaro.env.RABEL_QINIU_PROTOCOL
  self.qiniu_can_overwrite = true
  self.qiniu_access_key = Figaro.env.RABEL_QINIU_ACCESS_KEY
  self.qiniu_secret_key = Figaro.env.RABEL_QINIU_SECRET_TOKEN
  self.qiniu_block_size = 4*1024*1024
end
