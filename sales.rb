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
    @price = price.to_i
    self.class.list[name] += [price.to_i]
    self.class.total += price.to_i
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
puts Product.total

