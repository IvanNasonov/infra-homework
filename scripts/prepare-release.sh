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
# $2 - user who initialted release

# configure git user
git config --global user.email $USER_EMAIL
git config --global user.name $USER_NAME

# create release branch for hotfixes
NEW_BRANCH_NAME="release-$1"

echo "creating branch $NEW_BRANCH_NAME"

git checkout -b $NEW_BRANCH_NAME
git push --set-upstream origin $NEW_BRANCH_NAME

#creating a release issue
gh issue create --title "Release $1" --body "Insert body here" --label "RELEASE" --assigne $2
