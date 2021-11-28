# vim: set ft=bash:

# Sourced by other install scripts.

function backup_and_symlink () {
  # remove trailing slashes
  local target_path="$(echo "${1}" | sed -E 's|/+$||')"
  local symlink_path="$(echo "${2}" | sed -E 's|/+$||')"
  local base_dir="$(dirname "$symlink_path")"
  local timestamp="$(date -u +"%Y%m%dT%H%M%SZ")"

  # If the location of the symlink exists and it's not a symlink,
  # make a backup first.
  if [[ -e "${symlink_path}" && ! -L "${symlink_path}" ]]; then
    printf "Backup: "
    mv -v "${symlink_path}" "${symlink_path}.${timestamp}.bkp"
  fi

  # If the destination dir does not exist, create it as
  # the location of the symlink.
  if [[ ! -d "${base_dir}" ]]; then
    printf "Create dir: "
    mkdir -vp "${base_dir}"
  fi

  # -v (verbose) is non-standard but available on both mac and linux.
  # -n (no dereference), works both on mac and linux;
  #    it's an alias for -h on mac.
  #    If the target_file or target_dir is a symbolic link,
  #    do not follow it.
  #    This is most useful with the -f option, to replace a
  #    symlink which may point to a directory, otherwise it
  #    will create the link inside the target dir.
  printf "Symlink: "
  ln -sfnv "${target_path}" "${symlink_path}"
}

function append_if_missing () {
  local dest=$1
  local content=$2

  if [[ $(grep --line-regexp --fixed-strings --regexp="$content" $dest) ]]; then
    echo "==> skipping \"$content\", already in $dest"
  else
    if [ -w $dest ]; then
      echo "${content}" >> "${dest}"
    else
      echo "==> Requesting sudo because the destination '${dest}' is not writable:"
      echo "${content}" | sudo tee -a "${dest}" > /dev/null
    fi
    echo "==> added \"$content\" to $dest"
  fi
}

# usr_local returns either /usr/local or /opt/homebrew depending on the system,
# and is used to link to various support files
function usr_local () {
	if [[ "$(uname -m)" == "arm64" && "$(uname -s)" == "Darwin" ]]; then
    echo '/opt/homebrew'
  elif [[ "$(uname -m)" == "x86_64" ]]; then
    echo '/usr/local'
  elif [[ "$(uname -m)" == "aarch64" && "$(uname -s)" == "Linux" ]]; then
    echo '/usr/local'
  fi
}
