require "wechatpay/version"
require "wechatpay/sign"
require "wechatpay/utils"
require "wechatpay/service"

module Wechatpay

  class Config

    UNIFIED_ORDER_URL = 'https://api.mch.weixin.qq.com/pay/unifiedorder'

    class << self
      # app_id: 公众账号id, mch_id: 商户号, payment_key: 商户支付秘钥
      attr_accessor :app_id, :mch_id, :payment_key
    end
  end

  class << self
    def configure
      yield Config if block_given?
    end
  end

end
