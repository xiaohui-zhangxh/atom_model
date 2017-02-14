module AtomModel
  class StringFeature < Feature
    def mount_to(klass)
      super
      key = self.key
      mount_to_klass klass do
        define_method key do
          instance_variable_get("@#{key}").to_s.presence
        end
      end
    end
  end
end
