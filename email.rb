#!/usr/bin/env ruby

require "rubygems"
require "pony"
require "trollop"

CONFIG_FILE = File.expand_path("~/.emailconfig")

opts = Trollop::options do
  opt :from, "Sender's email address", :type => :string
  opt :to, "Receiver's email address", :type => :string
  opt :subject, "Subject", :type => :string
  opt :body, "Body", :default => "(no body)", :type => :string
  opt :attachment, "Attachment file (multiple allowed)", :type => :string, :multi => true
  opt :username, "Username", :type => :string
  opt :password, "Password", :type => :string
  opt :host, "Host", :short => "H", :type => :string
  opt :port, "Port", :short => "P", :type => :string
  opt :auth, "Authentication type", :short => "A", :default => "plain", :type => :string
  opt :via, "Connection method", :default => "smtp", :type => :string
end

# Read from config file
options = {}
if File.exist?(CONFIG_FILE)
  options = Hash[IO.readlines(CONFIG_FILE).
    map { |line| line.split("=", 2).
    map(&:strip) }.
    select { |pair| pair.size == 2 }.
    map { |k, v| [k.to_sym, v] }
  ]
end

# Override config with command line parameters
options[:from] = opts[:from] if opts[:from]
options[:to] = opts[:to] if opts[:to]
options[:via] = opts[:via] if opts[:via]
options[:username] = opts[:username] if opts[:username]
options[:password] = opts[:password] if opts[:password]
options[:host] = opts[:host] if opts[:host]
options[:port] = opts[:port] if opts[:port]
options[:auth] = opts[:auth] if opts[:auth]
options[:subject] = opts[:subject] if opts[:subject]
options[:body] = opts[:body] if opts[:body]
options[:attachment] = opts[:attachment] if opts[:attachment]

if ARGV[0] == "-"
  options[:body] = ARGF.read
end

attachments = Hash[options[:attachment].
    map { |filename| [File.basename(filename), File.read(filename)] }]

Pony.mail(:to => options[:to], :from => options[:from], :via => options[:via].to_sym,
  :via_options => {
    :address => options[:host],
    :port => options[:port],
    :enable_starttls_auto => true,
    :user_name => options[:username],
    :password => options[:password],
    :authentication => options[:auth].to_sym
  },
  :subject => options[:subject], :body => options[:body], :attachments => attachments
)
