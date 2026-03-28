-- minus_html.lua
-- Replace hyphen-minus used as unary numeric minus with Unicode minus (U+2212).
-- Works for normal text (Str) AND raw HTML blocks (RawInline/RawBlock), which is common for tables.

local MINUS = "\u{2212}"

local function fix_numeric_minus(s)
  -- unary '-' before digit or before '.digit'
  s = s:gsub("(^)%-(%d)", "%1" .. MINUS .. "%2")
  s = s:gsub("(^)%-(%.%d)", "%1" .. MINUS .. "%2")
  s = s:gsub("([^%w])%-(%d)", "%1" .. MINUS .. "%2")
  s = s:gsub("([^%w])%-(%.%d)", "%1" .. MINUS .. "%2")
  return s
end

function Str(el)
  el.text = fix_numeric_minus(el.text)
  return el
end

-- Many table tools emit raw HTML; handle it too (HTML only)
function RawInline(el)
  if el.format == "html" then
    el.text = fix_numeric_minus(el.text)
  end
  return el
end

function RawBlock(el)
  if el.format == "html" then
    el.text = fix_numeric_minus(el.text)
  end
  return el
end

-- Don't touch code
function Code(el) return el end
function CodeBlock(el) return el end