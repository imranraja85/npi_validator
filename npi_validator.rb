class NpiValidator
  attr_reader :npi, :npi_without_check_digit, :supplied_check_digit

  def initialize(npi)
    @npi = npi
    @npi_without_check_digit, @supplied_check_digit = extract_id_and_check_digit(npi)
  end

  def check_digit
    rounded_sum_of_digits - sum_of_digits
  end

  def valid?
    check_digit.to_i == supplied_check_digit
  end

  private

  def extract_id_and_check_digit(number)
    number = number.to_s.split("")
    [number[0..8], number[9].to_i]
  end

  def double_alternate_digits
    npi_without_check_digit.select.with_index {|element,index| index.even?}.map {|x| x.to_i * 2}
  end

  def sum_individual_product_digits
    double_alternate_digits.map {|digit| digit.to_s.split("").map(&:to_i)}.flatten
  end

  def unaffected_digits
    npi_without_check_digit.select.with_index {|element,index| index.odd?}.map(&:to_i)
  end

  def sum_of_digits
    (unaffected_digits + sum_individual_product_digits).inject(0, :+) + 24
  end

  def rounded_sum_of_digits
    sum_of_digits % 10 == 0 ? sum_of_digits : sum_of_digits + 10 - (sum_of_digits % 10)
  end
end
