json.array!(@tasks) do |task|
  json.extract! task, :id, :state, :description, :story_id
  json.url task_url(task, format: :json)
end
