# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  # BEGIN
  def call(env)
    language = env['HTTP_ACCEPT_LANGUAGE']

    if language
      I18n.locale = language.scan(/^[a-z]{2}/).first.to_sym
    end
    @app.call(env)
  end
  # END
end
