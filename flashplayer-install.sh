#!/bin/sh

. linux/share/functions

case "`lsb_release -sc`" in
    "hardy")
        MKTEMP_OPTS="-t"
    ;;

    *)
        MKTEMP_OPTS="--tmpdir"
    ;;
esac

download_dir=${download_dir:-`mktemp -d ${MKTEMP_OPTS} flashplayer-download-XXXXXX`}
unpack_dir=${unpack_dir:-`mktemp -d ${MKTEMP_OPTS} flashplayer-unpack-XXXXXX`}
orig_dir=${unpack_dir}/install_flash_player_linux_sa
dest_dir=${1}

flashplayer_download ${download_dir}
flashplayer_unpack ${download_dir} ${unpack_dir}
flashplayer_install ${orig_dir} ${dest_dir} && rm -rf ${download_dir} ${unpack_dir}
