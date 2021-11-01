# frozen_string_literal: true

# This is a straight cut and paste job from active support

class Hash
  # Replaces the hash with only the given keys.
  # Returns a hash containing the removed key/value pairs.
  #
  #   hash = { a: 1, b: 2, c: 3, d: 4 }
  #   hash.slice!(:a, :b)  # => {:c=>3, :d=>4}
  #   hash                 # => {:a=>1, :b=>2}
  def slice!(*keys)
    omit = slice(*self.keys - keys)
    hash = slice(*keys)
    hash.default      = default
    hash.default_proc = default_proc if default_proc
    replace(hash)
    omit
  end

  # Removes and returns the key/value pairs matching the given keys.
  #
  #   { a: 1, b: 2, c: 3, d: 4 }.extract!(:a, :b) # => {:a=>1, :b=>2}
  #   { a: 1, b: 2 }.extract!(:a, :x)             # => {:a=>1}
  def extract!(*keys)
    keys.each_with_object(self.class.new) { |key, result| result[key] = delete(key) if key?(key) }
  end

  def stringify_keys
    new_hash = {}
    keys.each { |k| new_hash[k.to_s] = self[k] }
    return new_hash
  end

  def stringify_keys!
    old_keys = keys.dup
    old_keys.each { |k| self[k.to_s] = delete(k) }
    return self
  end
end

module Enumerable
  # Returns +true+ if the enumerable has more than 1 element. Functionally
  # equivalent to <tt>enum.to_a.size > 1</tt>. Can be called with a block too,
  # much like any?, so <tt>people.many? { |p| p.age > 26 }</tt> returns +true+
  # if more than one person is over 26.
  def many?
    cnt = 0
    if block_given?
      any? do |element|
        cnt += 1 if yield element
        cnt > 1
      end
    else
      any? { (cnt += 1) > 1 }
    end
  end

  # Convert an enumerable to an array based on the given key.
  #
  #   [{ name: "David" }, { name: "Rafael" }, { name: "Aaron" }].pluck(:name)
  #   # => ["David", "Rafael", "Aaron"]
  #
  #   [{ id: 1, name: "David" }, { id: 2, name: "Rafael" }].pluck(:id, :name)
  #   # => [[1, "David"], [2, "Rafael"]]
  def pluck(*keys)
    if keys.many?
      map { |element| keys.map { |key| element[key] } }
    else
      map { |element| element[keys.first] }
    end
  end
end
