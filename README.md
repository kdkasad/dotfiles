# dotfiles
A repository to save & version-control my dotfiles (configuration files)

## Installing on another machine

To install these files on another machine, there are three options:

#### Hard-link from repository (recommended)

**Instructions**

1. Clone this repository to your machine (ex. `git clone git://github.com/kdkasad/dotfiles.git ~/.dotfiles`)
2. Create [hard links](https://en.wikipedia.org/wiki/Hard_link) to the files in the repository for each dotfile. (ex. `ln ~/.dotfiles/.bashrc ~/.bashrc`)
2a. Since directories cannot be hard-linked, you can use `cp -al <SOURCE> <DEST>` to recursively copy the directory's contents, but using hard links for all the files.
(ex. `cp -al ~/.dotfiles/.vim ~/.vim` will recursively hard-link all files in the `dotfiles/.vim` directory to `~/.vim`)

**Pros**

- When files in the repository are updated, the changes will automatically apply to the destination files (ex. changes from `dotfiles/.bashrc` will apply to `~/.bashrc`)
- Changes to the destination files will automatically apply to the repository as well (inverse of the previous note) (ex. changes to `~/.bashrc` will apply to `dotfiles/.bashrc`)
- Since the files are only linked, they don't take up any more disk space (useful when you have lots of dotfiles)
- Can be fully updated using `git pull`

**Cons**

- More complicated
#### Copy files from repository

**Instructions**

1. Clone this repository to your machine (ex. `git clone git://github.com/kdkasad/dotfiles.git ~/.dotfiles`)
2. Copy needed files to their destination (ex. `cp ~/.dotfiles/.bashrc ~/.bashrc`)

**Pros**

- Simpler
- Can be halfway updated using `git pull` (files still need to be copied to their destination)

**Cons**

- Any time a file is updated, it has to be re-copied to its destination. Changes in one location *do not* apply to the file's other locations
- Since the files are copied, they take up twice as much disk space

#### Download specific files from GitHub

**Instructions**

1. Go to https://github.com/kdkasad/dotfiles
2. Navigate to the file you want to download
3. Download it

**Pros**

- None

**Cons**

- Takes much longer than the other methods
- Requires a web browser
- Cannot be updated with `git pull`
