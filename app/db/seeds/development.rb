MAIL_DOMAINS = %w[
  live.com
  mail.ru
  web.de
  list-manage.com
  gmx.net
  outlook.com
  gmail.com
  hotmail.com
  sendgrid.net
  evite.com
  live.net
  linkedinmobileapp.com
  szn.cz
  mailchimp.com
  1drv.ms
  mailchi.mp
  mail.com
  freemail.hu
  temp-mail.org
  mimecast.com
  liveinternet.ru
  126.com
  mlsend.com
  families.google
  campaign-archive.com
  gmx.ch
  cmail20.com
  gmx.de
  cmail19.com
  webmail.free.fr
  posteo.de
  sendinblue.com
  yahoomail.com
  kpnmail.nl
  gmx.com
  fastmail.com
  hdmoli.com
  hushmail.com
  greetingsisland.com
  yopmail.com
  citromail.hu
  gmx.fr
  convertkit-mail2.com
  deref-mail.com
  ymail.com
  hao6v.tv
  mail.ee
  mail.bg
  networksolutionsemail.com
  dripemail2.co
]

puts 'Creating Users'

1_000_000.times do |index|
  name    = Faker::Name.name
  login   = Faker::Internet.username(specifier: name, separators: %w(. _ -))
  email   = Faker::Internet.email(name: name, domain: MAIL_DOMAINS.sample)
  country = Faker::Address.country

  user = User.create(name:, login:, email:, country:)

  if user.id
    puts "+: User #{index + 1} was created"
  else
    puts "-: User #{index + 1} was NOT created"
    puts user.errors.inspect
  end
end
