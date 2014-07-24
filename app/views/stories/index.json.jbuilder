json.array!(@stories) do |story|
  json.extract! story, :id, :name, :description, :state, :project_id
  json.url story_url(story, format: :json)
end
