require 'active_support/core_ext/hash'
require 'httparty'

module Wechatpay
  module Service
    class << self
      def unified_order(options)
        config = Wechatpay::Config
        options = {
          appid: config.app_id,
          mch_id: config.mch_id,
          nonce_str: SecureRandom.urlsafe_base64(nil, false)
        }.merge(options)

        body = Wechatpay::Utils.add_sign_and_generate_xml_body(options)
        warn(body)
        response = HTTParty.post(
          Wechatpay::Config::UNIFIED_ORDER_URL,
          :body => body
        )
        result = Hash.from_xml(response.body)["xml"]
        if Wechatpay::Sign.valid?(result)
          result
        else
          nil
        end
      end
    end
  end
end
