statistics_logfile = File.open("#{Rails.root}/log/statistics.log", 'a')
statistics_logfile.sync = true
STAT_LOG = StatisticsLogger.new(statistics_logfile)
