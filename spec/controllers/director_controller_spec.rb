require 'spec_helper'

describe DirectorController do

  describe "GET 'show'" do
    let(:movie) { mock_model(Movie, :director => director, :title => "Ion") }

    before :each do
      Movie.stub(:find).and_return(movie)
    end

    context "when the movie has a director" do
      let(:director) { "test" }

      it "should call Movie find" do
        Movie.should_receive(:find).with("42")
        get :show, :movie_id => "42"
      end

      it "should call find_by_director" do
        Movie.should_receive(:find_all_by_director).with("test")
        get :show, :movie_id => "42"
      end

      it "should assign movies" do
        movies = [mock_model(Movie), mock_model(Movie)]
        Movie.stub(:find_all_by_director).and_return(movies)
        get :show, :movie_id => "42"
        assigns(:movies).should == movies
      end

      it "should respond with success" do
        get :show, :movie_id => "42"
        response.should be_success
      end

      it "should render template show" do
        get :show, :movie_id =>  "42"
        response.should render_template("director/show")
      end
    end

    context "when movie has no director" do
      let(:director) { "" }

      it "should not call find_all_by_director" do
        Movie.should_not_receive(:find_all_by_director)
        get :show, :movie_id => "42"
      end

      it "should set :notice" do
        get :show, :movie_id => "42"
        flash[:notice].should == "'Ion' has no director info"
      end
    end
  end
end
