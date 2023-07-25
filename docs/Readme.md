TODO: Fix error

:etc:consul.d:consul.json
In /etc/consul.d/consul.json for  No private IPv4 address found error

{
  "bind_addr": "127.0.0.1",
  "datacenter": "my_datacenter",
  "log_level": "INFO",
  "enable_syslog": true,
  "ui": true,
  "server": true,
  "bootstrap_expect": 1,
  "data_dir": "/var/lib/consul",
  "ports": {
    "grpc": 8502
  }
}


sudo systemctl restart consul












sudo journalctl -u traefik -f