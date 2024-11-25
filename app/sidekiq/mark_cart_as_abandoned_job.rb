class MarkCartAsAbandonedJob
  include Sidekiq::Job

  def perform(*args)
    Cart.where(abandoned: nil).where('last_interaction_at < ?', 3.hour.ago).update_all(abandoned: true)
    Cart.where("last_interaction_at < ?", 1.week.ago - 3.hours).destroy_all
  end
end
