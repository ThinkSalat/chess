# PHASE 2
def convert_to_int(str)
  num = Integer(str)
rescue ArgumentError => e
  puts e.message
ensure
  num ||= nil 
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == 'coffee'
    raise CoffeeError
  else
    raise NotFruitError
  end
end

def feed_me_a_fruit

  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
begin
  maybe_fruit = gets.chomp
  reaction(maybe_fruit)
rescue CoffeeError => e
  puts e.message
  puts "feed me another fruit"
  retry
rescue NotFruitError => e
  puts e.message
end
end

class NotFruitError < ArgumentError
  def message
    "that's not the fruit I want! :("
  end
end
class CoffeeError < ArgumentError
  def message
    "I've had enough coffee!!!!!!!"
  end
end
# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
    raise ArgumentError.new("Years known must be more than 5") if yrs_known.to_i < 5
    raise ArgumentError.new("Name and pasttime must be filled out") if fav_pastime.empty? || name.empty?
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
