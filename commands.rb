# frozen-string-literal: true

# Commands for the user to interact with the tree
module Commands
  def use
    methods = {
      'level order' => 'level_order',
      'l' => 'level_order',
      'inorder' => 'inorder',
      'preorder' => 'preorder',
      'postorder' => 'postorder',
      'delete' => 'delete_prep',
      'insert' => 'insert',
      'find' => 'find',
      'balanced?' => 'balanced?',
      'height' => 'height_prep',
      'depth' => 'depth',
      'rebalance' => 'rebalance',
      'build' => 'rebuild',
      'c' => 'commands',
      'clear' => 'clear',
      'print' => 'pretty_print'
    }
  end

  def commands
    commands_list = [
                      ['3', 'l or level order --> use level-order traversal'], ['2', 'inorder --> use in-order traversal'],
                      ['4', 'preorder --> use pre-order traversal'], ['6', 'postorder --> use post-order traversal'],
                      ['1', 'delete --> delete the specified value'], ['82', 'insert --> add the specified value'],
                      ['11', 'find --> find the specified value'], ['14', 'balanced? --> true if tree is balanced'],
                      ['99', 'height --> height of specified value'], ['190', 'depth --> height of tree from root node'],
                      ['43', 'rebalance --> make the tree balanced'], ['220', 'build --> builds a new tree'],
                      ['194', 'print --> displays tree'], ['226', 'clear --> clears the screen'],
                      ['207', 'c --> lists these commands'], ['105', 'driver --> computer interacts with the tree']
                    ]
    puts 'The commands are: '
    commands_list.each { |command| puts "\e[38;5;#{command[0]}m#{command[1]}\e[0m" }
  end

  def call_methods(action)
    puts
    if %w[delete_prep insert height_prep].include? action
      arg = enter_msg
      send(action, arg)
    elsif %w[level_order inorder postorder preorder].include? action
      nodes = send(action)
      puts "#{action.capitalize}: "
      nodes.each { |node| print "\e[38;5;#{node}m#{node}\e[0m " }
    elsif action == 'find'
      arg = enter_msg
      found = send(action, arg)
      pretty_print(found[0]) unless found.nil?
    elsif action == 'clear'
      system('clear')
    else
      send(action)
    end
  end

  def welcome
    puts %(
      Welcome to the \e[95mBinary Search Tree\e[0m (BST) program.
      Here you can enter different \e[1mcommands\e[0m to interact with the tree.
      A BST use pointers, similar to a linked list. However, it has a left and right pointers rather than next.
      Starting from a list, a tree is built, using the mid-points of the array and sub-arrays to define "parent" nodes.
      The left pointer then points to a lower value, the right pointer a higher value.
      That's it for the brief intro, I hope you enjoy the program! Let me know if you have any feedback.
    )
    commands
  end

  def prompt
    puts
    print 'Please enter a valid command \'q\' to quit: '
  end

  def valid?(command)
    use.include? command
  end

  def enter_msg
    print 'Please enter a positive integer (non-numerical values will default to 0): '
    gets.chomp.to_i
  end
end
