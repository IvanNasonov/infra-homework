#!/bin/bash
# create release branch for hofixes, create issue with RELEASE tag, create changelog and update version

# GutHub environment variables:
# $user_name
# $user_email

# Variables
# $1 - version tag name
# $2 - user who initialted release
# $3 - changelog

echo "ChangeLog $3"

# configure git user
echo "Setting up git user"
echo "Setting name to $user_name"
echo "Setting email to $user_email"
git config --global user.email $user_email
git config --global user.name $user_name
git checkout master
git fetch --all --tags
git fetch --prune --unshallow

# remember previous version
PREV_VERSION=$(node -p "require('./package.json').version")
PREV_TAG=v$PREV_VERSION

echo "Previous tag is ${PREV_TAG}"

# update version and changelog
VERSION_NUMBER=${1:1}
echo "Creating changelog for $VERSION_NUMBER"
npx standard-version --release-as $VERSION_NUMBER --skip.tag
git push origin master


# create release branch for hotfixes
NEW_BRANCH_NAME="release-$1"
echo "Creating branch $NEW_BRANCH_NAME"
git checkout -b $NEW_BRANCH_NAME
git push --set-upstream origin $NEW_BRANCH_NAME

# get release notes from diff in changelog
# 1. get diff of changelog file which will return only new additions since last version
# 2. egrep prints only lines of diff with pluses in the beginning
# 3. cut cunts the "+" character and limits line length to 1024 characrers
# 4. awk prints the lines with newlines
echo "Preparing release notes"
RELEASE_NOTES=$(git diff $PREV_TAG $1 CHANGELOG.md | egrep '^\+' | cut -c2-1024 | awk '{printf "%s\\n", $0}')
echo "Release notes $RELEASE_NOTES"


# creating a release issue
gh issue create --title "Release $1" --body "Insert body here" --label "RELEASE" --assignee $2 --body $RELEASE_NOTES
