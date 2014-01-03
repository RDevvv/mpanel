puts gmap_config_file = File.join(Rails.root,'config','gmap.yml')
gmap_config = YAML.load_file(gmap_config_file)[Rails.env].symbolize_keys

Geocoder.configure(
   :timeout      => 3,           # geocoding service timeout (secs)
   :lookup       => :google,     # name of geocoding service (symbol)
   :language     => :en,         # ISO-639 language code
   :api_key      => gmap_config[:api_key] # API key for geocoding service

  # :use_https    => false,       # use HTTPS for lookup requests? (if supported)
  # :http_proxy   => nil,         # HTTP proxy server (user:pass@host:port)
  # :https_proxy  => nil,         # HTTPS proxy server (user:pass@host:port)
  # :cache        => nil,         # cache object (must respond to #[], #[]=, and #keys)
  # :cache_prefix => "geocoder:", # prefix (string) to use for all cache keys

  # exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and TimeoutError
  # :always_raise => [],

  # calculation options
  # :units     => :mi,       # :km for kilometers or :mi for miles
  # :distances => :linear    # :spherical or :linear
)
