#! /nix/store/ki4if6b0w5bqv8dc5lrjp8xm7wjy9dlf-bash-5.2p37/bin/bash -e
PATH=${PATH:+':'$PATH':'}
PATH=${PATH/':''/nix/store/zm0c5afpjy6vjw1dzk7zaymns7nxjkyf-transcript-1.0/bin'':'/':'}
PATH='/nix/store/zm0c5afpjy6vjw1dzk7zaymns7nxjkyf-transcript-1.0/bin'$PATH
PATH=${PATH#':'}
PATH=${PATH%':'}
export PATH
PATH=${PATH:+':'$PATH':'}
PATH=${PATH/':''/nix/store/wz0j2zi02rvnjiz37nn28h3gfdq61svz-python3-3.12.9/bin'':'/':'}
PATH='/nix/store/wz0j2zi02rvnjiz37nn28h3gfdq61svz-python3-3.12.9/bin'$PATH
PATH=${PATH#':'}
PATH=${PATH%':'}
export PATH
export PYTHONNOUSERSITE='true'
exec -a "$0" "/nix/store/zm0c5afpjy6vjw1dzk7zaymns7nxjkyf-transcript-1.0/bin/.transcript.py-wrapped"  "$@" 
