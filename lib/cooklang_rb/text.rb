require_relative "steppable"

module CooklangRb
  class Text
    include Steppable

    attr_reader :value

    TAGS = /[@#~]|\n/

    def self.parse_from(buffer)
      text = buffer.scan_until TAGS
      if text.nil?
        text = buffer.rest
        buffer.pos = buffer.rest_size + buffer.pos
        new text.chomp
      else
        text = text.sub(TAGS, "")
        buffer.pos = buffer.pos - 1 unless buffer.eos?
        new text.chomp
      end
    end

    def initialize(value)
      @value = value
    end
  end
end
