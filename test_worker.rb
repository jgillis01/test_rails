# this is a test worker
class TestWorker
  @queue = :test_worker

  def self.perform
    puts 'Test Successful'
  end
end
