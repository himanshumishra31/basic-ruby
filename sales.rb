# Sales class calculates total bill
class Sales
  @total = 0
  @bill = Hash.new([])
  attr_accessor :total, :bill
  def self.calculate(product, imported, tax, price)
    @bill[product] += [price]
    import_tax = 0.05 * price.to_i if imported.eql? 'yes'
    @bill[product] += [import_tax]
    sales_tax = 0.10 * price.to_i if tax.eql? 'no'
    @bill[product] += [sales_tax]
    price_after_tax = price.to_i + sales_tax + import_tax
    @total += price_after_tax.to_i
    @bill[product] += [price_after_tax]
  end

  class << self
    attr_reader :total, :bill
  end
end

more_input = 'y'
while more_input.eql? 'y'
  print 'Name of the product: '
  product = STDIN.gets.chomp
  print 'Imported?: '
  imported = STDIN.gets.chomp
  print 'Exempted from sales tax? '
  tax = STDIN.gets.chomp
  print 'Price: '
  price = STDIN.gets.chomp
  Sales.calculate(product, imported, tax, price)
  print 'Do you want to add more items to your list(y/n): '
  more_input = STDIN.gets.chomp
  puts ''
end
puts "Total Bill Amount #{Sales.total.round}"
puts Sales.bill
