# The non-reductive zoo — authoring guide

The zoo is a small Quarto website living in this folder (`_zoo/`). It is published at
<https://dombunnett.github.io/zoo/>; each entry has its own address, e.g. `/zoo/nagata/`.
The rest of dombunnett.github.io is hand-written HTML and is not touched by Quarto.

This guide, the template and everything starting with `_` are never published.

```
_zoo/
  _quarto.yml            configuration (site settings, bibliography, styling)
  index.qmd              the zoo index: title and introduction
  references.bib         shared BibTeX bibliography
  nagata/index.qmd       one folder per entry  →  /zoo/nagata/
  _template/index.qmd    template for new entries (not published)
  _assets/               styling, nav bar, index-list layout, draft clean-up (not published)
  preview-full-site.sh   build + serve the whole website locally
  _site/                 rendered output (generated, not committed)
```

## Edit the introduction

Open `_zoo/index.qmd` and edit the paragraph below the metadata block. The list of
examples underneath is generated automatically from the published entries — do not edit
it by hand.

## Create an example from the template

1. Copy `_zoo/_template/` to a new folder with a short, permanent name, e.g.
   `_zoo/nagata/`. The folder name is the address: `/zoo/nagata/`. Use lower-case letters,
   digits and hyphens, and don't rename it after publishing (links would break).
2. In `index.qmd`, fill in the metadata at the top:
   - `title` — shown on the page and in the index;
   - `description` — one sentence, shown under the title and in the index;
   - `order` — position in the index, smaller first (use gaps: 10, 20, 30 …);
   - `date` — publication date, `YYYY-MM-DD`, shown on the cage (set it when you publish;
     the build refuses to publish a cage without one);
   - `categories` — optional tags, e.g. `[finite generation, positive characteristic]`;
   - `contributor` — who contributed the example. Leave it as `""` for your own;
     otherwise "Contributed by …" appears on the cage and in the index;
   - `draft: true` — keep this until the entry is ready.
3. Write the sections: Phenomenon, Setup, Construction, Proof, Outro,
   References and related examples. Name the proof section after what it proves,
   e.g. "Proof of non-finite generation".

Writing mathematics:

- LaTeX maths: `$...$` inline and `$$...$$` displayed (rendered with MathJax).
- Numbered equation: `$$ ... $$ {#eq-weights}`, referred to as `@eq-weights`.
- Theorem-like blocks, numbered automatically:

  ```
  ::: {#thm-nagata}
  ## Optional name
  Statement.
  :::

  ::: {.proof}
  Proof.
  :::
  ```

  Prefixes: `thm-`, `lem-`, `prp-`, `cor-`, `def-`, `exm-`, `rem-`, `cnj-`.
  Refer to them with `@thm-nagata`.
- Citations: add the BibTeX entry to `_zoo/references.bib`, cite with `[@key]` or
  `[@key, Thm. 2]`. The bibliography appears where `::: {#refs}` is (under
  "References and related examples").
- Link to another entry: `[Nagata's example](../nagata/index.qmd)`. Links to entries that
  are still drafts are shown as plain text on the public site.
- Images or a PDF supplement: put the file in the entry's folder and link it,
  e.g. `[PDF version](nagata.pdf)` or `![](picture.png)`.

## Preview locally

From the repository folder:

```
quarto preview _zoo
```

This opens the zoo in a browser and reloads as you save. Drafts are shown in preview so
you can work on them. The nav bar links (Home, Talks, …) point outside the zoo, so
they only work in the full-site preview:

```
sh _zoo/preview-full-site.sh
```

which builds the whole website as it will be published (drafts left out) and serves it at
<http://localhost:8000/> (zoo at <http://localhost:8000/zoo/>). Stop it with Ctrl-C.

## Publish an entry (draft → published)

1. Delete the line `draft: true` from the entry's metadata (or set `draft: false`) and
   remove the yellow "Draft — for completion" box.
2. Optionally check with `sh _zoo/preview-full-site.sh` that it appears in the index.
3. Commit and push (below). The entry appears in the index automatically, sorted by `order`.

While an entry has `draft: true` it is not rendered at all: no page, no index line,
no sitemap entry. If no entry is published, the index says "Examples are being prepared."

## How the website is rebuilt and deployed

Pushing to `master` on GitHub runs the workflow `.github/workflows/pages.yml`, which:

1. builds the hand-written pages with Jekyll, exactly as GitHub Pages did before;
2. renders `_zoo/` with Quarto and copies the result to `/zoo/`;
3. checks that the main site and zoo index exist and that no draft leaked into the output;
4. deploys the combined site.

Progress and any errors are under the repository's **Actions** tab; the site updates a
minute or two after the run finishes. Nothing generated is committed — `_zoo/_site/` and
`_zoo/_fullsite/` are ignored by git.

The main website's nav bar is still duplicated in each hand-written page; the zoo builds
its copy of the nav bar in `_assets/zoo.lua`. If you add or rename a main page, update
both.
