#!/usr/bin/env bash

# skip branch/revision with missing git repo.
if [[ -d .git ]] || git rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git symbolic-ref HEAD 2>/dev/null)
    [[ -z "$VERSION" ]] && VERSION=$(git symbolic-ref -q --short HEAD || git describe --tags --exact-match)
    revision=$(git log -1 --pretty=format:"%H" 2>/dev/null)
fi

build_user="$USER"
build_date=$(date +%FT%T%Z)

#if [[ -d vendor ]] && [[ ! -e go.mod ]]; then
#    version_pkg="$MODULE_NAME"/vendor/github.com/bool64/dev-go/version
#else
    version_pkg=github.com/bool64/dev-go/version
#fi

echo -X "$version_pkg".version="$VERSION" -X "$version_pkg".branch="$branch" -X "$version_pkg".revision="$revision" -X "$version_pkg".buildUser="$build_user" -X "$version_pkg".buildDate="$build_date"
