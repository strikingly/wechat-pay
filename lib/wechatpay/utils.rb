module Wechatpay
  module Utils
    class << self
      def cdata(hash)
        with_hash(hash) do
          hash.each { |k, v| hash[k] = cdata_cell(v) }
        end
      end

      def cdata_cell(item)
        if item.is_a? Numeric
          item
        else
          "<![CDATA[#{item}]]>"
        end
      end

      def to_xml(hash)
        with_hash(hash) do
          str = "<xml>\n"
          hash.each do |k, v|
            str << "<#{k}>#{v}</#{k}>\n"
          end
          str << "</xml>"
        end
      end

      def add_sign_and_generate_xml_body(options)
        with_hash(options) do
          options[:sign] = Wechatpay::Sign.md5(options)
          options = Wechatpay::Utils.cdata(options)
          Wechatpay::Utils.to_xml(options)
        end
      end

      def with_hash(hash)
        if hash.is_a? Hash
          yield hash
        else
          raise ArgumentError
        end
      end

      def timestamp
        # Need to convert timestamp from integer to string. See http://blog.csdn.net/chenyoper/article/details/42496245
        Time.now.to_i.to_s
      end

      def nonce_str
        SecureRandom.urlsafe_base64(nil, false)
      end
    end
  end
end
