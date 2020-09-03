user = FactoryBot.create(:user, email: 'todo.admin@gmail.com', password: '123456')

FactoryBot.create_list(:todo, 10, created_by: user.id)

Todo.all.each do |todo|
  FactoryBot.create_list(:item, 5, todo: todo)
end
