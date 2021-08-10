require "rails_helper"

RSpec.describe Todolist, type: :model do


    context 'create new todo item' do
      subject do
        Todolist.create(
          user_id: 1,
          title: 'first title',
          complete: false)
      end
      it 'title should be a string' do
        expect(subject.title).to be_a(String)
      end
        it 'complete value should be is false' do
        expect(subject.complete).to equal(false)
      end
      it 'timestamps should be DateTime' do
        expect(subject.created_at).to be_falsey
      end
      it 'user_id should be 2' do
        expect(subject.user_id).to eq(1)
      end
      it 'id should be 1' do
        expect(subject.id).to be(nil)
      end
    end

    context 'change todo item' do
      subject do
        Todolist.create(
          user_id: 1,
          title: 'first title',
          complete: false)
      end
      it 'todo item should be update title and complete' do
        subject.update(title: 'new title', complete: true)
        expect(subject.title).to eq('new title')
        expect(subject.complete).to eq(true)
      end
    end

end

