module Tax
  def sales(sales_tax)
    if sales_tax.eql? 'no'
      self.class.list[name] += [price*0.1]
      self.class.total += price*0.1
    else
      self.class.list[name] += [0]
    end
  end

  def import(imported)
    if imported.eql? 'yes'
      self.class.list[name] += [price*0.05]
      self.class.total += price*0.05
    else
      self.class.list[name] += [0]
    end
  end
end

class Product
  @list = Hash.new([])
  @total = 0
  include Tax
  attr_reader :name, :price

  class << self
    attr_accessor :list, :total
  end

  def initialize(name, price)
    @name = name
    @price = price.to_f
    self.class.list[name] += [price.to_f]
    self.class.total += price.to_f
  end
end

more_input = 'y'
while more_input.eql? 'y'
  print 'Name of the product: '
  name = gets.chomp
  print 'Imported?: '
  imported = gets.chomp
  print 'Exempted from sales tax: '
  sales_tax = gets.chomp
  print 'Price: '
  price = gets.chomp
  product = Product.new(name, price)
  product.sales(sales_tax)
  product.import(imported)
  puts 'Do you want to add more items to your list(y/n): '
  more_input = gets.chomp
end
puts 'name'.ljust(15) + 'price'.ljust(15) + 'sales_tax'.ljust(15) + 'import_tax'.ljust(15) + 'price with tax'.ljust(15)
Product.list.each { |name, values| puts name.ljust(15) + values[0].to_s.ljust(15) + values[1].to_s.ljust(15) + values[2].to_s.ljust(15) + values.sum.to_s.ljust(15) }
puts ""
puts 'Total Amount'.ljust(60) + Product.total.to_s
