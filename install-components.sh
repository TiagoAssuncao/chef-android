# Update system
sudo apt-get update

# Install chef
sudo apt-get install -y --force-yes chef

# Run chef recipe
sudo chef-apply android-environment.rb
