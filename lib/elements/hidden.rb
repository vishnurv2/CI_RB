# frozen_string_literal: true

HIDDEN_SET = lambda { |name, cont, value|
  e = cont.send("#{name}_element")
  e.execute_js(:setValue, e, value.to_s)
}

EDSL.define_accessor(:hidden, how: :hidden, default_method: :value, assign_method: HIDDEN_SET)

EDSL.define_accessor(:file_field, how: :file_field, default_method: :value, assign_method: :set)
