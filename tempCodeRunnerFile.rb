def inorder(root = @root)
    result = []
    result << put_in_order(root) until result.size == Node.count
    result
  end