json.pages do |json|
  json.array! @pages, partial: 'pages/page', as: :page
end

json.pages_count @pages_count