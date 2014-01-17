class Spinach::Features::IdentifyPlayer < Spinach::FeatureSteps
  step 'a first time user' do
  end

  step 'they identify themselves by name' do
    visit '/login'
    within("#ask") do
      fill_in 'name', :with => 'Frankenstein'
      click_on 'submit'
    end
  end

  step 'they\'re successfully associated with a new game and redirected to the game page' do
    user_name = current_scope.session.driver.request.session['user_name']
    expect(page).to have_content(user_name)
    
    expect(page).to have_content("Cards")

    game_id = current_scope.session.driver.request.session['game_id']
    game = GoFishApp.games[game_id]
    cards = game.hand(1).cards
    #binding.pry
    displayed_cards = page.all('#player_hand li').map {|node| PlayingCard.new(node['data-rank'],node['data-suit'])}
    expect(displayed_cards).to eq cards
    #page.within('#player_hand') do 
      #cards.each do |card|
        #page.should have_css("img[src='images/cards/#{card.suit.downcase}#{card.rank.downcase}.png']")
      #end
    #end
  end
end
