require 'commander/import'
require_relative 'topic'

# :name is optional, otherwise uses the basename of this executable

appname = "vespa"
program :name, 'JBoss HornetQ RESTful command line'
program :version, '0.0.1'
program :description, 'Interact with the JBoss HornetQ RESTful API from the command line'

command :topic do |c|
  c.syntax = "#{appname} topic <name>"
  c.description = 'Enqueue a message on a topic'
  c.option '--server <servername>', String, 'The name of the server (default:localhost)'
  c.option '--port <port>', String, 'The HTTP port (default:8080)'
  c.option '--context <prefix>', String, 'The context path (default:messaging)'
  c.option '--payload <message>', String, 'Enqueue the message'
  c.option '--pull', 'Pull the next message'
  c.option '--durable', 'Set durable on pull'
  c.option '--subscriber <name>', String, 'Set the name of the subscriber (default:bob)'
  c.action do |args, options|
  	options.default :server => 'localhost', :port => '8180', :context => 'messaging', :subscriber => 'bob', :durable => true
  	raise "You must provide the topic name" if args[0].nil?
    topic = Topic.new(options.server,options.port,options.context,args[0],options.subscriber)
    if !(options.payload.nil?)
    	topic.enqueue(options.payload,options.durable)
    end
    if !(options.pull.nil?)
    	topic.dequeue(options.durable)
    end
  end
end