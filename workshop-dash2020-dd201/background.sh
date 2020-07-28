# Make the appp code available in the IDE
ln -s /ecommworkshop /root/lab

# Enable system probe for NPM
sed -i "/- DD_TAGS='env:ruby-shop'/r"<(
    echo "      - DD_SYSTEM_PROBE_ENABLED=true"
    echo "    cap_add:"
    echo "      - SYS_ADMIN"
    echo "      - SYS_RESOURCE"
    echo "      - SYS_PTRACE"
    echo "      - NET_ADMIN"
    echo "      - IPC_LOCK"
    echo "    security_opt:"
    echo "      - apparmor:unconfined"
) /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml
sed -i "/volumes:/a \ \ \ \ \ \ - /sys/kernel/debug:/sys/kernel/debug" /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml

# Get the latest lab tools
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash