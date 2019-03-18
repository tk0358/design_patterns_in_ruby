require 'uri'

class Message
  attr_accessor :from, :to, :body
  
  def initialize(from, to, body)
    @from = from
    @to = URI.parse(to)
    @body = body
  end
end

# e-mailとして送信するアダプタ
require 'net/smtp'

class SmtpAdapter
  MailServerHost = 'localhost'
  MailServerPort = 25

  def sen_message(message)
    from_address = message.from.user + '@' + message.from.host
    to_address = message.to.user + '@' + message.to.host

    email_text = "From: #{from_address}\n"
    email_text += "To: #{to_address}\n"
    email_text += "Subject: Forwarded message\n"
    email_text += "\n"
    email_text += message.body

    Net::SMTP.start(MailServerHost, MailServerPort) do |smtp|
      smtp.send_message(email_text, from_address, to_address)
    end
  end
end

# HTTP経由で送信するアダプタ
require 'net/http'

class HttpAdapter
  def send_message(message)
    Net::HTTP.start(message.to.host, message.to.port) do |http|
      http.post(message.to.path, message.body)
    end
  end
end

# ファイルで送信するアダプタ
class FileAdapter
  def send_message(message)
    #
    # URLからパスを取得し
    # 先頭の'/'を取り除く
    #
    to_path = message.to.path
    to_path.slice!(0)

    File.open(to_path, 'w') do |f|
      f.write(message.body)
    end
  end
end

# アダプタを選択する
def adapter_for(message)
  protocol = message.to.scheme.downcase
  adapter_name = "#{protocol.capitalize}Adapter"
  adapter_class = self.class.const_get(adapter_name)
  adapter_class.new
end