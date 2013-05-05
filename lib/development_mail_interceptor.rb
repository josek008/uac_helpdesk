class DevelopmentMailInterceptor
  def self.delivering_email(message)
  message.subject = "[#{message.to}] #{message.subject}"
  message.to = "guti60@gmail.com"
  end
  end