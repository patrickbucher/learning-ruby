# Setup `rbenv`

Install `rbenv` on Arch Linux using [AUR package](https://aur.archlinux.org/packages/rbenv):

    $ git clone https://aur.archlinux.org/rbenv.git
    $ cd rbend
    $ makepkg -si --noconfirm
    $ which rbenv
    /usr/bin/rbenv

Append the following line to your `~/.bash_profile`:

    eval "$(rbenv init - bash)"

Then source `~/.bash_profile`:

    $ source `~/.bash_profile`:

Install the `ruby-build` Plugin:

    $ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

Show available stable releases:

    $ rbenv install -l

Install Ruby 3.2.0 (takes a while):

    $ rbenv install 3.2.0

Set the freshly installed version as the system global (if you haven't installed
another one yet):

    $ rbenv rehash
    $ rbenv global 3.2.0

Check the version:

    $ ruby --version
    ruby 3.2.0 …

