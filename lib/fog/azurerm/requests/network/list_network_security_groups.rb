module Fog
  module Network
    class AzureRM
      # Real class for Network Request
      class Real
        def list_network_security_groups(resource_group)
          Fog::Logger.debug "Getting list of Network Security Groups from Resource Group #{resource_group}."
          begin
            promise = @network_client.network_security_groups.list(resource_group)
            result = promise.value!
            Azure::ARM::Network::Models::NetworkSecurityGroupListResult.serialize_object(result.body)['value']
          rescue MsRestAzure::AzureOperationError => e
            msg = "Exception listing Network Security Groups from Resource Group '#{resource_group}'. #{e.body['error']['message']}."
            raise msg
          end
        end
      end

      # Mock class for Network Request
      class Mock
        def list_network_security_groups(resource_group)
          [
            {
              'id' => "/subscriptions/########-####-####-####-############/resourceGroups/#{resource_group}/providers/Microsoft.Network/networkSecurityGroups/testGroup",
              'name' => 'testGroup',
              'type' => 'Microsoft.Network/networkSecurityGroups',
              'location' => 'westus',
              'properties' =>
                {
                  'securityRules' =>
                    [
                      {
                        'id' => "/subscriptions/########-####-####-####-############/resourceGroups/#{resource_group}/providers/Microsoft.Network/networkSecurityGroups/testGroup/securityRules/testRule",
                        'properties' =>
                          {
                            'protocol' => 'tcp',
                            'sourceAddressPrefix' => '0.0.0.0/0',
                            'destinationAddressPrefix' => '0.0.0.0/0',
                            'access' => 'Allow',
                            'direction' => 'Inbound',
                            'sourcePortRange' => '22',
                            'destinationPortRange' => '22',
                            'priority' => 100,
                            'provisioningState' => 'Succeeded'
                          },
                        'name' => 'testRule'
                      }
                    ],
                  'defaultSecurityRules' =>
                    [
                      {
                        'id' => "/subscriptions/########-####-####-####-############/resourceGroups/#{resource_group}/providers/Microsoft.Network/networkSecurityGroups/testGroup/defaultSecurityRules/AllowVnetInBound",
                        'properties' =>
                          {
                            'protocol' => '*',
                            'sourceAddressPrefix' => 'VirtualNetwork',
                            'destinationAddressPrefix' => 'VirtualNetwork',
                            'access' => 'Allow',
                            'direction' => 'Inbound',
                            'description' => 'Allow inbound traffic from all VMs in VNET',
                            'sourcePortRange' => '*',
                            'destinationPortRange' => '*',
                            'priority' => 65_000,
                            'provisioningState' => 'Succeeded'
                          },
                        'name' => 'AllowVnetInBound'
                      },
                      {
                        'id' => "/subscriptions/########-####-####-####-############/resourceGroups/#{resource_group}/providers/Microsoft.Network/networkSecurityGroups/testGroup/defaultSecurityRules/AllowAzureLoadBalancerInBound",
                        'properties' =>
                          {
                            'protocol' => '*',
                            'sourceAddressPrefix' => 'AzureLoadBalancer',
                            'destinationAddressPrefix' => '*',
                            'access' => 'Allow',
                            'direction' => 'Inbound',
                            'description' => 'Allow inbound traffic from azure load balancer',
                            'sourcePortRange' => '*',
                            'destinationPortRange' => '*',
                            'priority' => 65_001,
                            'provisioningState' => 'Succeeded'
                          },
                        'name' => 'AllowAzureLoadBalancerInBound'
                      },
                      {
                        'id' => "/subscriptions/########-####-####-####-############/resourceGroups/#{resource_group}/providers/Microsoft.Network/networkSecurityGroups/testGroup/defaultSecurityRules/DenyAllInBound",
                        'properties' =>
                          {
                            'protocol' => '*',
                            'sourceAddressPrefix' => '*',
                            'destinationAddressPrefix' => '*',
                            'access' => 'Deny',
                            'direction' => 'Inbound',
                            'description' => 'Deny all inbound traffic',
                            'sourcePortRange' => '*',
                            'destinationPortRange' => '*',
                            'priority' => 65_500,
                            'provisioningState' => 'Succeeded'
                          },
                        'name' => 'DenyAllInBound'
                      },
                      {
                        'id' => "/subscriptions/########-####-####-####-############/resourceGroups/#{resource_group}/providers/Microsoft.Network/networkSecurityGroups/testGroup/defaultSecurityRules/AllowVnetOutBound",
                        'properties' =>
                          {
                            'protocol' => '*',
                            'sourceAddressPrefix' => 'VirtualNetwork',
                            'destinationAddressPrefix' => 'VirtualNetwork',
                            'access' => 'Allow',
                            'direction' => 'Outbound',
                            'description' => 'Allow outbound traffic from all VMs to all VMs in VNET',
                            'sourcePortRange' => '*',
                            'destinationPortRange' => '*',
                            'priority' => 65_000,
                            'provisioningState' => 'Succeeded'
                          },
                        'name' => 'AllowVnetOutBound'
                      },
                      {
                        'id' => "/subscriptions/########-####-####-####-############/resourceGroups/#{resource_group}/providers/Microsoft.Network/networkSecurityGroups/testGroup/defaultSecurityRules/AllowInternetOutBound",
                        'properties' =>
                          {
                            'protocol' => '*',
                            'sourceAddressPrefix' => '*',
                            'destinationAddressPrefix' => 'Internet',
                            'access' => 'Allow',
                            'direction' => 'Outbound',
                            'description' => 'Allow outbound traffic from all VMs to Internet',
                            'sourcePortRange' => '*',
                            'destinationPortRange' => '*',
                            'priority' => 65_001,
                            'provisioningState' => 'Succeeded'
                          },
                        'name' => 'AllowInternetOutBound'
                      },
                      {
                        'id' => "/subscriptions/########-####-####-####-############/resourceGroups/#{resource_group}/providers/Microsoft.Network/networkSecurityGroups/testGroup/defaultSecurityRules/DenyAllOutBound",
                        'properties' =>
                          {
                            'protocol' => '*',
                            'sourceAddressPrefix' => '*',
                            'destinationAddressPrefix' => '*',
                            'access' => 'Deny',
                            'direction' => 'Outbound',
                            'description' => 'Deny all outbound traffic',
                            'sourcePortRange' => '*',
                            'destinationPortRange' => '*',
                            'priority' => 65_500,
                            'provisioningState' => 'Succeeded'
                          },
                        'name' => 'DenyAllOutBound'
                      }
                    ],
                  'resourceGuid' => '9dca97e6-4789-4ebd-86e3-52b8b0da6cd4',
                  'provisioningState' => 'Succeeded'
                }
            }
          ]
        end
      end
    end
  end
end
