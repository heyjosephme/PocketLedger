# frozen_string_literal: true

class Rack::Attack
  ### Configure Cache ###

  # Use Rails cache for storing rate limit data
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  ### Throttle Spammy Clients ###

  # Throttle login attempts by IP address
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:logins/ip:#{req.ip}"
  throttle("logins/ip", limit: 5, period: 1.minute) do |req|
    if req.path == "/users/sign_in" && req.post?
      req.ip
    end
  end

  # Throttle login attempts by email address
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:logins/email:#{req.email}"
  throttle("logins/email", limit: 5, period: 1.minute) do |req|
    if req.path == "/users/sign_in" && req.post?
      # Normalize to protect against email address variations
      req.params["user"]&.dig("email")&.to_s&.downcase&.gsub(/\s+/, "")
    end
  end

  # Throttle registration attempts by IP address
  #
  # Limit registrations to 3 per hour per IP
  throttle("registrations/ip", limit: 3, period: 1.hour) do |req|
    if req.path == "/users" && req.post?
      req.ip
    end
  end

  # Throttle password reset requests
  throttle("password_resets/ip", limit: 5, period: 1.hour) do |req|
    if req.path == "/users/password" && req.post?
      req.ip
    end
  end

  # Throttle file uploads by user
  throttle("uploads/user", limit: 10, period: 1.hour) do |req|
    if req.path.start_with?("/expenses") && req.post? && req.params["expense"]&.dig("receipts")
      req.env["warden"]&.user&.id
    end
  end

  # Throttle general requests by IP (prevent DDoS)
  throttle("req/ip", limit: 300, period: 5.minutes) do |req|
    req.ip unless req.path.start_with?("/assets")
  end

  ### Custom Throttle Response ###
  self.throttled_responder = lambda do |env|
    match_data = env["rack.attack.match_data"]
    now = match_data[:epoch_time]

    headers = {
      "RateLimit-Limit" => match_data[:limit].to_s,
      "RateLimit-Remaining" => "0",
      "RateLimit-Reset" => (now + (match_data[:period] - now % match_data[:period])).to_s,
      "Content-Type" => "text/html"
    }

    [ 429, headers, [ <<~HTML.strip ] ]
      <!DOCTYPE html>
      <html>
      <head>
        <title>Too Many Requests</title>
        <style>
          body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; padding: 50px; text-align: center; }
          h1 { color: #d32f2f; }
          p { color: #666; }
        </style>
      </head>
      <body>
        <h1>Too Many Requests</h1>
        <p>You have exceeded the rate limit. Please try again later.</p>
        <p>Limit: #{match_data[:limit]} requests per #{match_data[:period]} seconds</p>
      </body>
      </html>
    HTML
  end

  ### Logging ###
  ActiveSupport::Notifications.subscribe("throttle.rack_attack") do |_name, _start, _finish, _request_id, payload|
    req = payload[:request]
    Rails.logger.warn "[Rack::Attack][Throttled] #{req.env['rack.attack.match_type']} #{req.ip} #{req.request_method} #{req.fullpath}"
  end
end
