class GoogleSearchFacade
  def initialize(starting_point)
    @starting_point = starting_point
  end

  def coordinates
    response = GoogleService.new.coordinates(@starting_point)
    unless response[:status] == "ZERO_RESULTS"
      response[:candidates][0][:geometry][:location]
    end
  end
end
