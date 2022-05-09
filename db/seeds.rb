# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# 👋 Also, seeds in Bullet Train are slightly different than vanilla Rails.
# See `docs/seeds.md` for details.

puts "🌱 Generating global seeds."

load "#{Rails.root}/db/seeds/development.rb" if Rails.env.development?

# find or create team
@team = Team.first
# get first site from
@site = @team.sites.create_or_find_by!(name: "rainbow")
# initialize PublisherAccount w/o possible duplication
  publisher_accts = @site.publisher_accounts.create_or_find_by([{ name: 'instagram', url: "http://instagram.com", 
      font_awesome_class: "fab fa-instagram", network_kind: "social", 
      blurb: "Get a glimpse of some of my funnier moments on TikTok" },

    { name: 'youtube', url: "http://youtube.com", 
      font_awesome_class: "fab fa-youtube", network_kind: "social", 
      blurb: "Get a glimpse of some of my funnier moments on TikTok" },

    { name: 'facebook', url: "http://facebook.com", 
      font_awesome_class: "fab fa-facebook-f", network_kind: "social", 
      blurb: "Get a glimpse of some of my funnier moments on facebook" },

    { name: 'twitter', url: "http://twitter.com", 
      font_awesome_class: "fab fa-twitter", network_kind: "social", 
      blurb: "Get a glimpse of some of my funnier moments on TikTok" },

    { name: 'snapchat', url: "http://snapchat.com", 
      font_awesome_class: "fab fa-snapchat-ghost", network_kind: "social", 
      blurb: "An inside look at my life through stories." },

    { name: 'linkedin', url: "http://linkedin.com", 
      font_awesome_class: "fab fa-linkedin", network_kind: "social", 
      blurb: "Get a glimpse of some of my funnier moments on TikTok" },

    {name: "tiktok", url: "http://tiktok.com", 
      font_awesome_class: "fas fa-music", network_kind: "social", 
      blurb: "Get a glimpse of some of my funnier moments on TikTok"},

    {name: "podcast", url: "/podcast", 
      font_awesome_class: "fas fa-podcast", network_kind: "social", 
      blurb: "Perfect for your commute. Listen daily to keynotes, interviews, rants, business meetings, and more."},

    { name: 'stitcher', url: "https://www.stitcher.com/", 
      font_awesome_class: "fas fa-music", network_kind: "podcast", 
      blurb: "https://www.stitcher.com/" },

    { name: 'soundcloud', url: "https://soundcloud.com/", 
      font_awesome_class: "fas fa-music", network_kind: "podcast", 
      blurb: "https://soundcloud.com/" },

    { name: 'spotify', url: "https://open.spotify.com/genre/podcasts-page", 
      font_awesome_class: "fas fa-music", network_kind: "podcast", 
      blurb: "https://open.spotify.com/genre/podcasts-page" },

    { name: 'castbox', url: "https://castbox.fm/", 
      font_awesome_class: "fas fa-music", network_kind: "podcast", 
      blurb: "https://castbox.fm/" },

    { name: 'apple-podcasts', url: "https://podcasts.apple.com/us/genre/podcasts/id26", 
      font_awesome_class: "fas fa-music", network_kind: "podcast", 
      blurb: "https://podcasts.apple.com/us/genre/podcasts/id26" },

    { name: 'overcast', url: "https://overcast.fm/", 
      font_awesome_class: "fas fa-music", network_kind: "podcast", 
      blurb: "https://overcast.fm/" },

    { name: 'iheart', url: "https://www.iheart.com/", 
      font_awesome_class: "fas fa-music", network_kind: "podcast", 
      blurb: "https://www.iheart.com/" },

    { name: 'tunein', url: "https://tunein.com/podcasts/", 
      font_awesome_class: "fas fa-music", network_kind: "podcast", 
      blurb: "https://tunein.com/podcasts/" },

    { name: 'acast', url: "https://www.acast.com/en", 
      font_awesome_class: "fas fa-music", network_kind: "podcast", 
      blurb: "https://www.acast.com/en" },
      
    { name: 'google-podcasts', url: "https://podcasts.google.com/", 
      font_awesome_class: "fas fa-music", network_kind: "podcast", 
      blurb: "https://podcasts.google.com/" }
    
    ])
