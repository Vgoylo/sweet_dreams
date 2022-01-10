# frozen_string_literal: true

module URI
  def self.escape(str, unsafe = URI::UNSAFE)
    str.gsub(unsafe, &CGI.method(:escape))
  end
end
