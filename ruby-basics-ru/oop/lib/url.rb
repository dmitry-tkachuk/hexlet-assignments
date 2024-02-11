# frozen_string_literal: true

# BEGIN
require 'uri'
require 'forwardable'

class Url
  extend Forwardable
  include Comparable

  def initialize(url_string)
    @uri = URI.parse(url_string)
  end

  def_delegators :@uri, :scheme, :host, :port

  def query_params
    Hash[URI.decode_www_form(@uri.query || '').map { |k, v| [k.to_sym, v] }]
  end

  def query_param(key, default = nil)
    query_params[key.to_sym] || default
  end

  def ==(other)
    query_params == other.query_params &&
      ((!port && !other.port) || (port && other.port && port == other.port))
  end
end
# END
