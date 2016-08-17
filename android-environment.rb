user 'android' do
    comment 'Android user'
    uid '1234'
    gid '1234'
    home '/home/android'
    shell '/bin/bash'
    password 'android'
end

android_studio_version = "2.1.2.0"
android_studio_build = "143.2915827"
android_studio_file = android_studio_version + '/android-studio-ide-' + android_studio_build + '-linux.zip'
android_studio_path = 'https://dl.google.com/dl/android/studio/ide-zips/' + android_studio_file

android_sdk_file = 'android-sdk_r24.4.1-linux.tgz'
android_sdk_path = 'https://dl.google.com/android/' + android_sdk_file


file '/etc/apt/sources.list.d/webupd8team-java.list' do
    content 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main
deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main'
    mode '0755'
    owner 'root'
    group 'root'
end

#packages needed
execute 'apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886'
execute 'apt-get update'

execute "install jdk oracle" do
    command " apt-get install -y --force-yes oracle-java8-installer"
    user "root"
    action :run
end

execute "install some libs" do
    command " apt-get install -y --force-yes  lib32z1 lib32ncurses5 lib32bz2-1.0 lib32stdc++6"
    user "root"
    action :run
end

package 'vim'
package 'wget'
package 'git'

directory '/home/android/android-studio' do
    owner 'android'
    group 'android'
    mode '0755'
    action :create
end

remote_file '/home/android/android-studio/android-studio.zip' do
    source android_studio_path
    owner 'android'
    group 'android'
    mode '0755'
    action :create
end

execute "unzip studio" do
    command "unzip /home/android/android-studio/android-studio.zip -d /home/android/android-studio"
    user "android"
    action :run
    not_if {File.exist?("/home/android/android-studio/android-studio")}
end


remote_file '/home/android/android-studio/android-sdk.tgz' do
    source android_sdk_path
    owner 'android'
    group 'android'
    mode '0755'
    action :create
end

execute "untar sdk" do
    command "tar -xvzf /home/android/android-studio/android-sdk.tgz -C /home/android/android-studio --strip-components=1"
    user "android"
    action :run
    not_if {File.exist?("/home/android/android-studio/tools")}
end

execute "update sdk" do
    command "/home/android/android-studio/tools/android update sdk --no-ui"
    user "android"
    action :run
end

execute "run studio" do
    command "sh /home/android/android-studio/android-studio/bin/studio.sh"
    user "android"
    action :run
end
