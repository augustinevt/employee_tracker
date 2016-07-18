require('spec_helper')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the division path', {:type => :feature}) do
  it('creates a new division') do
    visit('/')
    click_on('View All Divisions')
    click_on('Add a Division')
    fill_in('title', :with => 'Human Resources')
    click_on('Create')
    expect(page).to have_content('Human Resources')
  end

  it('edits the created division') do
    test_division = Division.create({title: "division1"})
    visit('/divisions')
    click_on("division1")
    click_on("Edit")
    fill_in("title", :with => "Research and Development")
    click_on("Update")
    expect(page).to have_content("Research and Development")
  end

  it('deletes the created division') do
    test_division = Division.create({title: "division1"})
    visit('/divisions')
    click_on("division1")
    click_on("Delete")
    expect(Division.all()).to eq([])
  end
end

describe('the employee path', {:type => :feature}) do
  it('creates an employee and assigns it a division') do
    test_division = Division.create({title: "Human Resources"})
    visit('/')
    click_on('View All Employees')
    click_on('Add an Employee')
    fill_in('name', :with => "August")
    check("#{test_division.id()}")
    click_on("Create")
    expect(Employee.all().length()).to eq(1)
    expect(test_division.employees().first().name()).to eq("August")
  end
end
