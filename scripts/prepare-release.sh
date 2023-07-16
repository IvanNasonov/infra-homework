#!/bin/bash
# create release branch for hofixes, create issue with RELEASE tag, create changelog and update version

# GutHub environment variables:
# $GITHUB_ACCESS_TOKEN
# $GITHUB_REPOSITORY
# $GITHUB_USER_EMAIL
# $GITHUB_USER_NAME
# $GITHUB_PROJECT_NAME
# $GITHUB_PROJECT_ID
# $ISSUE_URL_FORMAT

# Variables
# $1 - version tag name

# configure git user
git config --global user.email $GITHUB_USER_EMAIL
git config --global user.name $GITHUB_USER_NAME

NEW_VERSION=$1

git checkout -b $NEW_VERSION
git push –set-upstream origin $NEW_VERSION
