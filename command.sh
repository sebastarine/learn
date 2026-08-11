



All commands That i need to know for networking by bash 
Heres a comprehensive bash command cheat sheet for networking:

## Network Diagnostics

```bash
# Test connectivity
ping google.com                          # Send ICMP echo requests
ping -c 4 google.com                     # Stop after 4 packets
ping -i 0.5 google.com                   # Set interval between pings (0.5s)

# Trace route
traceroute google.com                    # Trace packet path to host
mtr google.com                          # Real-time traceroute + ping combo
tracepath google.com                    # Trace path without root privileges

# DNS Lookup
nslookup google.com                     # Query DNS
dig google.com                          # Detailed DNS info
dig +short google.com                   # Just the IP address
dig -x 8.8.8.8                         # Reverse DNS lookup
host google.com                         # Simple DNS lookup
host 8.8.8.8                           # Reverse DNS lookup
```

## Interface & IP Configuration

```bash
# View network configuration
ip addr show                            # Show all IP addresses
ip a                                   # Short form
ip link show                           # Show network interfaces
ifconfig                               # Legacy command (may need net-tools)
ip -4 addr show                        # Show only IPv4 addresses
ip -6 addr show                        # Show only IPv6 addresses

# Interface details
ip addr show eth0                      # Show specific interface
ethtool eth0                           # Driver/hardware info
iwconfig                               # Wireless interface info

# Manage interfaces
sudo ip link set eth0 up               # Enable interface
sudo ip link set eth0 down             # Disable interface
sudo ip addr add 192.168.1.100/24 dev eth0  # Add IP address
sudo ip addr del 192.168.1.100/24 dev eth0  # Remove IP address
```

## Routing

```bash
# View routing table
ip route show                          # Show routing table
route -n                               # Legacy route display
netstat -rn                            # Another routing view

# Add/remove routes
sudo ip route add 10.0.0.0/24 via 192.168.1.1    # Add route
sudo ip route del 10.0.0.0/24                    # Delete route
sudo ip route add default via 192.168.1.1        # Add default gateway
```

## Connection Monitoring

```bash
# Active connections
ss -tuln                               # Show listening TCP/UDP ports with numbers
ss -tan                                # Show all TCP connections
ss -uan                                # Show all UDP connections
netstat -tuln                          # Legacy version
netstat -anp                           # Show all connections with PID

# Process-specific
ss -tulpn                              # Show listening ports with process names
lsof -i                                # List all network connections
lsof -i :80                            # What's using port 80
fuser 80/tcp                           # Show PID using port 80
```

## Remote Connections

```bash
# SSH
ssh user@host                          # Connect via SSH
ssh -p 2222 user@host                  # Connect to custom port
ssh -i ~/.ssh/key user@host            # Use specific private key
scp file.txt user@host:/path/          # Copy file over SSH
rsync -avz /local/ user@host:/remote/  # Sync directories

# File transfer
curl -O https://example.com/file.zip   # Download file
curl -I https://example.com            # Show headers only
wget https://example.com/file.zip      # Download with wget
wget -c https://example.com/file.zip   # Resume download

# Netcat/Socat
nc -l 1234                             # Listen on port 1234
nc host 1234                           # Connect to port 1234
nc -zv host 80                         # Scan port (verbose)
echo "test" | nc host 80              # Send data
```

## Network Analysis

```bash
# Packet capture
tcpdump -i eth0                        # Capture on interface
tcpdump -i any port 80                 # HTTP traffic only
tcpdump -i any host 192.168.1.1        # Specific host
tcpdump -w capture.pcap -i eth0        # Save to file
tcpdump -r capture.pcap                # Read from file

# Bandwidth & speed
iftop                                  # Real-time bandwidth per connection
nethogs                                # Bandwidth per process
iperf -s                               # Start iperf server
iperf -c server_ip                     # Run speed test
speedtest-cli                          # Internet speed test

# Network scanning
nmap host                              # Basic scan
nmap -p 1-1000 host                    # Scan specific port range
nmap -sV host                          # Service version detection
nmap -sn 192.168.1.0/24               # Ping sweep (find live hosts)
arp -a                                 # ARP table (local network hosts)
```

## Firewall & Security

```bash
# iptables (legacy)
sudo iptables -L -n -v                 # List all rules with details
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # Allow SSH
sudo iptables -A INPUT -p tcp --dport 80 -j DROP    # Block HTTP
sudo iptables-save                     # Save rules

# ufw (Uncomplicated Firewall)
sudo ufw status                        # Check firewall status
sudo ufw enable                        # Enable firewall
sudo ufw allow 22/tcp                  # Allow SSH
sudo ufw deny 80                       # Block HTTP
sudo ufw allow from 192.168.1.0/24    # Allow from subnet

# SSL/TLS
openssl s_client -connect host:443     # Test SSL connection
openssl s_client -connect host:443 -servername example.com  # SNI support
curl -vI https://example.com           # Verbose HTTPS request
```

## HTTP/REST Testing

```bash
# curl for API testing
curl -X GET https://api.example.com/data           # GET request
curl -X POST -d "key=value" https://api.example.com # POST data
curl -H "Content-Type: application/json" -d '{}' URL  # JSON POST
curl -u user:pass https://api.example.com          # Basic auth
curl -x proxy:8080 https://example.com             # Via proxy

# HTTPie (if installed)
http GET https://api.example.com/data
http POST https://api.example.com key=value
http -a user:pass https://api.example.com
```

## Wireless Networks

```bash
# WiFi management
iwconfig                               # Wireless interface info
iwlist wlan0 scan                      # Scan for WiFi networks
nmcli dev wifi list                    # NetworkManager WiFi scan
nmcli dev wifi connect SSID password PASS  # Connect to WiFi

# Bluetooth
hcitool scan                           # Scan Bluetooth devices
bluetoothctl                           # Interactive Bluetooth manager
```

## Useful One-Liners

```bash
# Get external IP
curl ifconfig.me
curl icanhazip.com
dig +short myip.opendns.com @resolver1.opendns.com

# Monitor new connections
watch -n 1 'ss -tan | grep ESTAB'

# Find process using specific port
lsof -i :80 -P

# Quick HTTP server
python3 -m http.server 8000            # Python 3
python -m SimpleHTTPServer 8000        # Python 2

# Check if port is open
timeout 3 bash -c '</dev/tcp/host/port && echo OPEN || echo CLOSED' 2>/dev/null

# Continuous ping with timestamp
ping google.com | while read p; do echo "$(date): $p"; done

# Monitor DNS queries
sudo tcpdump -i any port 53
```

## ARP & MAC Address

```bash
# ARP table manipulation
arp -a                                 # Display ARP cache
ip neigh show                          # Modern ARP table view
sudo ip neigh add 192.168.1.100 lladdr 00:11:22:33:44:55 dev eth0  # Add ARP entry
sudo ip neigh del 192.168.1.100 dev eth0  # Delete ARP entry

# MAC address
ip link show eth0 | grep ether         # Show MAC address
macchanger -r eth0                     # Random MAC (if installed)
```

This cheat sheet covers the most commonly used networking commands in bash. Let me know if you'd like me to expand on any specific area!
