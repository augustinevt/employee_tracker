require('sinatra/activerecord')
require('sinatra')
require('sinatra/reloader')
require('./lib/division.rb')
require('./lib/employee.rb')

get('/') do
  erb(:index)
end

get('/divisions') do
  @divisions = Division.all()
  erb(:divisions)
end

get('/divisions/new') do
  erb(:division_form)
end

post('/divisions') do
  title = params["title"]
  @division = Division.create({title: title})
  @divisions = Division.all()
  erb(:divisions)
end

get('/division/:id') do
  @division = Division.find(params['id'])
  erb(:division)
end

get('/employees') do
  @employees = Employee.all()
  erb(:employees)
end

get('/employees/new') do
  @divisions = Division.all()
  erb(:employee_form)
end

post('/employees') do
  name = params["name"]
  division_id = params["division_id"].to_i()
  @employee = Employee.create({name: name, division_id: division_id})
  @employees = Employee.all()
  erb(:employees)
end

get('/division/:id/edit') do
  @division = Division.find(params["id"])
  erb(:division_edit)
end

patch('/division/:id') do
  @division = Division.find(params["id"])
  title = params["title"]
  @division.update({title: title})
  erb(:division)
end

delete('/division/:id') do
  @division = Division.find(params["id"]).destroy()
  redirect '/divisions'
end
