require "rails_helper"

RSpec.describe QuestionsController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the questions into @questions" do
      question1, question2, question3 = Question.create({title: "question1", content: "content1", answer: "answer1"}), 
        Question.create({title: "question2", content: "content2", answer: "answer2"}),
        Question.create({title: "question3", content: "content3", answer: "answer3"})
      
      get :index

      expect(assigns(:questions)).to match_array([question1, question2, question3])
    end
  end
end

RSpec.describe QuestionsController, :type => :controller do
  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end

    it "load of the new question into @question" do      
      get :new

      expect(assigns(:question)).to be_a_new(Question)
    end
  end
end

RSpec.describe QuestionsController, :type => :controller do
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new question" do
        expect{
          post :create, question: {title: "question1", content: "content1", answer: "answer1"}
        }.to change(Question,:count).by(1)
      end
    end
  end
end

RSpec.describe QuestionsController, :type => :controller do
  describe "GET #edit" do
    
    it "responds successfully with an HTTP 200 status code" do
      data = Question.create(title: "question1", content: "content1", answer: "answer1")
      get :edit, id: data.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      data = Question.create(title: "question1", content: "content1", answer: "answer1")
      get :edit, id: data.id
      expect(response).to render_template("edit")
    end

    it "load of the question into @question" do
      data = Question.create(title: "question1", content: "content1", answer: "answer1")

      get :edit, id: data

      expect(assigns(:question)).to eq(data)
    end
  end
end

RSpec.describe QuestionsController, :type => :controller do
  describe 'PUT update' do
    before :each do
      @question = Question.create(title: "question1", content: "content1", answer: "answer1")
    end
    
    it "located the requested @question" do
      put :update, id: @question, question: {title: "Title 1", content: "new content", answer: "new answer"}
      assigns(:question).should eq(@question)      
    end
  
    it "changes @question's attributes" do
      put :update, id: @question, question: {title: "Title 1", content: "new content", answer: "new answer"}

      @question.reload
      @question.title.should eq("Title 1")
      @question.content.should eq("new content")
      @question.answer.should eq("new answer")
    end
  end
end

RSpec.describe QuestionsController, :type => :controller do
  describe 'DELETE destroy' do
    before :each do
      @question = Question.create(title: "question1", content: "content1", answer: "answer1")
    end
    
    it "deletes the question" do
      expect{
        delete :destroy, id: @question
      }.to change(Question,:count).by(-1)
    end
      
    it "redirect to questions#index" do
      delete :destroy, id: @question
      response.should redirect_to questions_path
    end
  end
end
