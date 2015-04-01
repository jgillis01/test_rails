require 'yaml'
require 'resque' # include resque so we can configure it
require 'resque-scheduler' # include the resque_scheduler (this makes the tabs show up)
require 'resque/scheduler/server'

Resque.redis = 'localhost:6379'
require './test_worker.rb'

Resque.schedule = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'config', 'resque_schedule.yml')) # load the schedule
