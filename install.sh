#! /usr/bin/env bash
set -e
###########################################################################
#
# Git Bootstrap Installer
# https://github.com/polymimetic/ansible-role-git
#
# This script is intended to replicate the ansible role in a shell script
# format. It can be useful for debugging purposes or as a quick installer
# when it is inconvenient or impractical to run the ansible playbook.
#
# Usage:
# wget -qO - https://raw.githubusercontent.com/polymimetic/ansible-role-git/master/install.sh | bash
#
###########################################################################

if [ `id -u` = 0 ]; then
  printf "\033[1;31mThis script must NOT be run as root\033[0m\n" 1>&2
  exit 1
fi

###########################################################################
# Constants and Global Variables
###########################################################################

readonly GIT_REPO="https://github.com/polymimetic/ansible-role-git.git"
readonly GIT_RAW="https://raw.githubusercontent.com/polymimetic/ansible-role-git/master"

###########################################################################
# Basic Functions
###########################################################################

# Output Echoes
# https://github.com/cowboy/dotfiles
function e_error()   { echo -e "\033[1;31m✖  $@\033[0m";     }      # red
function e_success() { echo -e "\033[1;32m✔  $@\033[0m";     }      # green
function e_info()    { echo -e "\033[1;34m$@\033[0m";        }      # blue
function e_title()   { echo -e "\033[1;35m$@.......\033[0m"; }      # magenta

###########################################################################
# Install Git
# https://git-scm.com/
#
# https://github.com/tj/git-extras
# https://github.com/b4b4r07/ssh-keyreg
# https://help.github.com/articles/ignoring-files/
# https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/
###########################################################################

install_git() {
  e_title "Installing Git"

  local git_name=""
  local git_email=""
  local git_github_user=""
  local git_bitbucket_user=""
  local git_github_password=""
  local git_bitbucket_password=""

  # Install git packages
  sudo apt-get install -yq \
  git git-core git-svn git-extras

  # Configure Git
  git config --global user.name "${git_name}"
  git config --global user.email "${git_email}"
  git config --global github.user "${git_github_user}"
  git config --global bitbucket.user "${git_bitbucket_user}"
  git config --global core.editor nano
  git config --global core.excludesfile ${HOME}/.gitignore
  git config --global push.default simple
  git config --global color.branch auto
  git config --global color.diff auto
  git config --global color.interactive auto
  git config --global color.status true
  git config --global color.ui true
  git config --global credential.helper cache

  # Configure gitignore
  wget -O ${HOME}/.gitignore https://gist.githubusercontent.com/octocat/9257657/raw/3f9569e65df83a7b328b39a091f0ce9c6efc6429/.gitignore

  # Set git SSH key registration script
  if [[ ! -f "/usr/local/bin/ssh-keyreg" ]]; then
    sudo sh -c "curl https://raw.githubusercontent.com/b4b4r07/ssh-keyreg/master/bin/ssh-keyreg -o /usr/local/bin/ssh-keyreg && chmod +x /usr/local/bin/ssh-keyreg"
  fi

  # Add SSH keys to GitHub & Bitbucket
  if [[ -f "${HOME}/.ssh/id_rsa.pub" ]]; then
    ssh-keyreg --path ${HOME}/.ssh/id_rsa.pub --user ${git_github_user}:${git_github_password} github
    ssh-keyreg --path ${HOME}/.ssh/id_rsa.pub --user ${git_bitbucket_user}:${git_bitbucket_password} bitbucket
  fi

  e_info "Git version: $(git --version) installed."
  e_success "Git installed"
}

###########################################################################
# Program Start
###########################################################################

program_start() {
  install_git
}

program_start