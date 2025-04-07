
class Node
    attr_accessor :data, :next
  
    def initialize(data)
      @data = data
      @next = nil
    end
  end
  
  class LinkedList
    def initialize
      @head = nil
    end
  
    def insert_at_head(data)
      node = Node.new(data)
      node.next = @head
      @head = node
    end
  
    def insert_at_tail(data)
      node = Node.new(data)
      if @head.nil?
        @head = node
        return
      end
      temp = @head
      temp = temp.next while temp.next
      temp.next = node
    end
  
    def insert_at_position(data, pos)
      if pos <= 1 || @head.nil?
        insert_at_head(data)
        return
      end
  
      node = Node.new(data)
      temp = @head
      (pos - 2).times do
        break if temp.next.nil?
        temp = temp.next
      end
      node.next = temp.next
      temp.next = node
    end
  
    def search(value)
      temp = @head
      pos = 1
      while temp
        return pos if temp.data == value
        temp = temp.next
        pos += 1
      end
      -1
    end
  
    def delete_node(value)
      pos = search(value)
      if pos == -1
        puts "Node with value #{value} not found."
        return
      else
        puts "Node with value #{value} found at position #{pos}. Deleting..."
      end
  
      if @head.data == value
        @head = @head.next
        puts "Node deleted successfully."
        return
      end
  
      temp = @head
      while temp.next && temp.next.data != value
        temp = temp.next
      end
  
      if temp.next
        temp.next = temp.next.next
        puts "Node deleted successfully."
      else
        puts "Unexpected error in deletion."
      end
    end
  
    def reverse
      prev = nil
      curr = @head
      while curr
        nxt = curr.next
        curr.next = prev
        prev = curr
        curr = nxt
      end
      @head = prev
    end
  
    def print_list
      temp = @head
      if temp.nil?
        puts "Linked List is empty."
      else
        print "Linked List: "
        while temp
          print "#{temp.data} -> "
          temp = temp.next
        end
        puts "nil"
      end
    end
  end
  
  # User interaction loop
  ll = LinkedList.new
  
  loop do
    puts "\nChoose an operation:"
    puts "1. Insert at Head"
    puts "2. Insert at Tail"
    puts "3. Insert at Position"
    puts "4. Search a Node"
    puts "5. Delete a Node"
    puts "6. Reverse Linked List"
    puts "7. Print Linked List"
    puts "8. Exit"
    print "Enter choice: "
    choice = gets.chomp.to_i
  
    case choice
    when 1
      print "Enter value to insert at head: "
      ll.insert_at_head(gets.chomp.to_i)
    when 2
      print "Enter value to insert at tail: "
      ll.insert_at_tail(gets.chomp.to_i)
    when 3
      print "Enter value to insert: "
      val = gets.chomp.to_i
      print "Enter position (1-based): "
      pos = gets.chomp.to_i
      ll.insert_at_position(val, pos)
    when 4
      print "Enter value to search: "
      val = gets.chomp.to_i
      pos = ll.search(val)
      if pos == -1
        puts "Value not found."
      else
        puts "Value found at position #{pos}."
      end
    when 5
      print "Enter value to delete: "
      val = gets.chomp.to_i
      ll.delete_node(val)
    when 6
      ll.reverse
      puts "Linked list reversed."
    when 7
      ll.print_list
    when 8
      puts "Exiting..."
      break
    else
      puts "Invalid choice. Try again."
    end
  end
  