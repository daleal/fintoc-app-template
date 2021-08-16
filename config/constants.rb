module Constants
  module FintocSecrets
    PUBLIC_KEY = ENV.fetch('FINTOC_PUBLIC_KEY', '').freeze
    SECRET_KEY = ENV.fetch('FINTOC_SECRET_KEY', '').freeze
  end
end
