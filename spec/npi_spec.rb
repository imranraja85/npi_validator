require_relative '../npi_validator'

describe "NpiValidator" do
  it "returns the npi" do
    expect(NpiValidator.new(123456789).npi).to eq(123456789)
  end

  it "returns the supplied check digit" do
    expect(NpiValidator.new(1234567893).supplied_check_digit).to eq(3)
  end

  it "returns the check digit" do
    expect(NpiValidator.new(123456789).check_digit).to eq(3)
  end

  it "returns true if its a valid NPI " do
    expect(NpiValidator.new(1234567893).valid?).to eq(true)
    expect(NpiValidator.new(1215965934).valid?).to eq(true)
    expect(NpiValidator.new(1104084334).valid?).to eq(true)
    expect(NpiValidator.new(1285652024).valid?).to eq(true)
    expect(NpiValidator.new(1356320139).valid?).to eq(true)
  end

  it "returns false if its not a valid NPI " do
    expect(NpiValidator.new(1265795159).valid?).to eq(false)
    expect(NpiValidator.new(144750284).valid?).to eq(false)
    expect(NpiValidator.new(1932224400).valid?).to eq(false)
  end
end
