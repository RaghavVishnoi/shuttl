server  '54.200.116.105', user: 'ubuntu', roles: %w{web app db}, my_property: :my_value

set :ssh_options, {
  keys: %w{/home/linchpin/Documents/sar_out.pem},
  forward_agent: true
}