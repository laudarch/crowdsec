#!/usr/bin/env bats

LIB="$(dirname "$BATS_TEST_FILENAME")/../lib"
#shellcheck source=../lib/wrap-init.sh
. "$LIB/wrap-init.sh"

setup_file() {
  "$SYSTEMCTL" start crowdsec
}

teardown_file() {
  # "$SYSTEMCTL" stop crowdsec
  :
}

#----------

@test "hub tests" {
  repodir=$(mktemp -d)
  run git clone --depth 1 https://github.com/crowdsecurity/hub.git "${repodir}"
  [ $status -eq 0 ]
  pushd "${repodir}"
  run cscli hubtest run --all
  [ $status -eq 0 ]
  popd
  rm -rf -- "${repodir}"
}
