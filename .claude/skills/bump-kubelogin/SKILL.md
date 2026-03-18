---
name: bump-kubelogin
description: 'Bump the kubelogin Homebrew formula to a new upstream release version. Triggers: "bump kubelogin", "update kubelogin", "kubelogin version bump", "new kubelogin release", "upgrade kubelogin".'
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(gh:*), Bash(git:*), Bash(curl:*), Bash(grep:*)
---

# Skill: Bump kubelogin Version

Bump the kubelogin Homebrew formula to a new upstream release version.

## Overview

This skill updates the two Homebrew formula files (`Formula/kubelogin.rb` and `Formula/az-kubelogin.rb`) to a new kubelogin release version. Both files share the same version string and SHA256 checksums -- only the installed binary name differs.

## What Changes Per Version Bump

Each bump modifies exactly **4 values** in **2 files** (8 edits total):

| Value | Line pattern |
|---|---|
| Version string | `version "X.Y.Z"` (line 7) |
| darwin-amd64 SHA256 | `sha256` after `kubelogin-darwin-amd64.zip` URL (line 13) |
| darwin-arm64 SHA256 | `sha256` after `kubelogin-darwin-arm64.zip` URL (line 16) |
| linux-amd64 SHA256 | `sha256` after `kubelogin-linux-amd64.zip` URL (line 19) |

Files to update:
- `Formula/kubelogin.rb`
- `Formula/az-kubelogin.rb`

## Workflow

### Step 1: Determine Target Version

If the user provides a version (e.g., "bump kubelogin to 0.2.16"), use that version. Strip any leading `v` prefix.

If no version is provided, auto-detect the latest release:

```bash
gh release view --repo Azure/kubelogin --json tagName --jq '.tagName' | sed 's/^v//'
```

### Step 2: Read Current Version

Extract the current version from the formula:

```bash
grep -m1 'version "' Formula/kubelogin.rb | sed 's/.*version "\(.*\)"/\1/'
```

If the current version equals the target version, inform the user that the formula is already up to date and stop.

### Step 3: Branch Hygiene

Follow the standard branch hygiene protocol:

```bash
git fetch origin
git checkout master
git reset --hard origin/master
git checkout -b update-kubelogin-v<VERSION>
```

### Step 4: Fetch SHA256 Checksums

Download the `.sha256` checksum files from the GitHub release for all 3 platforms:

```bash
ARCHIVES=("kubelogin-darwin-amd64.zip" "kubelogin-darwin-arm64.zip" "kubelogin-linux-amd64.zip")
for archive in "${ARCHIVES[@]}"; do
  curl -sL "https://github.com/Azure/kubelogin/releases/download/v<VERSION>/${archive}.sha256"
done
```

Each `.sha256` file contains a line like: `<64-char-hex>  <filename>`

Extract just the hex hash from each. **Validate** that each hash is exactly 64 hex characters. If any download fails or hash is malformed, stop and report the error.

Assign the results:
- `SHA_DARWIN_AMD64` = hash from `kubelogin-darwin-amd64.zip.sha256`
- `SHA_DARWIN_ARM64` = hash from `kubelogin-darwin-arm64.zip.sha256`
- `SHA_LINUX_AMD64` = hash from `kubelogin-linux-amd64.zip.sha256`

### Step 5: Update Both Formula Files

For **each** of `Formula/kubelogin.rb` and `Formula/az-kubelogin.rb`, make exactly 4 edits using the Edit tool:

1. **Version string:** Replace `version "<OLD_VERSION>"` with `version "<NEW_VERSION>"`
2. **darwin-amd64 sha256:** Replace the `sha256 "..."` on the line after the `kubelogin-darwin-amd64.zip` URL
3. **darwin-arm64 sha256:** Replace the `sha256 "..."` on the line after the `kubelogin-darwin-arm64.zip` URL
4. **linux-amd64 sha256:** Replace the `sha256 "..."` on the line after the `kubelogin-linux-amd64.zip` URL

Use precise context (include the `url` line above each `sha256` line) to ensure the Edit tool matches the correct location.

**Example edit for darwin-amd64 in kubelogin.rb:**

oldString:
```
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "<OLD_HASH>"
```

newString:
```
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "<NEW_HASH>"
```

Repeat the same pattern for darwin-arm64 and linux-amd64 in both files.

### Step 6: Verify Changes

After editing, read both files to confirm:
- The version string is correct
- All 3 SHA256 hashes are updated and match the downloaded values
- No other lines were changed
- Both files have identical version and checksums

Run `git diff` to review the changes -- there should be exactly 8 lines changed per file (4 removed, 4 added).

### Step 7: Commit and Push

```bash
git add Formula/kubelogin.rb Formula/az-kubelogin.rb
git commit -m "Bump kubelogin to v<VERSION>"
git push -u origin update-kubelogin-v<VERSION>
```

### Step 8: Create Pull Request

Create a PR targeting `master`:

```bash
gh pr create \
  --title "Bump kubelogin to v<VERSION>" \
  --body "## Summary
- Bumps kubelogin from v<OLD_VERSION> to v<VERSION>
- Updates SHA256 checksums for all 3 platforms (darwin-amd64, darwin-arm64, linux-amd64)

**Release:** https://github.com/Azure/kubelogin/releases/tag/v<VERSION>" \
  --base master
```

Report the PR URL to the user.

## Error Handling

- If `gh release view` fails, the version may not exist. Ask the user to verify.
- If any `.sha256` file download returns a 404, the release assets may not be published yet. Inform the user.
- If SHA256 values are not valid 64-character hex strings, stop and report the issue.
- If a branch named `update-kubelogin-v<VERSION>` already exists remotely, inform the user and ask how to proceed.

## Notes

- The repo also contains `get-sha256.sh` which can be used as an alternative to manually curling checksums: `KUBELOGIN_VERSION=<VERSION> ./get-sha256.sh`
- The upstream release page is: `https://github.com/Azure/kubelogin/releases`
- The default branch is `master` (not `main`)
