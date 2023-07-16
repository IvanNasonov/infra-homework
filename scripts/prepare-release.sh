#!/bin/bash
# create release branch for hofixes, create issue with RELEASE tag, create changelog and update version

# GutHub environment variables:
# $user_name
# $user_email

# Variables
# $1 - version tag name
# $2 - user who initialted release

# configure git user
echo "Setting up git user"
echo "Setting name to $user_name"
echo "Setting email to $user_email"
git config --global user.email $user_name
git config --global user.name $user_email

echo $(git config --global user.email)
echo $(git config --global user.name)

# create release branch for hotfixes
NEW_BRANCH_NAME="release-$1"
echo "Creating branch $NEW_BRANCH_NAME"
git checkout -b $NEW_BRANCH_NAME
git push --set-upstream origin $NEW_BRANCH_NAME


# generate changelog and change app version using standard-version
VERSION_NUMBER=${1:1}
echo "Creating changelog for $VERSION_NUMBER"
npx standard-version -- --release-as "$VERSION_NUMBER" --skip.tag

# creating a release issue
gh issue create --title "Release $1" --body "Insert body here" --label "RELEASE" --assignee $2 --body-file ./CHANGELOG.md
