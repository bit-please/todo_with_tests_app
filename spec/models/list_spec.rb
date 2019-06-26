require 'rails_helper'

RSpec.describe List, type: :model do

  describe '#complete_all_tasks!' do
  	it 'should mark all tasks from the list as complete' do
  		list = List.create(name: "Chores")
  		Task.create(list_id: list.id, complete: false)
  		Task.create(list_id: list.id, complete: false)
  		list.complete_all_tasks!

  		list.tasks.each do |task|
  			expect(task.complete).to eq(true)
  		end
  	end
  end

  describe '#snooze_all_tasks!' do
  	it 'should snooze each task (push deadline by 1 hour)' do
  		deadline = Time.now + 1.day
  		list = List.create(name: "Chores")
  		Task.create(list_id: list.id, deadline: deadline)
  		Task.create(list_id: list.id, deadline: deadline)
  		list.snooze_all_tasks!
  		list.tasks.each do |task|
  			expect(task.deadline).to eq(deadline + 1.hour)
  		end
  	end
  end

  describe '#total_duration' do
  	it 'should return the sum of the duration of all the tasks' do
  		list = List.create(name: "Chores")
  		Task.create(list_id: list.id, duration: 50)
  		Task.create(list_id: list.id, duration: 100)
  		Task.create(list_id: list.id, duration: 30)
  		expect(list.total_duration).to eq(180)
  	end
  end

  describe '#incomplete_tasks' do
  	it 'should return an array of all incomplete tasks' do
  		list = List.create(name: "Chores")
  		Task.create(list_id: list.id, complete: true)
  		Task.create(list_id: list.id, complete: false)
  		Task.create(list_id: list.id, complete: false)
  		list.incomplete_tasks.each do |task|
  			expect(task.complete).to eq(false)
  		end 
  	end
  end

  describe '#favorite_tasks' do
  	it 'should return an array of all favorite tasks' do
  		list = List.create(name: "Chores")
  		Task.create(list_id: list.id, favorite: true)
  		Task.create(list_id: list.id, favorite: false)
  		Task.create(list_id: list.id, favorite: false)
  		list.favorite_tasks.each do |task|
  			expect(task.favorite).to eq(true)
  		end 
  	end
  end

end
