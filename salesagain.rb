module Tax

  YES_REGEX = /y|(es)/
  NO_REGEX = /n|(o)/

  def tax(imported, sales_tax, import_rate = 0.05, sales_tax_rate = 0.1 )
    if sales_tax.match? NO_REGEX
      @sales_tax = @price * sales_tax_rate
    else
      @sales_tax = 0
    end
    if imported.match? YES_REGEX
      @import_tax =  @price * import_rate
    else
      @import_tax = 0
    end
  end
end

class Product

  attr_reader :price, :name, :sales_tax, :import_tax

  include Tax

  def initialize(name, price)
    @name = name
    @price = price.to_f
  end
end

class Cart

  attr_accessor :cart

  def initialize
    @cart = []
  end

  def add(product)
    @cart << product
  end
end

class Invoice

  @total = 0

  def initialize(list)
    puts 'name'.ljust(15) + 'price'.ljust(15) + 'sales_tax'.ljust(15) + 'import_tax'.ljust(15) + 'price with tax'.ljust(15)
    list.each do |details|
      print details.name.ljust(15) + details.price.to_s.ljust(15) + details.sales_tax.to_s.ljust(15) + details.import_tax.to_s.ljust(15)
      price_after_tax = details.price + details.sales_tax + details.import_tax
      puts price_after_tax.to_s.ljust(15)
      self.class.total += price_after_tax
    end
    puts 'Total Amount'.ljust(60) + self.class.total.to_s
  end

  class << self
    attr_accessor :total
  end
end

list = Cart.new
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
  product.tax(imported, sales_tax)
  list.add(product)
  puts 'Do you want to add more items to your list(y/n): '
  more_input = gets.chomp
end

Invoice.new(list.cart)
