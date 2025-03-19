#!/bin/bash


# You are required to write a script server-stats.sh that can analyse basic server performance stats. You should be able to run the script on any Linux server and it should give you the following stats:

# Total CPU usage
# Total memory usage (Free vs Used including percentage)
# Total disk usage (Free vs Used including percentage)
# Top 5 processes by CPU usage
# Top 5 processes by memory usage


echo "===== SERVER PERFORMANCE STATS ====="
echo

# OS Version
echo "OS Version:"
cat /etc/os-release | grep PRETTY_NAME
echo

# Uptime
echo "Uptime:"
uptime -p
echo

# Load Average
echo "Load Average (1m, 5m, 15m):"
uptime | awk -F'load average:' '{ print $2 }'
echo

# Logged In Users
echo "Logged in users:"
who
echo

# CPU Usage
echo "===== CPU USAGE ====="
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'
echo

# Memory Usage
echo "===== MEMORY USAGE ====="
free -h
echo

mem_used=$(free | grep Mem | awk '{print $3}')
mem_total=$(free | grep Mem | awk '{print $2}')
mem_percentage=$(( 100 * mem_used / mem_total ))
echo "Memory Usage: $mem_used / $mem_total KB ($mem_percentage%)"
echo

# Disk Usage
echo "===== DISK USAGE ====="
df -h --total | grep total
echo

# Top 5 CPU-consuming processes
echo "===== TOP 5 PROCESSES BY CPU USAGE ====="
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
echo

# Top 5 Memory-consuming processes
echo "===== TOP 5 PROCESSES BY MEMORY USAGE ====="
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
echo

# Failed login attempts (Stretch Goal)
echo "===== FAILED LOGIN ATTEMPTS ====="
lastb | head
echo

echo "===== END OF REPORT ====="
