class FrontendController < ApplicationController
  def bank
    @fintoc_public_key = Constants::FintocSecrets::PUBLIC_KEY
  end
end
