set -v
# Download dat into system place
sudo curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
# Make executable actually executable
sudo chmod +x /usr/local/bin/docker-compose
# test:
echo "if you don't see the version, installation failed"
docker-compose --version
