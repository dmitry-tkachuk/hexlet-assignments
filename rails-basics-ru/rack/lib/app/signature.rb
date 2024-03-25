# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    status, headers, response = @app.call(env)

    body = response.each.reduce('') { |acc, part| acc + part }

    hash = Digest::SHA256.hexdigest(body)

    modified_body = "#{body}\nX-Content-SHA256: #{hash}"

    headers['Content-Length'] = modified_body.bytesize.to_s

    [status, headers, [modified_body]]
    # END
  end
end
