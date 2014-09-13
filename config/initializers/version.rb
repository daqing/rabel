module Rabel
  module VERSION #:nodoc:
    MAJOR = 1
    MINOR = 5
    TINY  = 4
    PRE   = 6

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end

  def self.version
    self::VERSION::STRING
  end
end
