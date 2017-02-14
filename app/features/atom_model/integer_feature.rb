module AtomModel
  class IntegerFeature < Feature
    def mount_to(klass)
      super
      key = self.key
      mount_to_klass klass do
        validates_numericality_of key, only_integer: true, allow_nil: true
      end
    end
  end
end
