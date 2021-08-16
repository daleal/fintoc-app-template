class GetLink < PowerTypes::Command.new(:link_id)
  def perform
    client = Fintoc::Client.new(Constants::FintocSecrets::SECRET_KEY)
    link_data = Link.find_by(fintoc_id: @link_id)
    client.get_link(link_data.fintoc_token)
  end
end
