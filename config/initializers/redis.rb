require "redis"

class Redis
  def self.current=(value)
    @current = value
  end

  def self.current
    @current
  end
end

Redis.current = Redis.new(url: ENV.fetch("REDIS_URL", "redis://localhost:6379/1"))