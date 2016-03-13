# require 'rack'
require 'socket'
require 'pry'

#Below is the ruby code for setting up a simple rack server
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#================= Steps that Still Need to be Completed =============================
#1. [ done ] define server as server = TCPServer ( :host, :port)
#2. [ done ] TCPServer.accept = socket
#3. [  ]socket.parse  (where parse is our method for parsing the steam, has to be unit tested)
#4. [  ]****** parse will return a hash *******
#5. [  ]****** hash is handed to @app *******
#6. [  ]***** app returns an array of [status, headers, body] *******
#7. [  ]***** socket.print/puts array *********
#8. [  ]***** close the socket **********
#9. [  ]***** next iteration: for multiple request handling, set up a loop *****
#10.[  ]***** ATSOME POINT figure out where/when in code to close server ***********
#
#
#
#***for unit test might need rack.input as a commmand of some sort ****
#*** unit test also needs to use stringerIO to feed string *********c

class Notes
  class Web
    def initialize(app, address)
      @port = address[:Port]
      @host = address[:Host]
      @app = app

      @server = TCPServer.new @host, @port
    end

    def stop
      @server.close
    end

    def start

      loop do
        socket = @server.accept

        response = @app.call({})
        env = {}
        # require "pry"
        # binding.pry
        method, path, http_version = socket.gets.chomp.split(" ")
        env['PATH_INFO']      = path
          # require "pry"
          # binding.pry
        status = response[0]
        socket.print "#{http_version} #{status} OK\r\n"
        response[1].each_pair do |key, value|
          socket.print "#{key}: #{value}" + "\r\n"
        end
        body = response[2][0]
        socket.print "\r\n"

        socket.print body
        #socket.print path_info
        socket.close
      end
      path = path_info
      path
    end
  end
end
