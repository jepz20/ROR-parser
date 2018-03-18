json.(content, :tag, :text)
if content.tag === 'a'
  json.href content.href
end
