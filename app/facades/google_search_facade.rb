class GoogleSearchFacade
  def initialize(starting_point)
    @starting_point = starting_point
  end

  def coordinates
    response = GoogleService.new.coordinates(@starting_point)
    response[:candidates][0][:geometry][:location]
  end
end
