# frozen_string_literal: true

module Resultr
  def self.ok(value)
    Resultr::Result.new(:ok, value)
  end

  def self.err(reason)
    Resultr::Result.new(:err, reason)
  end
end
