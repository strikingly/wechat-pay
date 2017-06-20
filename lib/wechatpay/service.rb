require 'active_support/core_ext/hash'
require 'httparty'

module Wechatpay
  module Service

    class InvalidResponseError < StandardError; end

    class << self
      def unified_order(options)
        config = Wechatpay::Config
        options = {
          appid: config.app_id,
          mch_id: config.mch_id,
          nonce_str: Wechatpay::Utils.nonce_str
        }.merge(options)

        body = Wechatpay::Utils.add_sign_and_generate_xml_body(options)
        response = HTTParty.post(
          Wechatpay::Config::UNIFIED_ORDER_URL,
          :body => body
        )
        result = Hash.from_xml(response.body)["xml"]
        if Wechatpay::Sign.valid?(result)
          result
        else
          raise InvalidResponseError.new(response.body.force_encoding('utf-8'))
        end
      end

      def pay_params(prepay_id)
        options = {
          appId: Wechatpay::Config.app_id,
          timeStamp: Wechatpay::Utils.timestamp,
          nonceStr: Wechatpay::Utils.nonce_str,
          package: "prepay_id=#{prepay_id}",
          signType: "MD5"
        }
        options[:paySign] = Wechatpay::Sign.md5(options)
        options.delete :appId
        options
      end
    end
  end
end
