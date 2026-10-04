# Reiss Koh: homepage

A small [Hugo](https://gohugo.io/) site (the homepage plus a More Publications page) with no theme, no npm
and no build tools besides Hugo; the only JavaScript is a few lines for the light/dark toggle.
Every commit to `main` is published to GitHub Pages automatically. Before the first deploy, do the
[one-time setup](#one-time-setup).

## What's where

| To change …                                                     | edit …                                                     |
| --------------------------------------------------------------- | ---------------------------------------------------------- |
| Bio (About section)                                             | `content/_index.md`: the text below the `---` block        |
| Title in the browser tab and in link previews                   | `title` in `content/_index.md`                             |
| Sidebar: name, role, affiliation, location, links, interests    | `data/profile.yaml`                                        |
| News                                                            | `data/news.yaml`                                           |
| Papers                                                          | `data/publications.yaml`                                   |
| Experience, education, awards, service, mentees, collaboration  | `data/cv.yaml`                                             |
| Photo                                                           | `assets/images/visa_dp.png` (`photo` in `data/profile.yaml`) |
| How many news items show before the "older news" toggle         | `newsVisible` in `hugo.toml`                               |
| Emoji at the end of news items on/off                           | `newsEmoji` in `hugo.toml` (`true` or `false`)             |
| Title of the second page with the other papers                  | `title` in `content/publications.md`                       |

**Editing on GitHub:** open the file, click the pencil icon, edit, then **Commit changes**.
To replace the photo, open `assets/images/`, choose **Add file → Upload files**, upload any photo (JPG or PNG, any size),
and set `photo` in `data/profile.yaml` to its name with exact upper/lower case, e.g. `"images/me.jpg"`. It is cropped to a
centred square and resized automatically.
To link a file such as a CV, upload it to `static/files/` the same way and link it as `files/cv.pdf` (no `/` in front),
e.g. `url: "files/cv.pdf"` in `data/profile.yaml`, or `[CV](files/cv.pdf)` in a news item.

Lists appear in file order (newest first), so add new entries **first in the list**. YAML tips: match the indentation of the
neighbouring entries (spaces, never tabs) and keep text in double quotes (write `\"` for a quote inside).
Dates are `"YYYY-MM"`, for example `"2026-10"` (a full date such as `"2026-10-15"` also works; only the month is shown).

Sidebar links appear as written, in the order listed in `data/profile.yaml`. Keep the labels short (`Scholar`,
not `Google Scholar`) so that all of them fit on one line.

The light/dark toggle (top right of the sidebar) follows the visitor's system setting until they click it;
their choice is remembered in their browser.

## Copy-paste snippets

**News item:** goes first in the list in `data/news.yaml`. `text` is inline Markdown (`[links](https://…)`, `**bold**`, emoji).
The newest 8 items are shown (`newsVisible` in `hugo.toml`); older ones move into the "Older news" toggle by themselves.

```yaml
- date: "2026-10"
  text: "[**Paper Name**](https://arxiv.org/abs/0000.00000) has been accepted to **NeurIPS 2026**! 🎉"
```

**Paper:** goes first in the list in `data/publications.yaml`.

```yaml
- id: "C7"
  title: "Paper Title"
  authors: "Woosung Koh*, Jane Doe*, John Smith"
  venue: "NeurIPS 2026 (Oral)"
  tags: ["Efficiency", "Reasoning"]
  pdf: "https://arxiv.org/pdf/0000.00000"
  code: "https://github.com/reiss-koh/repo"
```

- `id`: C = conference paper, J = journal article, W = workshop paper, P = preprint, plus the next free
  number. It is shown in the margin beside the title; hovering over it shows what the letter means.
  C and P papers are listed under **Selected Publications** on the homepage; J and W papers on the
  **More Publications** page (`/publications/`, grouped into journal articles and workshop papers), which the
  homepage links to. To move one paper, add `selected: true` (homepage) or `selected: false` (other page) to it.
- `authors`: one comma-separated string. Put `*` right after a name to mark equal contribution.
  Your name (`paper_name` in `data/profile.yaml`) is bolded automatically.
- `venue`: honours in brackets at the end are highlighted automatically: `"NeurIPS 2026 (Oral)"` shows as
  "NeurIPS 2026 · **Oral**". This works for brackets that contain a word such as Oral, Spotlight, Award, Best,
  Outstanding, Honorable Mention, Highlight, Distinguished, Notable, Talk or Prize, and for several in a row:
  `"X (Oral) (Best Paper Award)"` shows as "X · **Oral** · **Best Paper Award**". Other brackets, such as
  `(SCIE, Q1)`, show as written.
- Links are optional, so keep only the ones you have: `pdf`, `code`, `project`, `dataset`, `video`,
  `slides`, `poster`, `blog`. They always show in that order. The title links to the `pdf` (or else the `project`, else the `code`).

**Award:** awards are shown at the very end of the page, inside the collapsed **See More** toggle.
Paste the snippet right under the existing `awards:` line in `data/cv.yaml`, so that it comes first,
lined up with the existing entries (two spaces before the `-`). `note` is an optional extra line; leave it `""` for none.

```yaml
  - title: "Award Name"
    by: "Organization or Venue"
    date: "2026-10"
    note: ""
```

## Publishing

- Every commit to `main` rebuilds and redeploys the site in about a minute (**Actions** tab → "Deploy site").
- A failed run (red ✗) is almost always a YAML typo, such as a missing quote or wrong indentation, or a date that
  isn't `"YYYY-MM"`. Open the run, then the **Build** step: the message names the file and the line, or the entry to
  fix. The mistake is on the reported line or a few lines above it; a missing closing quote, for example, is
  reported at the start of the next entry. Until a run succeeds, the previous version stays live.
- Dependabot may open a pull request about once a month to update the GitHub Actions in the workflow.
  Merging it is all that's needed. Hugo is pinned by `HUGO_VERSION` in `.github/workflows/deploy.yml`.

## Local preview (optional)

```sh
brew install hugo
hugo server   # run inside this repository's folder, then open http://localhost:1313
```

## One-time setup

Do these in order, before the new site is merged or pushed to `main`:

1. **Settings → General**: rename the repository to `reiss-koh.github.io`, so that the site lives at
   https://reiss-koh.github.io/ (see [Site address](#site-address)).
2. **Settings → Pages → Build and deployment → Source: "GitHub Actions".** Ignore the workflow templates GitHub
   suggests, because `.github/workflows/deploy.yml` is already here.
3. Merge or push to `main`, or run **Actions → Deploy site → Run workflow**. The very first deploy can take up
   to 10 minutes to appear; after that, about a minute. Check that both jobs are green in **Actions**, that
   https://reiss-koh.github.io/ shows the photo and styling, and that https://reiss-koh.github.io/nope shows the 404 page.
4. Point your other pages at the new address: the **Website** field of your GitHub profile, the homepage
   links on Google Scholar, OpenReview, LinkedIn and X, and the OSI Lab students page (they still point to
   https://reisskoh.netlify.app/).

On your computer, point the local clone at the renamed repository (GitHub redirects the old URL meanwhile):
`git remote set-url origin https://github.com/reiss-koh/reiss-koh.github.io.git`

If a run failed at "Configure Pages" before step 2 was done, or ran before the rename in step 1, re-run it:
**Actions → Deploy site → Run workflow**.

## Site address

GitHub Pages picks the address automatically, so no code change is needed:

- repository named `reiss-koh.github.io` → https://reiss-koh.github.io/
- any other name (currently `reisskoh`) → `https://reiss-koh.github.io/<repo-name>/`. Rename the repository under **Settings → General**.
- custom domain → **Settings → Pages → Custom domain**, plus DNS records at your domain registrar
  ([GitHub docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site)).
  No `CNAME` file is needed. Tick **Enforce HTTPS** once it becomes available.

The address is baked in when the site is built. After renaming the repository or changing the domain,
run the workflow once (**Actions → Deploy site → Run workflow**).

## Netlify

The old site at https://reisskoh.netlify.app/ keeps serving its last Hugo Blox deploy, because `netlify.toml`
tells Netlify to skip the builds that pushes start, and makes any other build (for example one started by a
build hook) fail before it can publish. If you delete the Netlify site, delete `netlify.toml` too.

## Rollback

The previous Hugo Blox site is preserved on branch `legacy-hugo-blox` and tag `hugo-blox-final`. You can
browse them with GitHub's branch/tag picker, or locally with `git checkout legacy-hugo-blox`. While the
Netlify site exists, the old version is also still live there.

To put the old site back on `main` without rewriting history:

```sh
git checkout main && git pull
git restore --source=hugo-blox-final --staged --worktree .
git commit -m "Restore Hugo Blox site"
git push
```

This restores the old `netlify.toml`, so Netlify builds and serves the old site again. The old code only
builds on Netlify (its own GitHub workflow uses retired actions and will fail), so GitHub Pages keeps
showing the new site until you unpublish it (**Settings → Pages → ⋯ → Unpublish site**).
To undo the rollback later, `git revert` that commit and push.

## License

The site's content (text and photo) is under [CC0](https://creativecommons.org/publicdomain/zero/1.0/):
anyone may reuse it, no credit needed. This is stated in the footer (`layouts/_partials/footer.html`).
The code is under the MIT license in `LICENSE.md`.
