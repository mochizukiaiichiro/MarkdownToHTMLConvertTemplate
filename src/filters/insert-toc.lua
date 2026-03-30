-- Pandoc 3.x 用：2パス方式で TOC を生成して挿入する

local headings = {}

-- 1パス目：見出しを収集
function Header(el)
  table.insert(headings, {
    level = el.level,
    content = pandoc.utils.stringify(el.content),
    id = el.identifier
  })
  return el
end

-- 2パス目：ドキュメント全体を処理
function Pandoc(doc)
  local blocks = {}

  for _, block in ipairs(doc.blocks) do
    if block.t == "Para"
       and #block.content == 1
       and block.content[1].t == "Str"
       and block.content[1].text == "[TOC]" then

      -- [TOC] を TOC HTML に置き換える
      table.insert(blocks, pandoc.RawBlock("html", build_toc()))

    else
      table.insert(blocks, block)
    end
  end

  return pandoc.Pandoc(blocks, doc.meta)
end

-- TOC HTML を生成
function build_toc()
  local html = {}
  local prev = 0

  table.insert(html, '<nav id="TOC">')

  for i, h in ipairs(headings) do
    local level = h.level

    -- 深くなる
    if level > prev then
      for j = prev + 1, level do
        table.insert(html, "<ul>")
      end

    -- 浅くなる
    elseif level < prev then
      for j = level + 1, prev do
        table.insert(html, "</li>")
        table.insert(html, "</ul>")
      end
    else
      -- 同じ階層なら前のliを閉じる
      if i > 1 then
        table.insert(html, "</li>")
      end
    end

    -- li開始（まだ閉じない！）
    table.insert(html, string.format(
      '<li><a href="#%s">%s</a>',
      h.id, h.content
    ))

    prev = level
  end

  -- 最後のliを閉じる
  table.insert(html, "</li>")

  -- ulを全部閉じる
  for i = 1, prev do
    table.insert(html, "</ul>")
  end

  table.insert(html, "</nav>")

  return table.concat(html, "\n")
end