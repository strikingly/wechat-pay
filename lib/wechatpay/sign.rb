module Wechatpay
  module Sign
    def self.md5(params)
      str = params.select{ |k,v| v.present? }.sort.map{ |i| i.join("=") }.join('&')
      str << "&key=#{Wechatpay::Config.payment_key}"
      Digest::MD5.hexdigest(str).upcase
    end

    def self.valid?(params)
      signature = params.delete("sign")
      md5(params) == signature
    end
  end
end
