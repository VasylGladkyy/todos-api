FactoryBot.create_list(:todo, 10)

Todo.all.each do |todo|
  FactoryBot.create_list(:item, 5, todo: todo)
end
