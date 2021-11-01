# frozen_string_literal: true

class InsuranceScoreRow < BaseSection
  td(:score, data_label: /Score/)
end

class InsuranceScoreSection < BaseSection


  # ------ Everything below this line is unverified ------------------------------------- #
  #------- Paste your verified items above this line so we know whats been fixed!!
  #
  #

  data_grid(:insurance_scores, InsuranceScoreRow) # was "insurance_score_grid" prior to Angular AMN 1-22-2020 # , id: /DataTables_Table_[0-9][0-9]*_wrapper/)
end
