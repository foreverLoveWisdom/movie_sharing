# frozen_string_literal: true

youtube_info = [
  {
    youtube_id: 'SSo_EIwHSd4',
    title: 'What is blockchain?',
    description: "Join us for a crash course on blockchain - the technology that's taking the world by storm - whether you understand it or not. We promise, it's not as confusing as it sounds... well, maybe a little bit. But don't worry, we'll have some fun along the way!"
  },
  {
    youtube_id: '0tZFQs7qBfQ',
    title: 'What is Web 3.0?',
    description: "Step aside, Web 2.0 - it's time for the next evolution of the internet, and it's got its own name: Web 3.0. Join us as we explore the future of the web, where AI, blockchain, and open-source collaboration combine to bring you the ultimate online experience... or at least that's what we're hoping for!"
  },
  {
    youtube_id: 'Dd6pI0RFiYk',
    title: 'What are web 3 cryptocurrencies?',
    description: "Get ready to jump into the world of Web 3 cryptocurrencies - where the money is decentralized, the transactions are on the blockchain, and the memes just keep getting weirder. It's like the Wild West of finance, but with NFT cowboys and automated unicorn wranglers. Yeehaw!"
  }
]

puts 'Seeding movies...'
youtube_info.each do |yt_info|
  user = User.create!(email: Faker::Internet.email, username: Faker::Internet.username, password: 'password')
  Movie.create!(user:, title: yt_info[:title], youtube_id: yt_info[:youtube_id], description: yt_info[:description])
end
puts 'Finished seeding movies!'
