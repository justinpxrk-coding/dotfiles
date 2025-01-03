#!/bin/bash
#
# "Installs" all dotfiles in this repo. Simply adds symbolic links to the
# configuration files in this repository in the directories applications expect
# to find them.
#
# To run this script:
# chmod +x install_dotfiles.sh
# ./install_dotfiles.sh
#
# TODO: Add logging and command exit status checking

# Get directory of this script
current_path="$(dirname $(realpath $0))"

# Configure directories and files to exclude when creating symbolic links
read -r -d '' exclude_dirs <<-END
	${current_path}/.git
END
read -r -d '' exclude_files <<-'END'
	.dotfiles
	install_dotfiles.sh
	README.md
END

echo "$exclude_dirs"
echo "$exclude_files"

# Generate prune directories flags for `find`
find_prune_flags=$(
  echo $( \
    awk 'i++ > 0 { printf "-o " } ; { printf "-path %s -prune ", $1 }' <<< $exclude_dirs
  )
)

# Generate excluded file flags for `find`
find_exclude_flags=$(
  echo $( \
    awk 'i++ > 0 { printf "-o " } ; { printf "-not -name %s ", $1 }' <<< $exclude_files 
  )
)

echo $find_prune_flags
echo $find_exclude_flags

find_helper() {
  local extracted_path=$(echo "$1" | sed "s#^.*/${current_path}##")
  local conf_dir="${HOME}/.config"
  local conf_path="${conf_dir}/${extracted_path}"

  if [[ -d "$1" ]]; then
    if [[ ! -d "${conf_path}" ]]; then
      mkdir "${conf_path}"
    fi
  else
    if [[ ! -e "${conf_path}" ]]; then
      ln -s "$1" ${conf_path}
      echo "Skipping $1!"
    fi
  fi
}

# Get all directories and files in this script's directory and create
# directories and symbolic links as needed in the corresponding config
# directory
find ${current_path} \
  "${find_prune_flags}" \
  -o \("${find_exclude_flags}"\) \
  -print \
  -exec find_helper {} \;

# nvim
#ln -s "${GIT_DOTFILES_ROOT}/nvim/ftplugin" "${CONFIG_ROOT}/nvim/ftplugin"
#ln -s "${GIT_DOTFILES_ROOT}/nvim/init.vim" "${CONFIG_ROOT}/nvim/init.vim"
#ln -s "${GIT_DOTFILES_ROOT}/nvim/lua" "${CONFIG_ROOT}/nvim/lua"

# zsh
#ln -s "${GIT_DOTFILES_ROOT}/zsh/.zshrc" "${CONFIG_ROOT}/zsh/.zshrc"
#ln -s "${GIT_DOTFILES_ROOT}/zsh/.zshrc_aliases" "${CONFIG_ROOT}/zsh/.zshrc_aliases"
#ln -s "${GIT_DOTFILES_ROOT}/zsh/.zshrc_evals" "${CONFIG_ROOT}/zsh/.zshrc_evals"
#ln -s "${GIT_DOTFILES_ROOT}/zsh/.zshrc_paths" "${CONFIG_ROOT}/zsh/.zshrc_paths"
