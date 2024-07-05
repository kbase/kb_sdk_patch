# `kb_sdk_patch`

This docker image patches the `kbase/kb-sdk` image so that it may continue to
perform one of its core tasks: running KBase modules via docker containers.

Beginning from the current (as of 2024-07-05) `kbase/kb-sdk` image, this image
is created by running `do-release-upgrade` in place to bring the container's
Ubuntu version to 22.04. This is done primarily following the plan laid out in
[this AskUbuntu answer][do-release-upgrade].

[do-release-upgrade]: https://askubuntu.com/questions/1248184/upgrade-from-14-04-lts-to-20-04-lts
