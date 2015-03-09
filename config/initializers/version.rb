module Rabel
  module VERSION #:nodoc:
    MAJOR = 2
    MINOR = 0
    TINY  = 0
    PRE   = 'alpha'

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end

  def self.version
    self::VERSION::STRING
  end
end
