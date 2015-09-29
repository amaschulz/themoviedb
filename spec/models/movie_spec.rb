require 'spec_helper'

describe Tmdb::Movie do
  subject { described_class }

  describe "public class methods" do

    context "responds to its methods" do
      it { expect(subject).to respond_to(:find) }
      it { expect(subject).to respond_to(:latest) }
      it { expect(subject).to respond_to(:now_playing) }
      it { expect(subject).to respond_to(:popular) }
      it { expect(subject).to respond_to(:top_rated) }
      it { expect(subject).to respond_to(:upcoming) }
    end

    context "self.latest" do
      it "should return the latest movie" do
        VCR.use_cassette 'movie/latest' do
          expect(subject.latest.class).to eq(Tmdb::Movie)
        end
      end
    end

    context "self.upcoming" do
      it "should return the upcoming movies" do
        VCR.use_cassette 'movie/upcoming' do
          expect(subject.upcoming).to include(Tmdb::Movie)
        end
      end
    end

    context "self.now_playing" do
      it "should return movies that are now playing in cinemas" do
        VCR.use_cassette 'movie/now_playing' do
          expect(subject.now_playing).to include(Tmdb::Movie)
        end
      end
    end

    context "self.popular" do
      it "should return popular movies" do
        VCR.use_cassette 'movie/popular' do
          expect(subject.popular).to include(Tmdb::Movie)
        end
      end
    end

    context "self.top_rated" do
      it "should return top rated movies" do
        VCR.use_cassette 'movie/top_rated' do
          expect(subject.top_rated).to include(Tmdb::Movie)
        end
      end
    end

  end

  describe ".find" do
    let(:movie) { VCR.use_cassette("movie/find") { Tmdb::Movie.find(22855) } }

    context "responds to its methods" do
      [:adult,
       :backdrop_path,
       :genres,
       :id,
       :original_language,
       :original_title,
       :overview,
       :release_date,
       :poster_path,
       :popularity,
       :title,
       :video,
       :vote_average,
       :vote_count,
       :belongs_to_collection,
       :budget,
       :genres,
       :homepage,
       :imdb_id,
       :production_companies,
       :production_countries,
       :revenue,
       :runtime,
       :spoken_languages,
       :status,
       :tagline].each do |field|
        it { expect(movie).to respond_to(field) }
      end
    end
  end

end