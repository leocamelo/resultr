# frozen_string_literal: true

require 'resultr/version'
require 'resultr/result'
require 'resultr/result_proxy'

module Resultr
  def self.ok(value)
    ::Resultr::Result.new(:ok, value)
  end

  def self.err(reason)
    ::Resultr::Result.new(:err, reason)
  end
end
