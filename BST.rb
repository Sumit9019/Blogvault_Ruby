
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

  def find_min
    current = @root
    current = current.left until current.left.nil?
    current.value
  end

  def find_max
    current = @root
    current = current.right until current.right.nil?
    current.value
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

class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

def run_bst_application
  bst = BinarySearchTree.new

  puts "Enter the filename to load data from (or press Enter to skip):"
  file_name = gets.chomp
  bst.load_from_file(file_name) unless file_name.empty?

  loop do
    puts "\nWhat would you like to do?"
    puts "1. Insert multiple numbers into the tree"
    puts "2. Search for a number"
    puts "3. Show the tree in Inorder"
    puts "4. Show the tree in Preorder"
    puts "5. Show the tree in Postorder"
    puts "6. Show the tree in Level Order"
    puts "7. Delete a number"
    puts "8. Show all root-to-leaf paths"
    puts "9. Find the smallest number"
    puts "10. Find the largest number"
    puts "11. Save tree data to a file"
    puts "12. Exit"

    choice = gets.chomp.to_i

    case choice
    when 1
      puts "Enter multiple numbers to insert (comma-separated):"
      values = gets.chomp.split(",").map(&:to_i)
      values.each { |value| bst.insert(value) }
      puts "#{values.join(", ")} have been inserted into the tree."
    when 2
      puts "Enter a number to search for:"
      value = gets.chomp.to_i
      puts bst.search(value)
    when 3
      puts "Inorder (Left, Root, Right) traversal:"
      bst.inorder_traversal
    when 4
      puts "Preorder (Root, Left, Right) traversal:"
      bst.preorder_traversal
    when 5
      puts "Postorder (Left, Right, Root) traversal:"
      bst.postorder_traversal
    when 6
      puts "Level Order (Breadth-First Search) traversal:"
      bst.level_order_traversal
    when 7
      puts "Enter a number to delete:"
      value = gets.chomp.to_i
      bst.delete(value)
      puts "#{value} has been deleted from the tree."
    when 8
      puts "Root-to-leaf paths:"
      bst.print_all_paths
    when 9
      puts "The smallest number in the tree is #{bst.find_min}"
    when 10
      puts "The largest number in the tree is #{bst.find_max}"
    when 11
      puts "Enter filename to save tree data:"
      filename = gets.chomp
      bst.save_to_file(filename)
      puts "Tree data has been saved to #{filename}."
    when 12
      puts "Goodbye!"
      break
    else
      puts "Sorry, I didn't understand that choice. Please try again."
    end
  end
end
run_bst_application

