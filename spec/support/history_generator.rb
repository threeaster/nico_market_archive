module HistoryGenerator
  def generate_histories
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

  def movie
    Movie.find_or_create_by movie_id: 'sm9'
  end

  def now_history
    History.find_or_create_by movie: movie, date: Time.new(2015, 12, 31, 23, 30, 0)
  end

  def collect_years
    %w[2014 2015]
  end

  def collect_months
    %w[2 12]
  end

  def collect_days
    %w[3 31]
  end

  def collect_hours
    %w[4 23]
  end

  def collect_minutes
    %w[5 30]
  end
end