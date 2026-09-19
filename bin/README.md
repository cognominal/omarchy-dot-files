# bin

Personal scripts. Documented here as they gain enough behavior to need it.

## charm-git-repos

Interactive TUI (built on [`gum`](https://github.com/charmbracelet/gum)) for
browsing a GitHub user's repositories and cloning/updating them into a local
`~/git` directory, one status icon at a time.

### Requirements

- `git`
- `gum`
- `gh`, authenticated (`gh auth login`)
- `jq`
- `fd` (or `fdfind` on Debian/Ubuntu)

The script checks for all of these on startup and exits with an error if any
are missing.

### Usage

```sh
charm-git-repos
```

No arguments. Everything is chosen interactively:

1. **Pick a GitHub user.** If `~/git` already contains repos cloned by this
   tool (see naming convention below), you get a fuzzy-filterable list of
   users seen locally (`gum filter`), and can type a new username instead of
   picking one. If `~/git` has no such repos yet, you're just prompted for a
   username (`gum input`).
2. **Repo list.** The script fetches up to 100 repos for that user via
   `gh repo list` and shows each one prefixed with a status icon:

   | Icon   | Meaning                                      |
   |--------|-----------------------------------------------|
   | `1`    | Cloned locally as a shallow clone (`--depth=1`) |
   | ` `    | Not cloned locally                            |
   | `100%` | Cloned and up to date with `origin/HEAD`      |
   | `✔`    | Cloned but behind `origin/HEAD`               |

3. **Pick a repo** (`gum choose`) and the script acts based on its status:

   | Status        | Action                          |
   |---------------|----------------------------------|
   | Not cloned    | `git clone --depth=1 <url> <dest>` |
   | Shallow clone | `git fetch --unshallow`          |
   | Behind        | `git pull --ff-only`             |
   | Up to date    | Nothing — reports it's current   |

### Local layout

Repos are cloned into:

```
~/git/<github_user>---<repo_name>
```

The `<user>---<repo>` naming is what lets step 1 rediscover which GitHub
users you've already pulled repos from, by scanning `~/git` one level deep
with `fd` and matching the `---` separator.

### Notes / gotchas

- Status detection does a `git fetch --dry-run` before comparing
  `HEAD..origin/HEAD`, so it needs network access and a remote named `origin`
  with `HEAD` tracked.
- Updates use `git pull --ff-only`, so a repo with diverged local commits
  will fail to update rather than merge or rebase.
- `gh repo list` is capped at 100 repos per user; users with more repos will
  only see the first 100 returned by the GitHub API.
