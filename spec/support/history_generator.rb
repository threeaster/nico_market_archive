module HistoryGenerator
  def generate_histories(movie)
    History.create! movie: movie, date: Time.new(2014, 1, 1, 1, 1, 1)
    History.create! movie: movie, date: Time.new(2015, 2, 1, 1, 1, 1)
    History.create! movie: movie, date: Time.new(2015, 12, 3, 1, 1, 1)
    History.create! movie: movie, date: Time.new(2015, 12, 31, 4, 1, 1)
    @before_history = History.create! movie: movie, date: Time.new(2015, 12, 31, 23, 5, 1)
    dummy_movie = create :movie, movie_id: 'sm12'
    History.create! movie: dummy_movie, date: Time.new(2013, 1, 1, 1, 1, 1)
    History.create! movie: dummy_movie, date: Time.new(2015, 3, 1, 1, 1, 1)
    History.create! movie: dummy_movie, date: Time.new(2015, 12, 4, 1, 1, 1)
    History.create! movie: dummy_movie, date: Time.new(2015, 12, 31, 5, 1, 1)
    History.create! movie: dummy_movie, date: Time.new(2015, 12, 31, 23, 6, 1)
  end
end