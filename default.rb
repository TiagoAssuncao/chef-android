#packages needed
# execute 'apt-get update'
package 'vim'
package 'wget'
package 'git'

android_studio_version = "2.1.2.0"
android_studio_build = "143.2915827"
android_studio_path = 'https://dl.google.com/dl/android/studio/ide-zips/' + android_studio_version + '/android-studio-ide-' + android_studio_build + '-linux.zip'

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
