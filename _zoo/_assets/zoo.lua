-- Adds the site-wide navigation bar, a breadcrumb and a back link to every zoo page.
-- All links are computed relative to the page, so they are correct under /zoo/ on
-- the live site at any nesting depth. (Root-relative links such as "/talks.html"
-- would be rewritten by Quarto to point inside the zoo, so they are not used.)

local function nav(home, zoo)
  local items = {
    { "Home", home .. "index.html" },
    { "Research", home .. "index.html#research" },
    { "Zoo", zoo },
    { "Talks", home .. "talks.html" },
    { "Teaching", home .. "teaching.html" },
    { "Africa &amp; outreach", home .. "outreach.html" },
    { "Writing", home .. "writing.html" },
    { "Blog", home .. "blog/" },
  }
  local links = {}
  for _, it in ipairs(items) do
    links[#links + 1] = '<a href="' .. it[2] .. '">' .. it[1] .. '</a>'
  end
  -- Same markup as the nav bar of the hand-written pages (styled in zoo.scss).
  return '<nav class="myDiv column-screen"><div class="nav-inner">\n'
    .. table.concat(links, "\n") .. '\n</div></nav>\n'
end

function Pandoc(doc)
  local zoo = (quarto.project.offset or ".") .. "/"   -- the zoo index
  local home = zoo .. "../"                            -- the main website
  local crumbs
  if doc.meta["zoo-index"] ~= nil then
    crumbs = '<div class="zoo-crumbs"><a href="' .. home .. 'index.html">Dominic Bunnett</a> › The non-reductive zoo</div>'
  else
    crumbs = '<div class="zoo-crumbs"><a href="' .. home .. 'index.html">Dominic Bunnett</a> › <a href="' .. zoo .. '">The non-reductive zoo</a></div>'
    doc.blocks:insert(pandoc.RawBlock("html",
      '<p class="zoo-back"><a href="' .. zoo .. '">← Back to the non-reductive zoo</a></p>'))
    -- "Contributed by ..." under the title, only when `contributor:` is filled in.
    local c = doc.meta["contributor"]
    if c ~= nil and pandoc.utils.stringify(c) ~= "" then
      local line = pandoc.Inlines{pandoc.Str("Contributed"), pandoc.Space(), pandoc.Str("by"), pandoc.Space()}
      if pandoc.utils.type(c) == "Inlines" then
        line:extend(c)
      else
        line:insert(pandoc.Str(pandoc.utils.stringify(c)))
      end
      doc.blocks:insert(1, pandoc.Div(pandoc.Para(line), pandoc.Attr("", {"zoo-contributor"})))
    end
  end
  quarto.doc.include_text("before-body", nav(home, zoo) .. crumbs)
  return doc
end
