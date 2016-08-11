#packages needed
execute 'apt-get update'
package 'vim'
package 'wget'
package 'git'

android_studio_version = "2.1.2.0"
android_studio_build = "143.2915827"

# remote_file '/var/www/index.php' do
#     source 'http://somesite.com/index.php'
#     owner 'root'
#     group 'root'
#     mode '0755'
#     action :create
# end
