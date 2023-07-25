export 'http_proxy={{ proxy_server_url }}'
export 'https_proxy={{ proxy_server_url }}'
printf -v no_proxy '%s,' {{ subnets.0.address_prefix.split('.')[:2] }}.{1..255};
export no_proxy="${no_proxy%,}";
