#packages needed
# execute 'apt-get update'
package 'vim'
package 'wget'
package 'git'

android_studio_version = "2.1.2.0"
android_studio_build = "143.2915827"
android_studio_file = android_studio_version + '/android-studio-ide-' + android_studio_build + '-linux.zip'

android_sdk_file = 'android-sdk_r24.4.1-linux.tgz'

android_studio_path = 'https://dl.google.com/dl/android/studio/ide-zips/' + android_studio_file

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
    source 'https://dl.google.com/android/' + android_sdk_file
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

execute "untar sdk" do
    command "tar -xvzf /opt/android-studio/android-sdk.tgz -C /opt/android-studio --strip-components=1"
    user "root"
    action :run
    not_if {File.exist?("/opt/android-studio/android-sdk")}
end


# execute "run studio" do
#     command "sh /opt/android-studio/android-studio/bin/studio.sh"
#     user "root"
#     action :run
# end
