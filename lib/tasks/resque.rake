require 'resque'
require 'resque/tasks'
require 'resque/pool/tasks'

namespace :resque do
  task :setup => :environment do
    ActiveRecord::Base.descendants.each { |klass| klass.columns }
    Resque.before_first_fork do
      # AFTER the pool forks a master worker, BEFORE the master forks its first child
    end

    Resque.before_fork do |job|
      # AFTER the pool forks a master worker, BEFORE the master forks ANY child
    end

  end

  namespace :pool do
    task :setup do
      # close any sockets or files in pool manager
      ActiveRecord::Base.connection.disconnect!

      # and re-open them in the resque worker parent
      Resque::Pool.after_prefork do |job|
        # BEFORE before_first_fork, AFTER pool forks a master
        ActiveRecord::Base.establish_connection
        Resque.redis.client.reconnect
      end
    end
  end
end
