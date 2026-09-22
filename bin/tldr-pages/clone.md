# clone

> Shallow-clone a GitHub repo into `~/git/<user>---<repo>`, parsed from any URL that points into the repo.
> Personal script; see `clone --help`.

- Clone a repo from its GitHub URL:

`clone {{https://github.com/user/repo}}`

- Clone from a deep link (blob/tree/issues/...) - same result:

`clone {{https://github.com/user/repo/blob/main/path/to/file}}`
