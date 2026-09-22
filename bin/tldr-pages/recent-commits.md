# recent-commits

> List your most recent commits across all GitHub repos your token can see, via `gh search commits`.
> Personal script; see `recent-commits --help`.

- Show your last 20 commits (default):

`recent-commits`

- Show a specific number:

`recent-commits -n {{50}}`

- Search a different GitHub user:

`recent-commits -a {{username}}`

- Pass extra `gh search commits` flags through, e.g. limit to one repo:

`recent-commits --repo {{owner/repo}}`
