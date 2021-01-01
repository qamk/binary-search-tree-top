# frozen-string-literal: true

def driver(obj)
  puts "Beep. Boop. Initiating \e[38;5;105mdriver\e[0m code..."
  driver_balanced?(obj)
  traverse(obj)
  puts "Ok, \e[38;5;82madding\e[0m some premium, carefully selected and meaningful numbers..."
  adding(obj)
  driver_balanced?(obj)
  driver_rebalance(obj)
  traverse(obj)
  obj.pretty_print
  puts "Beep. Boop. Ending program and \e[38;5;105mdriver\e[0m code..."
end

def driver_balanced?(obj)
  wait('1.9')
  print "Let's see if the tree is \e[38;5;14mbalanced?\e[0m: "
  obj.balanced?
end

def driver_rebalance(obj)
  puts "Let's \e[38;5;43mrebalance\e[0m it... "
  wait('1.9')
  obj.rebalance
  driver_balanced?(obj)
end

def wait(sec)
  puts 'One moment...'
  system("sleep #{sec}")
  puts 'OK.'
end

def traverse(obj)
  wait('3.1')
  puts "Hmm... Let's \e[38;5;4mtraverse\e[0m this tree..."
  puts "Level-order: #{obj.level_order}"
  wait('1.5')
  puts "In-order: #{obj.inorder}"
  wait('1.5')
  puts "Pre-order: #{obj.preorder}"
  wait('1.5')
  puts "Post-order: #{obj.postorder}"
end

def adding(obj)
  wait('3.1')
  meaningful_nums = Array.new(rand(3..7)) { rand(250..594) }
  meaningful_nums.each { |num| obj.insert(num) }
end
