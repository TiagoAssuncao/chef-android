# Adding the user Android
user 'android' do
    comment 'Android user'
    uid '1234'
    gid 'root'
    home '/home/android'
    shell '/bin/bash'
    action :create
end

# Creating directory home to android
directory '/home/android/' do
    owner 'android'
    mode '0755'
    action :create
end

# Adding variables to get android studio and sdk
android_studio_version = "2.1.2.0"
android_studio_build = "143.2915827"
android_studio_file = android_studio_version + '/android-studio-ide-' + android_studio_build + '-linux.zip'
android_studio_path = 'https://dl.google.com/dl/android/studio/ide-zips/' + android_studio_file
android_sdk_file = 'android-sdk_r24.4.1-linux.tgz'
android_sdk_path = 'https://dl.google.com/android/' + android_sdk_file


# Adding java repository to source list
file '/etc/apt/sources.list.d/webupd8team-java.list' do
    content 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main
deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main'
    mode '0755'
    owner 'root'
    group 'root'
end

# Install jdk oracle
# execute 'apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886'
execute 'add-apt-repository ppa:webupd8team/java'
execute 'apt-get update'
execute "install jdk oracle" do
    command " apt-get install oracle-java8-installer"
    user "root"
    action :run
end

# Install libs needed to run sdk
execute "install libs" do
    command " apt-get install -y --force-yes  lib32z1 lib32ncurses5 lib32bz2-1.0 lib32stdc++6"
    user "root"
    action :run
end

# Packages needed
package 'vim'
package 'wget'
package 'git'
package 'unzip'

# Creating directory android on user android
directory '/home/android/android-studio' do
    owner 'android'
    mode '0755'
    action :create
end

# Getting android studio from dl.google
remote_file '/home/android/android-studio/android-studio.zip' do
    source android_studio_path
    owner 'android'
    mode '0755'
    action :create
end

execute "unzip studio" do
    command "unzip /home/android/android-studio/android-studio.zip -d /home/android/android-studio"
    user "android"
    action :run
    not_if {File.exist?("/home/android/android-studio/android-studio")}
end

# Getting android sdk from dl.google
remote_file '/home/android/android-studio/android-sdk.tgz' do
    source android_sdk_path
    owner 'android'
    mode '0755'
    action :create
end

execute "untar sdk" do
    command "tar -xvzf /home/android/android-studio/android-sdk.tgz -C /home/android/android-studio --strip-components=1"
    user "android"
    action :run
    not_if {File.exist?("/home/android/android-studio/tools")}
end

# Update sdk without ui
execute "update sdk" do
    command "/home/android/android-studio/tools/android update sdk --no-ui"
    user "android"
    action :run
end

# Execute android studio using sh
execute "run studio" do
    command "sh /home/android/android-studio/android-studio/bin/studio.sh"
    user "android"
    action :run
end
