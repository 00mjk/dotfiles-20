# Sourced by other install scripts.

backup_and_symlink () {
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

# echo doesn't work for appending to a file in this case, because
# it expands variables recursively
# sudo bash -c "echo $CONTENT_LINE >> $TARGET_FILE"
# Using sed instead, see <http://www.thegeekstuff.com/2009/11/unix-sed-tutorial-append-insert-replace-and-count-file-lines/#append_lines>
# Also add a blank line before the new content.
append_if_missing () {
  local TARGET_FILE=$1
  local CONTENT_LINE=$2

  if [ "$(grep -F "${CONTENT_LINE}" $TARGET_FILE)" ]; then
    echo "-- line \"$CONTENT_LINE\" already in $TARGET_FILE"
  else
    echo "${CONTENT_LINE}" >> "${TARGET_FILE}"
    echo "-- added \"$CONTENT_LINE\" to $TARGET_FILE"
  fi
}
