#!/bin/bash
# create release branch for hofixes, create issue with RELEASE tag, create changelog and update version

# GutHub environment variables:
# $ACCESS_TOKEN
# $USER_EMAIL
# $USER_NAME

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


# generate changelog and change app version using standard-version
VERSION_NUMBER=${1:1}
npx standard-version --release-as $VERSION_NUMBER --skip.tag

# creating a release issue
gh issue create --title "Release $1" --body "Insert body here" --label "RELEASE" --assignee $2 --body-file ./CHANGELOG.md
