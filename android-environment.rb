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

directory '/opt/android-studio' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

remote_file '/opt/android-studio/android-studio.zip' do
    source android_studio_path
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

execute "unzip studio" do
    command "unzip /opt/android-studio/android-studio.zip -d /opt/android-studio"
    user "root"
    action :run
    not_if {File.exist?("/opt/android-studio/android-studio")}
end


remote_file '/opt/android-studio/android-sdk.tgz' do
    source android_sdk_path
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

execute "untar sdk" do
    command "tar -xvzf /opt/android-studio/android-sdk.tgz -C /opt/android-studio --strip-components=1"
    user "root"
    action :run
    not_if {File.exist?("/opt/android-studio/tools")}
end

execute "update sdk" do
    command "/opt/android-studio/tools/android update sdk --no-ui"
    user "root"
    action :run
end

execute "run studio" do
    command "sh /opt/android-studio/android-studio/bin/studio.sh"
    user "root"
    action :run
end
