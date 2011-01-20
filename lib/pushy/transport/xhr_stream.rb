module Pushy
  module Transport
    class XhrStream < Base
      MAX_BYTES_SENT = 1048576 # Magic number taken from Orbited
      
      register :xhr_stream
      
      def headers
        {'Content-Type','application/x-event-stream'}
      end
      
      def opened
        # Safari requires a padding of 256 bytes to render
        @sent = 256
        renderer.call [" " * 256]
      end

      def write_raw(escaped_data, parms={})
        puts "writing"
        @sent += escaped_data.size
        renderer.call [escaped_data]
        if parms[:close_connection] || (@sent > MAX_BYTES_SENT)
          EM.next_tick { renderer.succeed }
        end
      end

      def ping
        puts "pinging"
        @sent += 1
        renderer.call [' ']
      end

    end
  end
end
