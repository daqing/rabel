module Rabel
  module VERSION #:nodoc:
    MAJOR = 1
    MINOR = 6
    TINY  = 0
    PRE   = 'dev'

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end

  def self.version
    self::VERSION::STRING
  end
end
