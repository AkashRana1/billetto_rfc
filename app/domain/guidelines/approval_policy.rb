module Guidelines
  class JustEnoughApprovalPolicy
    def satisfied?(value)
      value >= 2
    end
  end
end
