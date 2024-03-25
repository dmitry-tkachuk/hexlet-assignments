# frozen_string_literal: true

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    start_time = Time.now
    status, headers, response = @app.call(env)
    end_time = Time.now
    execution_time = (end_time - start_time) * 1_000_000 # in microseconds
    puts "Execution time: #{execution_time} microseconds"
    [status, headers, response]
  end
end
