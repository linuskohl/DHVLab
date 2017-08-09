#load libraries
require(anytime)
require(xts)
require(ggplot2)
require(ggthemes)
plot_color <- "#3399ff"

#load statistics
logs = read.csv("/home/linus/delete_me/stats.log")
#convert UNIX timestamp to POSIXct
logs$timestamp <- anytime(logs$timestamp, tz="CET")
logs$number_users <- as.integer(logs$number_users)

#add weekday to df
logs$weekday <- format(as.Date(logs$timestamp), "%A")
#add hour to df
logs$hour <- format(logs$timestamp, "%H")

#STATS
#number of users
cat(sprintf("Avg. parallel users: \t %0.4s", mean(logs$number_users)), "\n")
cat(sprintf("Max. parallel users: \t %0.4s", max(logs$number_users)), "\n")

#cpu usage
cat(sprintf("Min. parallel users: \t %0.4s", min(logs$cpu_usage)), "\n")
cat(sprintf("Avg. parallel users: \t %0.4s", mean(logs$cpu_usage)), "\n")
cat(sprintf("Max. parallel users: \t %0.4s", max(logs$cpu_usage)), "\n")

#memory usage
cat(sprintf("Min. parallel users: \t %0.4s", min(logs$memory_usage)), "\n")
cat(sprintf("Avg. parallel users: \t %0.4s", mean(logs$memory_usage)), "\n")
cat(sprintf("Max. parallel users: \t %0.4s", max(logs$memory_usage)), "\n")

#calculate average tables 
averages_memory  <- aggregate(logs$memory_usage, list(logs$number_users), mean)
averages_cpu     <- aggregate(logs$cpu_usage,    list(logs$number_users), mean)
users_by_weekday <- aggregate(logs$number_users,  list(logs$weekday), mean)
users_by_hour    <- aggregate(logs$number_users,  list(logs$hour), mean)

#plot average memory usage according to logged in users
ggplot(averages_memory, aes( y=x, x=Group.1)) +
  geom_bar(stat="identity",fill=plot_color) +
  theme_pander() +
  labs(y = "Avg. % Memory Usage") +
  labs(x = "Number parallel users") +
  ylim(0, 100)

#plot average CPU usage according to logged in users
ggplot(averages_cpu, aes( y=x, x=Group.1)) +
  geom_bar(stat="identity",fill=plot_color) +
  theme_pander() +
  labs(y = "Avg. % CPU Usage") +
  labs(x = "Number parallel users") +
  ylim(0, 100)

#plot average users by weekday
ggplot(users_by_weekday, aes( y=x, x=factor(users_by_weekday$Group.1, weekdays(as.Date('1970-01-03') + 1:7)))) +
  geom_bar(stat="identity", fill=plot_color) +
  theme_pander() +
  labs(y = "Avg. number parallel users") +
  labs(x = "Day of week")

#plot average users by time of day
ggplot(users_by_hour, aes( y=x, x=Group.1)) +
  theme_pander() +
  geom_bar(stat="identity",fill=plot_color) +
  labs(y = "Avg. number parallel users") +
  labs(x = "Hour of day")

