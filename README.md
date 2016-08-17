# chef-android-linux
A recipe to android environment on linux system. This recipe was made to work in  elementary OS, but it tends to work with any distro.

## Technology Stack
Many packages will be instaled:

1. [Chef recipe](https://www.chef.io/chef/)
2. [JDK 8 - Oracle](http://www.oracle.com/technetwork/pt/java/javase/overview/index.html)
3. Libs: [lib32z1](http://packages.ubuntu.com/search?keywords=lib32z1), [lib32ncurses5](http://packages.ubuntu.com/search?keywords=lib32ncurses5), [lib32bz2-1.0](http://packages.ubuntu.com/search?keywords=lib32bz2-1.0), [lib32stdc++6](http://packages.ubuntu.com/trusty/libs/lib32stdc++6)
4. [Vim](http://www.vim.org/)
5. [Wget](https://www.gnu.org/software/wget/)
6. [Git](https://git-scm.com/)
7. [Android Studio & Android SDK](https://developer.android.com/studio/index.html)

## Instalation

To install this recipe is so easy. You just need run this command:
```sh
git clone https://github.com/TiagoAssuncao/chef-android-linux
cd chef-android-linux
sh install-components.sh
```
