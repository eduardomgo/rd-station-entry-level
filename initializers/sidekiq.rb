require 'sidekiq/scheduler'

Sidekiq::Scheduler.dynamic = true
Sidekiq::Scheduler.reload_schedule!