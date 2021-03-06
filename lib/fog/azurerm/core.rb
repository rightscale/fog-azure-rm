require 'fog/core'

module Fog
  # This module registers available services
  module AzureRM
    extend Fog::Provider
    service(:resources, 'Resources')
    service(:dns, 'DNS')
    service(:storage, 'Storage')
    service(:network, 'Network')
    service(:compute, 'Compute')
  end
end
