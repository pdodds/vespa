require 'rest_client'
require 'nokogiri'
require 'JSON'

# Simple representation of a topic
class Topic

	def initialize(server,port,context,topic,subscriber)
		@server = server
		@port = port
		@context = context
		@topic = topic
		@subscriber = subscriber
		@base_url = "http://#{@server}:#{@port}/#{@context}/topics/#{@topic}"
		descriptor = RestClient.get(@base_url)
		@name = Nokogiri::XML(descriptor).xpath('/topic/name/text()')
		@create_url = Nokogiri::XML(descriptor).xpath("/topic/link[@rel='create']/@href").text
		@pull_url = Nokogiri::XML(descriptor).xpath("/topic/link[@rel='pull-consumers']/@href").text
		warn "Connected to topic #{@name}"
		# warn "Create URL [#{@create_url}]"
		# warn "Pull URL [#{@pull_url}]"
	end

	def info
		puts ""
	end

	def enqueue(payload,durable)
		warn "Pushing message [#{payload}]"
		response = RestClient.post("#{@create_url}?durable=#{durable}",payload,{:contentType=>"application/xml"})
		raise "Message not created" if response.code != 201
		warn "Message created at #{response.headers[:date]}"
	end

	def dequeue(durable)
		lookup = RestClient.post(@pull_url,{:durable=>durable,:name=>@subscriber})
		warn "Getting message from [#{lookup.headers[:msg_consume_next]}]"
		message_response = RestClient.post(lookup.headers[:msg_consume_next],{:durable=>durable,:name=>@subscriber})
		puts message_response
	end
end