class TrailerInformationModal < BaseModal
  SELECT_FIELD_HOOKS ||= CptHook.define_hooks do
    before(:select).call(->(e) { e.scroll.to }).with(:self)
    before(:select).call(:click)
  end
  SCROLL_HOOKS ||= CptHook.define_hooks do
    before(:select).call(->(e) { e.scroll.to }).with(:self)
  end

  text_field(:year, id: /year/)
  text_field(:make, id: /make/)
  text_field(:model, id: /model/)
  text_field(:identification_number, id: /length/)
  text_field(:physical_damage_limit, id: /physicalDamageLimit/)
  select(:deductible, id: /deductible/, hooks: SELECT_FIELD_HOOKS)
end