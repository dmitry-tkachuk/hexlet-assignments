# frozen_string_literal: true

class AdminPolicy
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    if env['PATH_INFO'].start_with?('/admin')
      return [403, {}, []]
    else
      @app.call(env)
    end
    # END
  end
end
