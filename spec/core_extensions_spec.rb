require "spec_helper"

describe Array do
	context "#all_empty?" do
		it "returns true if all elements of the array are empty" do
			expect(["","","",].all_empty?).to be true
		end

		it "returns false if some of the array elements aren't empty" do
			expect(["", 1, "", Object.new, :a].all_empty?).to be false
		end

		it "returns true for an empty array" do
			expect([].all_empty?).to be true
		end
	end

	context "#all_same?" do
		it "returns true if all elements of the array are the same" do
			expect(["A", "A", "A"].all_same?).to be true
		end

		it "returns true if some of the array elements aren't the same" do
			expect(["", 1, "", Object.new, :a].all_same?).to be false
		end

		it "returns true for an empty array" do
			expect([].all_same?).to be true
		end
	end

	context "#any_empty?" do
		it "returns true if any element of the array is empty" do
			expect([1,:a, ""].any_empty?).to be true
		end

		it "returns false if none of the array elements is empty" do
			expect([1,"bork", :zdzichu].any_empty?).to be false
		end

		it "returns false for an empty array" do
			expect([].any_empty?).to be false
		end
	end

	context "#none_empty?" do
		it "returns true if none of the array elements is empty" do
			expect(["meow", :meow, 8].none_empty?).to be true
		end

		it "returns false if some of the array elements aren't empty" do
			expect(["", 4, :barf].none_empty?).to be false
		end

		it "returns true for an empty array" do
			expect([].none_empty?).to be true
		end
	end

end