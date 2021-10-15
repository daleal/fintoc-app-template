class FrontendController < ApplicationController
  def main
    @fintoc_public_key = Constants::FintocSecrets::PUBLIC_KEY
  end
end
