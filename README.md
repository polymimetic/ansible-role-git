# Ansible Role: Git

[![Build Status](https://img.shields.io/travis/polymimetic/ansible-role-git.svg?style=flat-square)](https://travis-ci.org/polymimetic/ansible-role-git)
[![Release](https://img.shields.io/github/tag/polymimetic/ansible-role-git.svg?style=flat-square)](https://github.com/polymimetic/ansible-role-git/releases)
[![License: MIT](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-polymimetic.git-blue.svg?style=flat-square)](https://galaxy.ansible.com/polymimetic/git/)

Installs Git version control software.

## Requirements

No requirements.

## Dependencies

No dependencies.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    git_workspace: /root

Where certain files will be downloaded and adjusted prior to git installation, if needed.

    git_packages:
      - git
      - git-core
      - git-svn
      - git-extras

The specific Git packages that will be installed. By default, `git-svn` is included, but you can easily add this variable to your playbook's variables and remove `git-svn` if desired.

    git_install_from_source: false
    git_install_path: "/usr"
    git_version: "2.1.0"

Whether to install Git from source; if set to `true`, `git_version` is required and will be used to install a particular version of git (see all available versions here: https://www.kernel.org/pub/software/scm/git/), and `git_install_path` defines where git should be installed.

    git_install_from_source_force_update: false

If git is already installed at and older version, force a new source build. Only applies if `git_install_from_source` is `true`.

## Example Playbook

To run the role, include it as follows:

    - hosts: all
      roles:
         - { role: polymimetic.git, x: 42 }

## Credits

This role takes inspiration from the following Ansible roles:

- [geerlingguy.git](https://github.com/geerlingguy/ansible-role-git)

## License

This software package is licensed under the [MIT License](https://opensource.org/licenses/MIT). See the [LICENSE](./LICENSE) file for details.

## Author Information

This role was created in 2017 by [Polymimetic](https://github.com/polymimetic).

* ansible-role-git generated using [ansible-role-skeleton](https://github.com/polymimetic/ansible-role-skeleton)