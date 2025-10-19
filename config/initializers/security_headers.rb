# frozen_string_literal: true

# Configure security headers for production
Rails.application.config.action_dispatch.default_headers.merge!(
  {
    # Prevent page from being displayed in an iframe (clickjacking protection)
    "X-Frame-Options" => "SAMEORIGIN",

    # Prevent MIME type sniffing
    "X-Content-Type-Options" => "nosniff",

    # Enable XSS protection (legacy browsers)
    "X-XSS-Protection" => "1; mode=block",

    # Referrer policy - only send referrer for same-origin requests
    "Referrer-Policy" => "strict-origin-when-cross-origin",

    # Permissions policy - disable unnecessary browser features
    "Permissions-Policy" => "geolocation=(), microphone=(), camera=()",

    # Content Security Policy - restrict resource loading
    "Content-Security-Policy" => [
      "default-src 'self'",
      "script-src 'self' 'unsafe-inline' https://cdn.tailwindcss.com",
      "style-src 'self' 'unsafe-inline'",
      "img-src 'self' data: https:",
      "font-src 'self' data:",
      "connect-src 'self'",
      "frame-ancestors 'self'",
      "form-action 'self'",
      "base-uri 'self'"
    ].join("; ")
  }
)
