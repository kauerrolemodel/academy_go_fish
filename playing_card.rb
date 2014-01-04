class PlayingCard
  attr_reader :rank

  def self.json_create(hash)
    self.new(hash["rank"],hash["suit"])
  end

  def initialize(rank, suit='C')
    @rank, @suit = rank, suit
  end

  def as_json
    { 
      JSON.create_id => self.class.name,
      :rank => @rank,
      :suit => @suit
    }
  end

  def to_json(options={})
    as_json.to_json
  end

#  def to_s
    #"#{@rank}-#{@suit}"
  #end
end
