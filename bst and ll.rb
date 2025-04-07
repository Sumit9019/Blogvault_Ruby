class Node
    attr_accessor :value, :next_node, :left, :right
  
    def initialize(value)
      @value = value
      @next_node = nil
      @left = nil
      @right = nil
    end
  end
  
  class BinarySearchTree
    attr_reader :root
  
    def initialize
      @root = nil
    end
  
    def insert(value)
      @root = insert_recursive(@root, value)
    end
  
    def insert_recursive(node, value)
      return Node.new(value) if node.nil?
  
      if value < node.value
        node.left = insert_recursive(node.left, value)
      elsif value > node.value
        node.right = insert_recursive(node.right, value)
      end
  
      node
    end
  
    def inorder_traversal
      inorder_recursive(@root)
      puts
    end
  
    def inorder_recursive(node)
      return if node.nil?
  
      inorder_recursive(node.left)
      print "#{node.value} "
      inorder_recursive(node.right)
    end
  
    def preorder_traversal
      preorder_recursive(@root)
      puts
    end
  
    def preorder_recursive(node)
      return if node.nil?
  
      print "#{node.value} "
      preorder_recursive(node.left)
      preorder_recursive(node.right)
    end
  
    def postorder_traversal
      postorder_recursive(@root)
      puts
    end
  
    def postorder_recursive(node)
      return if node.nil?
  
      postorder_recursive(node.left)
      postorder_recursive(node.right)
      print "#{node.value} "
    end
  
    def level_order_traversal
      return if @root.nil?
  
      queue = [@root]
      while !queue.empty?
        node = queue.shift
        print "#{node.value} "
  
        queue.push(node.left) if node.left
        queue.push(node.right) if node.right
      end
      puts
    end
  
    def search(value)
      result = search_recursive(@root, value)
      result.nil? ? "Not Found" : "Found"
    end
  
    def search_recursive(node, value)
      return nil if node.nil?
  
      return node if node.value == value
  
      if value < node.value
        search_recursive(node.left, value)
      else
        search_recursive(node.right, value)
      end
    end
  
    def delete(value)
      @root = delete_recursive(@root, value)
    end
  
    def delete_recursive(node, value)
      return node if node.nil?
  
      if value < node.value
        node.left = delete_recursive(node.left, value)
      elsif value > node.value
        node.right = delete_recursive(node.right, value)
      else
        return node.right if node.left.nil?
        return node.left if node.right.nil?
  
        min_node = find_min_node(node.right)
        node.value = min_node.value
        node.right = delete_recursive(node.right, min_node.value)
      end
  
      node
    end
  
    def find_min_node(node)
      current = node
      current = current.left until current.left.nil?
      current
    end
  
    def print_all_paths
      print_paths_recursive(@root, [])
    end
  
    def print_paths_recursive(node, path)
      return if node.nil?
  
      path.push(node.value)
  
      if node.left.nil? && node.right.nil?
        puts path.join(" -> ")
      else
        print_paths_recursive(node.left, path.clone)
        print_paths_recursive(node.right, path.clone)
      end
    end
  
    def save_to_file(file_name)
      File.open(file_name, 'w') do |file|
        inorder_to_file(@root, file)
      end
    end
  
    def inorder_to_file(node, file)
      return if node.nil?
  
      inorder_to_file(node.left, file)
      file.puts(node.value)
      inorder_to_file(node.right, file)
    end
  
    def load_from_file(file_name)
      return unless File.exist?(file_name)
  
      File.open(file_name, 'r') do |file|
        file.each_line do |line|
          insert(line.to_i)
        end
      end
    end
  end
  
  class SinglyLinkedList
    attr_reader :head
  
    def initialize
      @head = nil
    end
  
    def insert_at_head(value)
      new_node = Node.new(value)
      new_node.next_node = @head
      @head = new_node
    end
  
    def insert_at_tail(value)
      new_node = Node.new(value)
      if @head.nil?
        @head = new_node
      else
        current = @head
        current = current.next_node while current.next_node
        current.next_node = new_node
      end
    end
  
    def insert_at_position(value, position)
      return insert_at_head(value) if position == 1
  
      new_node = Node.new(value)
      current = @head
      (position - 2).times { current = current.next_node if current }
      return unless current
  
      new_node.next_node = current.next_node
      current.next_node = new_node
    end
  
    def search(value)
      current = @head
      while current
        return "Found" if current.value == value
        current = current.next_node
      end
      "Not Found"
    end
  
    def delete(value)
      return if @head.nil?
  
      if @head.value == value
        @head = @head.next_node
        return
      end
  
      current = @head
      while current.next_node
        if current.next_node.value == value
          current.next_node = current.next_node.next_node
          return
        end
        current = current.next_node
      end
    end
  
    def reverse
      prev = nil
      current = @head
      while current
        next_node = current.next_node
        current.next_node = prev
        prev = current
        current = next_node
      end
      @head = prev
    end
  
    def print_list
      current = @head
      while current
        print "#{current.value} "
        current = current.next_node
      end
      puts
    end
  end
  
  def run_application
    bst = BinarySearchTree.new
    ll = SinglyLinkedList.new
    current_structure = nil
  
    loop do
      puts "\nSelect data structure (1: BST, 2: Linked List, 3: Quit):"
      structure_choice = gets.chomp.to_i
  
      case structure_choice
      when 1
        current_structure = bst
        puts "Switched to Binary Search Tree (BST)"
      when 2
        current_structure = ll
        puts "Switched to Singly Linked List"
      when 3
        puts "Exiting the program."
        break
      else
        puts "Invalid choice, please try again."
        next
      end
  
      loop do
        puts "\nSelect an operation:"
        puts "1. Insert a value"
        puts "2. Search for a value"
        puts "3. Delete a value"
        puts "4. Print the structure"
        puts "5. Reverse (LL only)"
        puts "6. Quit to main menu"
  
        operation_choice = gets.chomp.to_i
  
        case operation_choice
        when 1
          puts "Enter value to insert:"
          value = gets.chomp.to_i
          if current_structure == bst
            current_structure.insert(value)
            puts "#{value} inserted into BST."
          else
            puts "Select insertion point (1: Head, 2: Tail, 3: Position):"
            insert_point = gets.chomp.to_i
            case insert_point
            when 1
              current_structure.insert_at_head(value)
              puts "#{value} inserted at head."
            when 2
              current_structure.insert_at_tail(value)
              puts "#{value} inserted at tail."
            when 3
              puts "Enter position:"
              position = gets.chomp.to_i
              current_structure.insert_at_position(value, position)
              puts "#{value} inserted at position #{position}."
            else
              puts "Invalid option."
            end
          end
        when 2
          puts "Enter value to search for:"
          value = gets.chomp.to_i
          puts current_structure.search(value)
        when 3
          puts "Enter value to delete:"
          value = gets.chomp.to_i
          current_structure.delete(value)
          puts "#{value} deleted."
        when 4
          if current_structure == bst
            puts "Inorder Traversal:"
            current_structure.inorder_traversal
          else
            puts "Linked List:"
            current_structure.print_list
          end
        when 5
          if current_structure == ll
            current_structure.reverse
            puts "Linked List reversed."
          else
            puts "Reverse operation is only available for Linked List."
          end
        when 6
          puts "Returning to main menu."
          break
        else
          puts "Invalid choice. Please try again."
        end
      end
    end
  end
  
  run_application
  