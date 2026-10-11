// Run after `quarto render _zoo`:  quarto run _zoo/_assets/remove-drafts.ts _zoo/_site
// Quarto (draft-mode: gone) leaves an empty placeholder page
// for every entry marked `draft: true`. Delete those placeholders (and their
// now-empty folders) so unfinished entries are not deployed at all.
const outDir = Deno.args[0] ?? "_site";
const placeholder = /^\s*<!DOCTYPE html>\s*<html[^>]*>\s*<\/html>\s*$/i;

function walk(dir: string) {
  for (const entry of Deno.readDirSync(dir)) {
    const path = `${dir}/${entry.name}`;
    if (entry.isDirectory) {
      walk(path);
      if ([...Deno.readDirSync(path)].length === 0) Deno.removeSync(path);
    } else if (entry.name.endsWith(".html")) {
      if (placeholder.test(Deno.readTextFileSync(path))) {
        Deno.removeSync(path);
        console.log(`Draft left out of the build: ${path}`);
      }
    }
  }
}
walk(outDir);
